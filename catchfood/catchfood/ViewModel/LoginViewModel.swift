//
//  LoginViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import RxSwift
import RxCocoa
import UIKit
import Alamofire

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
                    .map { $0.status == "SUCCESS" } // 200 OK + SUCCESS
                    .catch { error in
                        // 🔍 에러가 AFError 혹은 underlying HTTP 오류인 경우
                        if let afError = error as? AFError,
                           case let .responseValidationFailed(reason) = afError,
                           case let .unacceptableStatusCode(code) = reason,
                           code == 400 {
                            return .just(true) // ✅ 400이면 true 반환
                        }

                        // 그 외는 실패
                        return .just(false)
                    }
            }
            .asSignal(onErrorJustReturn: false)

        return Output(loginResult: loginResult)
    }
}

