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
        //        let buttonTap: Observable<Void>
    }
    
    struct Output {
        let restaurants: Driver<[Restaurants]>
    }
    
    func transform(input: Input) -> Output {
        let dummy = Restaurants.dummyData
        let observable = Observable.just(dummy)
        return Output(restaurants: observable.asDriver(onErrorJustReturn: []))
    }
}

