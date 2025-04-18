//
//  RecommendStoresResponseDTO.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation

struct RecommendStoresRawData: Codable {
    let status : String
    let preferences : [String:String]
    let recommendedStores : [RecommendedStore]
}

struct RecommendStoresResponseDTO: Codable {
    let status : String
    let data : RecommendStoresRawData
    var message : String?
}
