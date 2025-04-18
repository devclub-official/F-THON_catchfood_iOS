//
//  StoresResponse.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import Foundation

struct StoresResponse: Codable {
    let status: String
    let data: [StoresItem]
    let message: String?
}

struct StoresItem: Codable {
    let id: Int
    let storeName: String
    let category: String?
    let representativeMenu: RepresentativeMenu?
    let distanceInMinutesByWalk: Int?
}

struct RepresentativeMenu: Codable {
    let name: String
    let imageUrl: String
}
