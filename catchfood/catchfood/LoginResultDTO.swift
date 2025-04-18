//
//  LoginResultDTO.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation

struct LoginResultDTO : Codable {
    let status : String
    var data : Data?
    var message : String?
}
