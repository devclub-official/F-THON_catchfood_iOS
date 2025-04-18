//
//  GroupChatViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class GroupChatViewModel {
    
    var itemsArray : [Any] = []
    let groupChatListItems = BehaviorRelay<[Any]>(value: [])
    
    let isAccessGroupChat = BehaviorRelay<Bool>(value: false)
    
    
    func inputChatting(_ text : String)
    {
        let chatItem : Chatting = Chatting(name: "김철수", message: text)
        itemsArray.append(chatItem)
        
        groupChatListItems.accept(itemsArray)
    }
    
    func inputRecommendedStore()
    {
        let dummy = RecommendedStore.dummyData
        itemsArray.append(dummy)
        
        groupChatListItems.accept(itemsArray)
    }
    
    func getParties()
    {
        let headers : HTTPHeaders = [
           "X-User-Name" : "Jongchan"
        ]
        AF.request(baseURLStr + "parties", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(PartiesResponseDTO.self, from: data)
                    if json.data.isEmpty
                    {
                        self.isAccessGroupChat.accept(false)
                    }
                    else
                    {
                        self.isAccessGroupChat.accept(true)
                    }
                    print("get success parties!! : \(json)")
                } catch {
                    print(error)
                }
            case .failure(let error):
                NSLog("get parties error : " + error.localizedDescription)
            }
        }
    }
    
}

