//
//  NicknameStorageService.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import Foundation

final class NicknameStorageService {
    static let shared = NicknameStorageService()

    private let nicknameKey = "user_nickname"
    private let partyKey = "user_party_id"

    private init() {}

    /// 닉네임 저장
    func saveNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    func savePartyId(_ id : Int)
    {
        UserDefaults.standard.set(id, forKey: partyKey)
    }
    
    func getPartyId() -> Int?
    {
        return UserDefaults.standard.integer(forKey: partyKey)
    }

    /// 저장된 닉네임 가져오기
    func getNickname() -> String? {
        return UserDefaults.standard.string(forKey: nicknameKey)
    }

    /// 닉네임 삭제
    func clearNickname() {
        UserDefaults.standard.removeObject(forKey: nicknameKey)
    }
}
