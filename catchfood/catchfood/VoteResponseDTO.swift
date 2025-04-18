//
//  VoteResponseDTO.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation

struct PollsID : Codable {
    let done : [Int]
    let ongoing : Int?
}

struct VoteResponseDTO: Codable {
    let status: String
    let data : [PollsID]
    var message : String?
}
