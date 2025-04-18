//
//  SearchViewModel.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import RxSwift
import RxCocoa
import UIKit

final class SearchViewModel {
    struct Input {
        let keywoard: Observable<String>
    }
    
    struct Output {
        let restaurants: Driver<[Restaurants]>
    }
    
    func transform(input: Input) -> Output {
        let restaurants = input.keywoard
            .distinctUntilChanged()
            .flatMapLatest { keyword -> Observable<[Restaurants]> in
                let parameters: [String: Any]? = keyword.isEmpty ? nil : ["keyword": keyword]

                let endpoint = APIEndpoint(
                    path: "/stores",
                    method: .get,
                    parameters: parameters,
                    headers: [
                        "X-User-Name": NicknameStorageService.shared.getNickname() ?? "Yubin"
                    ]
                )

                return APIService.shared.request(endpoint, type: StoresResponse.self)
                    .map { dto in
                        let stores = StoreListMapper().dtoToEntity(dto)
                        print(stores)
                        return stores
                    }
                    .catchAndReturn([])
            }
            .asDriver(onErrorJustReturn: [])
        
        return Output(restaurants: restaurants)
    }
}

