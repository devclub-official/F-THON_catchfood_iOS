//
//  GroupGenerateViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

let baseURLStr = "http://ec2-3-36-117-241.ap-northeast-2.compute.amazonaws.com/"
class GroupGenerateViewModel {
    
    let groupNameSubject = BehaviorRelay<String>(value: "")
    
    let groupGenerateResult = PublishRelay<Bool>()
    
    func generateGroup()
    {
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        let params : Parameters = ["partyName" : groupNameSubject.value]
        
        AF.request(baseURLStr + "parties", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(ResponseDTO.self, from: data)
                    self.groupGenerateResult.accept(true)
                    print("get success parties!! : \(json)")
                } catch {
                    print(error)
                    self.groupGenerateResult.accept(false)
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.groupGenerateResult.accept(false)
            }
        }
    }
}
