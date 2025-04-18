//
//  StoreListMapper.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

final class StoreListMapper {
    func dtoToEntity(_ dto: StoresResponse) -> [Restaurants] {
        var result = [Restaurants]()
        for store in dto.data {
            result.append(Restaurants(id: store.id, imageStr: store.representativeMenu?.imageUrl ?? "", title: store.storeName, category: store.category, minutes: store.distanceInMinutesByWalk, isLike: false))
        }
        
        return result
    }
}
