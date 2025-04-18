//
//  VotingListItem.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation

struct RecommendedStore : Codable, Identifiable {
    
//    "id": 1,
//    "storeName": "홍콩반점",
//    "representativeMenu": {
//        "name": "짬뽕",
//        "imageUrl": ""
//    },
//    "category": "중식",
//    "distanceInMinutesByWalk": 10,
//    "votedMembers": ["김진홍"],
//    "isVotedByMe": true
    
    let id: Int
    let storeName : String
    let representativeMenu : RepresentativeMenu
    let category : String
    let distanceInMinutesByWalk : Int
    let votedMembers : [String]
    var isVotedByMe : Bool
    
    static let dummyData : RecommendedStore = .init(id: 0, storeName: "빽다방", representativeMenu: RepresentativeMenu(name: "빽스치노", imageUrl: "https://paikdabang.com/wp-content/uploads/2018/05/%EC%9B%90%EC%A1%B0%EB%B9%BD%EC%8A%A4%EC%B9%98%EB%85%B8-SOFT-450x588.png"), category: "음료", distanceInMinutesByWalk: 10, votedMembers: ["강호동", "유재석"], isVotedByMe: false)
}

struct RepresentativeMenu : Codable {
    let name : String
    let imageUrl : String
}
