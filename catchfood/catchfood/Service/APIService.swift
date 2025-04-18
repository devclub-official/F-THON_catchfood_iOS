//
//  APIService.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import UIKit
import Alamofire
import RxSwift
enum HTTPMethodType {
    case get, post, put, delete

    var method: HTTPMethod {
        switch self {
        case .get:    return .get
        case .post:   return .post
        case .put:    return .put
        case .delete: return .delete
        }
    }
}

/// API 요청을 구성하는 프로토콜
struct APIEndpoint {
    var path: String // API 경로 (ex. "/v1/user")
    var method: HTTPMethodType // HTTP Method
    var parameters: Parameters? // 요청 파라미터
    var headers: HTTPHeaders? // 요청 헤더
}

extension APIEndpoint {
    var url: String {
        return Bundle.main.baseURL! + path
    }
}
/*

 [APIService 사용 예시]
 struct ExampleResponse: Codable {
    let ex1: String
    let ex2: Int
 }

 APIService.shared.request(APIEndpoint(
 path: "/example",
 method: .get,
 parameters: ["page": 1],
 headers: ["Authorization": "Bearer token"]
), type: ExampleResponse.self
 )
 */

final class APIService {
    static var shared = APIService()
    
    func request<T: Decodable>(_ endpoint: APIEndpoint, type: T.Type) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(
                endpoint.url,
                method: endpoint.method.method,
                parameters: endpoint.parameters,
                encoding: endpoint.method == .get ? URLEncoding.default : JSONEncoding.default,
                headers: endpoint.headers
            )
            
            request
                .cURLDescription { description in
                    print("🌐 [REQUEST] \(description)")
                }
            
            request
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer.onNext(value)
                        observer.onCompleted()
                    case .failure(let error):
                        print("🚨 [Error] \(error.responseCode ?? 0) - \(error.localizedDescription)")
                        observer.onError(error)
                    }
                }
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
}
