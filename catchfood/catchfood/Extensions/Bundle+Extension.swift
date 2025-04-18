//
//  Bundle+Extension.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import Foundation

extension Bundle {
    var baseURL: String? {
        guard let file = self.path(forResource: "APIKey", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["BASE_URL"] as? String else {
            return nil
        }
        
        print("base_Url: \(key)")
        return key
    }
}
