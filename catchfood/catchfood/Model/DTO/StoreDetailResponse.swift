//
//  StoreDetailResponse.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import Foundation

struct StoreDetailResponse: Codable {
    let status: String
    let data: StoreDetail
    let message: String?
}

struct StoreDetail: Codable {
    let id: Int
    let storeName: String
    let category: String?
    let distanceInMinutesByWalk: Int?
    let contact: String?
    let address: String?
    let businessHours: BusinessHours?
    let menus: [MenuDTO]
    let ratingStars: Double
}

struct BusinessHours: Codable {
    let open: String
    let close: String
}

struct MenuDTO: Codable {
    let menuName: String
    let imageUrl: String?
    let price: Int?
}
