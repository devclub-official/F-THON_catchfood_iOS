//
//  APIManager.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    let baseUrlStr = ""
    var username : String = ""
    
    func fetchUrl<T : Decodable>(suffix: String, method : HTTPMethod, params : Parameters, completion: @escaping (Result<T, Error>) -> Void) {
        let urlStr = baseUrlStr + suffix
        
        let header : HTTPHeaders = [
            "X-User-Name" : username
        ]
        
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
            return
        }
        
        AF.request(urlStr, method: method, parameters: params, encoding: URLEncoding.httpBody, headers: header).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(json))
                    
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
