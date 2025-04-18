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
    func generateGroup()
    {
        let headers : HTTPHeaders = [
            "X-User-Name" : "정종찬"
        ]
        let params : Parameters = ["partyName" : groupNameSubject.value]
        
//        AF.request(baseURLStr + "/parties", method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).validate().responseJSON { response in
//            switch response.result {
//            case .success(let data):
//                let json = try? JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
//                
//            case .failure(let error):
//                
//            }
//        }
    }
}
