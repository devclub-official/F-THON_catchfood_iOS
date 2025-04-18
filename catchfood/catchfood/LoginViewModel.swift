//
//  LoginViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import RxSwift
import RxCocoa
import UIKit

final class LoginViewModel {
    struct Input {
        let login: Observable<String>
    }
    
    struct Output {
        let loginResult: Signal<Bool>
    }
    
    func transform(input: Input) -> Output {
        let loginResult = input.login
            .flatMapLatest { nickname -> Observable<Bool> in
                let endpoint = APIEndpoint(
                    path: "/signup",
                    method: .post,
                    parameters: ["name": nickname]
                )
                
                return APIService.shared.request(endpoint, type: StatusResponse.self)
                    .map { $0.status == "SUCCESS" }
                    .catchAndReturn(false)
            }
            .asSignal(onErrorJustReturn: false)

        return Output(loginResult: loginResult)
    }
}

