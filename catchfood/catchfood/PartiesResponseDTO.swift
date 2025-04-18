//
//  PartiesResponseDTO.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation

struct PartiesResponseDTO: Codable {
    let status: String
    let data : [Group]
    var message : String?
}
