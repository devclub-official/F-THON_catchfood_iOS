//
//  GroupChatViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import RxSwift
import RxCocoa

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
}

