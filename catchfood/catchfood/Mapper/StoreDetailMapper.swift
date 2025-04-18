//
//  StoreDetailMapper.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

final class StoreDetailMapper {
    func dtoToEntity(_ dto: StoreDetailResponse) -> RestaurantDetail {
        let store = dto.data
        let openTime = store.businessHours?.open ?? ""
        let closeTime = store.businessHours?.close ?? ""
        let businessTime = openTime.isEmpty && closeTime.isEmpty ? "" : "\(openTime) ~ \(closeTime)"
        let menus = menuDtoToEntity(dto.data.menus)
        return RestaurantDetail(id: store.id, storeName: store.storeName, category: store.category, minutesByWalk: store.distanceInMinutesByWalk, contact: store.contact, address: store.address, businessHours: businessTime, menus: menus, ratingStars: store.ratingStars)
    }
    
    func menuDtoToEntity(_ dto: [MenuDTO]) -> [Menu] {
        var menus: [Menu] = []
        for menu in dto {
            menus.append(Menu(menuName: menu.menuName, imageUrl: menu.imageUrl ?? "", price: menu.price ?? 0))
        }
        
        return menus
    }
}
