//
//  RestaurantDetailViewModel.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import RxSwift
import RxCocoa
import UIKit

final class RestaurantDetailViewModel {
    private let restaurantId: Int
    init(id: Int) {
        self.restaurantId = id
    }
    struct Input {

    }
    
    struct Output {
        let restaurantDetail: Driver<RestaurantDetail>
        let menus: Driver<[Menu]>
        let showErrorPage: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let fetchObservable = Observable<RestaurantDetail>.create { observer in
            // TODO: API
            observer.onNext(RestaurantDetail.dummyData)
            observer.onCompleted()
            return Disposables.create()
        }

        let materialized = fetchObservable
            .materialize()
            .share()

        let restaurantDetail = materialized
            .compactMap { $0.element }
            .asDriver(onErrorDriveWith: .empty())
        
        let menus = materialized
            .compactMap{ $0.element?.menus }
            .asDriver(onErrorJustReturn: [])

        let showErrorPage = materialized
            .compactMap { $0.error != nil ? true : nil }
            .asDriver(onErrorJustReturn: true)
        
        return Output(restaurantDetail: restaurantDetail, menus: menus, showErrorPage: showErrorPage)
    }
}

