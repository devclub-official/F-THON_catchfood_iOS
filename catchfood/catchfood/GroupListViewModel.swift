//
//  GroupListViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class GroupListViewModel {
    let groupListsRelay = BehaviorRelay<[Group]>(value: [])
    
    func getGroupLists() {
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        AF.request(baseURLStr + "parties", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data ):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(PartiesResponseDTO.self, from: data)
                    if let parties = json.data.first
                    {
                        NicknameStorageService.shared.savePartyId(parties.id)
                    }
                    
                    if !json.data.isEmpty
                    {
                        self.groupListsRelay.accept(json.data)
                    }
                    else
                    {
                        self.groupListsRelay.accept([])
                    }
                    print("get success parties!! : \(json)")
                } catch {
                    print(error)
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
        }
    }
}
