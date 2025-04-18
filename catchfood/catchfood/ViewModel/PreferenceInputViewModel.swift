//
//  PreferenceInputViewModel.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import RxSwift
import RxCocoa
import UIKit

enum PreferenceInputMode {
    case edit
    case view
}
final class PreferenceInputViewModel {
    struct Input {
        let refreshTrigger: Observable<Void>
        let changeMode: Observable<PreferenceInputMode>
        let likeMessage: Observable<String>
        let dislikeMessage: Observable<String>
        let etcMessage: Observable<String>
        let editPreference: Observable<Void>
    }
    
    struct Output {
        let currentMode: Driver<PreferenceInputMode>
        let likeMessageCount: Driver<Int>
        let dislikeMessageCount: Driver<Int>
        let etcMessageCount: Driver<Int>
        
        // 초기 데이터값 (API 통신 값)
        let initialLikeMessage: Driver<String>
        let initialDislikeMessage: Driver<String>
        let initialEtcMessage: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let initialMessages = input.refreshTrigger
            .flatMapLatest {
                APIService.shared.request(APIEndpoint(path: "/my/preferences", method: .get, headers: [
                    "X-User-Name": NicknameStorageService.shared.getNickname() ?? "yubin"
                ]), type: PreferenceResponse.self)
            }
            .share(replay: 1)
        let initialLikeMessage = initialMessages
            .map { $0.data.likes ?? "" }
            .asDriver(onErrorJustReturn: "")

        let initialDislikeMessage = initialMessages
            .map { $0.data.dislikes ?? "" }
            .asDriver(onErrorJustReturn: "")

        let initialEtcMessage = initialMessages
            .map { $0.data.etc ?? "" }
            .asDriver(onErrorJustReturn: "")
        
        let editResponse = input.editPreference
            .withLatestFrom(Observable.combineLatest(
                input.likeMessage,
                input.dislikeMessage,
                input.etcMessage
            ))
            .flatMapLatest { like, dislike, etc in
                return APIService.shared.request(
                    APIEndpoint(path: "/my/preferences", method: .put, parameters: [
                        "likes": like,
                        "dislikes": dislike,
                        "etc": etc
                    ], headers: [
                        "X-User-Name": NicknameStorageService.shared.getNickname() ?? "yubin"
                    ]),
                    type: StatusResponse.self
                )
            }
        let modeStream = Observable.merge(
            input.changeMode,
            
            editResponse
                .filter { $0.status == "SUCCESS" }
                .map { _ in PreferenceInputMode.view }
        )
            .startWith(.view)
            .share(replay: 1)
        
        let currentMode = modeStream
            .asDriver(onErrorJustReturn: .view)
        
        let likeCount = input.likeMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        let dislikeCount = input.dislikeMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        let etcCount = input.etcMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        
        return Output(
            currentMode: currentMode,
            likeMessageCount: likeCount,
            dislikeMessageCount: dislikeCount,
            etcMessageCount: etcCount,
            initialLikeMessage: initialLikeMessage,
            initialDislikeMessage: initialDislikeMessage,
            initialEtcMessage: initialEtcMessage
        )
    }
}

