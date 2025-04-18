//
//  PreferenceInputViewModel.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import RxSwift
import RxCocoa
import UIKit

enum PreferenceInputMode {
    case edit
    case view
}
final class PreferenceInputViewModel {
    struct Input {
        let changeMode: Observable<PreferenceInputMode>
        let likeMessage: Observable<String>
        let dislikeMessage: Observable<String>
        let etcMessage: Observable<String>
    }
    
    struct Output {
        let currentMode: Driver<PreferenceInputMode>
        let likeMessageCount: Driver<Int>
        let dislikeMessageCount: Driver<Int>
        let etcMessageCount: Driver<Int>
    }
    
    func transform(input: Input) -> Output {
        let modeStream = input.changeMode
            .startWith(.view)
            .share(replay: 1)

        let currentMode = modeStream
            .asDriver(onErrorJustReturn: .view)
        
        let likeCount = input.likeMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        let dislikeCount = input.dislikeMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        let etcCount = input.etcMessage
            .map { message in
                return message.count
            }
            .asDriver(onErrorJustReturn: 0)
        
        return Output(
            currentMode: currentMode,
            likeMessageCount: likeCount,
            dislikeMessageCount: dislikeCount,
            etcMessageCount: etcCount
        )
    }
}

