//
//  Group.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation

struct Group : Identifiable {
    let id : Int
    let name : String
    let members : [String]
    
    static let dummyData : Group = .init(id: 0, name: "맛있는녀석들", members: ["김준현", "유민상", "문세윤", "김민경"])
}
