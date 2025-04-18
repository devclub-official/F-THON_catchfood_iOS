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
    
    var ongoing : Int = -1
    
    let preferenceText = BehaviorRelay<String>(value: "")
    
    let groupChatListItems = BehaviorRelay<[Any]>(value: [])
    
    let isAccessGroupChat = BehaviorRelay<Bool>(value: false)
    
    let isStartedFlow = BehaviorRelay<Bool>(value: false)
    
    
    func inputChatting(_ text : String)
    {
        let chatItem : Chatting = Chatting(name: "김철수", message: text)
        itemsArray.append(chatItem)
        
        groupChatListItems.accept(itemsArray)
    }
    
    func recommendFlowStart()
    {
        guard let partyId = NicknameStorageService.shared.getPartyId() else { return }
        
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname() ?? ""
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls", method: .post, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
            print(response.response)
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(ResponseDTO.self, from: data)
                    
                    if json.status == "SUCCESS"
                    {
                        self.getVote()
                    }
                    
                    self.isStartedFlow.accept(json.status == "SUCCESS" ? true : false)
                } catch {
                    print(error)
                    self.isStartedFlow.accept(false)
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.isStartedFlow.accept(false)
            }
        }
        
//        
//        let dummy = RecommendedStore.dummyData
//        itemsArray.append(dummy)
//        
//        groupChatListItems.accept(itemsArray)
    }
    
    func getVotePoll(_ text : String)
    {
        preferenceText.accept(text)
        
        guard let partyId = NicknameStorageService.shared.getPartyId() else { return }
        
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseData { response in
            print(response.response)
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(VoteResponseDTO.self, from: data)
                    if json.status == "SUCCESS"
                    {
                        if let ids = json.data.first, let ongoing = ids.ongoing
                        {
                            self.sendPreference(ongoing: ongoing)
                        }
                        else
                        {
                            self.recommendFlowStart()
                        }
                    }
                    
                } catch {
                    print(error)
                    
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                
            }
        }
    }
    
    func getVote()
    {
        guard let partyId = NicknameStorageService.shared.getPartyId() else { return }
        
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(VoteResponseDTO.self, from: data)
                    if json.status == "SUCCESS"
                    {
                        if let ids = json.data.first, let ongoing = ids.ongoing
                        {
                            self.sendPreference(ongoing: ongoing)
                        }
                    }
                    
                } catch {
                    print(error)
                    
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                
            }
        }
    }
    
    func sendPreference(ongoing : Int)
    {
        guard let partyId = NicknameStorageService.shared.getPartyId() else { return }
        
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname() ?? ""
        ]
        
        let params : Parameters = [
            "preference" : preferenceText.value
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls/\(ongoing)/preferences", method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data ):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(ResponseDTO.self, from: data)
                    if json.status == "SUCCESS"
                    {
                        self.getRecommendedStores(ongoing: ongoing)
                    }
                    
                } catch {
                    print(error)
                    
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
            }
        }
    }
    
    func getRecommendedStores(ongoing : Int)
    {
        guard let partyId = NicknameStorageService.shared.getPartyId() else { return }
        
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        
        AF.request(baseURLStr + "parties/\(partyId)/polls/\(ongoing)", method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(RecommendStoresResponseDTO.self, from: data)
                    if json.status == "SUCCESS"
                    {
                        let stores = json.data.recommendedStores
                        
                        self.ongoing = ongoing
                        self.groupChatListItems.accept(stores)
                    }
                    
                } catch {
                    print(error)
                    
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                
            }
        }
    }
    
    
    func getParties()
    {
        let headers : HTTPHeaders = [
            "X-User-Name" : NicknameStorageService.shared.getNickname()!
        ]
        AF.request(baseURLStr + "parties", method: .get, encoding: URLEncoding.default, headers: headers).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(PartiesResponseDTO.self, from: data)
                    if let parties = json.data.first
                    {
                        NicknameStorageService.shared.savePartyId(parties.id)
                    }
                    
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

