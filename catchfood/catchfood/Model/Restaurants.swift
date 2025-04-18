//
//  Restaurants.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

struct Restaurants {
    let imageStr: String
    let title: String
    let category: String
    let minutes: Int
    let isLike: Bool
    
    static let dummyData: [Restaurants] = [
        Restaurants(imageStr: "https://lh6.googleusercontent.com/proxy/NFPYLgyvDjVdVa7o232ikTC8VYaT6slShCtl70COmlngcXsn_nJfIaLiSKBmhykZK3osVYYauCTM48Hoc6fyNnq09E4P32t6WI6U0XzqMKU", title: "짱끝내주는 음식점", category: "한식", minutes: 10, isLike: true),
        Restaurants(imageStr: "https://lh6.googleusercontent.com/proxy/NFPYLgyvDjVdVa7o232ikTC8VYaT6slShCtl70COmlngcXsn_nJfIaLiSKBmhykZK3osVYYauCTM48Hoc6fyNnq09E4P32t6WI6U0XzqMKU", title: "짱끝내주는 음식점2", category: "양식", minutes: 5, isLike: false),
        Restaurants(imageStr: "https://lh6.googleusercontent.com/proxy/NFPYLgyvDjVdVa7o232ikTC8VYaT6slShCtl70COmlngcXsn_nJfIaLiSKBmhykZK3osVYYauCTM48Hoc6fyNnq09E4P32t6WI6U0XzqMKU", title: "짱끝내주는 음식점3", category: "중식", minutes: 15, isLike: false),
    ]
}
