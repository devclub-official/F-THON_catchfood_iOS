//
//  RecommendedStoreCellViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class RecommendedStoreCellViewModel {
    let voteToggleRelay = BehaviorRelay<Bool>(value: false)
    
    func votingFoot(store : RecommendedStore, ongoing : Int)
    {
        guard let partyId = NicknameStorageService.shared.getPartyId() else {return}
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls/\(ongoing)/recommended-stores/\(store.id)/vote", method: .post, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data) :
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(ResponseDTO.self, from: data)
                    print("voting success!! : \(json)")
                } catch {
                    print(error)
                }
                
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
        }
    }
}
