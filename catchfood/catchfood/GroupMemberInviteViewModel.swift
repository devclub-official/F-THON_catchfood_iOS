//
//  GroupMemberInviteViewModel.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import RxSwift
import RxCocoa
import UIKit
struct GroupMemberDTO: Codable {
    let data: [String]
}
final class GroupMemberInviteViewModel {
    struct Input {
        let inviteMember: Observable<String>
    }
    
    struct Output {
        let currentMember: Driver<[String]>
        let inviteSuccess: Signal<Void>
    }
    func transform(input: Input) -> Output {
        let id = NicknameStorageService.shared.getPartyId() ?? 1

        let initialMembers = APIService.shared.request(
            APIEndpoint(
                path: "/parties/\(id)/members",
                method: .get,
                headers: ["X-User-Name": NicknameStorageService.shared.getNickname() ?? "Yubin"]
            ),
            type: GroupMemberDTO.self
        )
        .map { $0.data }
        .catchAndReturn([])
        .share(replay: 1)

        // 초대 API 요청 처리
        let invitedMembers = input.inviteMember
            .flatMapLatest { newMember -> Observable<String> in
                let endpoint = APIEndpoint(
                    path: "/parties/\(id)/members",
                    method: .post,
                    parameters: ["memberName": newMember],
                    headers: ["X-User-Name": NicknameStorageService.shared.getNickname() ?? ""]
                )

                return APIService.shared.request(endpoint, type: StatusResponse.self)
                    .map { $0.status == "SUCCESS" ? newMember : "" }
                    .catchAndReturn("")
            }
            .filter { !$0.isEmpty }

        // 멤버 누적
        let allMembers = Observable
            .combineLatest(initialMembers, invitedMembers.scan([]) { acc, new in acc + [new] }.startWith([]))
            .map { initial, added in initial + added }

        let inviteSuccess = invitedMembers
            .map { _ in () } // 성공한 초대만 emit
            .asSignal(onErrorSignalWith: .empty())

        return Output(
            currentMember: allMembers.asDriver(onErrorJustReturn: []),
            inviteSuccess: inviteSuccess
        )
    }
}

