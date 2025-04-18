//
//  VotingListItem.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation

struct VotingListItem : Identifiable {
    let id: String
    let foodName : String
    let restaurantName : String
    let foodImageUrl : String
    let stepTime : Int
    let voteCount : Int
    let isVote : Bool
}
