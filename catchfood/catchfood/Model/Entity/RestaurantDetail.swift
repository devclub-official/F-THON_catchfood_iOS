//
//  RestaurantDetail.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

/*
 "id": 1,
 "storeName": "홍콩반점",
 "category": "중식",
 "distanceInMinutesByWalk": 10,
 "contact": "02-1234-4567",
 "address": "서울특별시 중구 대변대로 12-1",
 "businessHours": {
   "open": "09:00",
   "close": "18:00"
 },
 "menus": [
   {
     "menuName": "짬뽕",
     "imageUrl": "",
     "price": 10000
   }
 ],
 "ratingStars": 4.5
 */
struct RestaurantDetail {
    let id: Int
    let storeName: String
    let category: String?
    let minutesByWalk: Int?
    let contact: String?
    let address: String?
    let businessHours: String
    let menus: [Menu]
    let ratingStars: Double?
    
    static let dummyData: RestaurantDetail = RestaurantDetail(id: 1, storeName: "짱맛있는 식당", category: "한식", minutesByWalk: 5, contact: "02-1234-4567", address: "서울특별시 중구 대변대로 12-1", businessHours: "09:00 ~ 18:00", menus: [Menu(menuName: "짬뽕", imageUrl: "https://i.namu.wiki/i/upNZ7cYsFsAfU0KcguO6OHMK68xC-Bj8EXxdCti61Jhjx10UCBgdK5bZCEx41-aAWcjWZ5JMKFUSaUGLC1tqWg.webp", price: 10000), Menu(menuName: "짬뽕", imageUrl: "https://i.namu.wiki/i/upNZ7cYsFsAfU0KcguO6OHMK68xC-Bj8EXxdCti61Jhjx10UCBgdK5bZCEx41-aAWcjWZ5JMKFUSaUGLC1tqWg.webp", price: 10000)], ratingStars: 4.5)
}

struct Menu {
    let menuName: String
    let imageUrl: String
    let price: Int
}
