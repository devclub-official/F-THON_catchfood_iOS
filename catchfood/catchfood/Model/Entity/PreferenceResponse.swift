//
//  PreferenceResponse.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import Foundation

struct PreferenceResponse: Codable {
    let status: String
    let data: Preference
    let message: String?
}

struct Preference: Codable {
    let likes: String?
    let dislikes: String?
    let etc: String?
}
