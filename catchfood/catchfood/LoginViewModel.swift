//
//  LoginViewModel.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import RxSwift
import Alamofire
import RxCocoa

class LoginViewModel {
    
    let nameTextFieldSubject = BehaviorRelay<String>(value: "")
    
    let isLogin = PublishRelay<Bool>()
    
    func checkTextfieldEmpty(_ text : String) -> Bool
    {
        nameTextFieldSubject.accept(text)
        return text.isEmpty
    }
    
    func signUp()
    {
        let params : Parameters = [
            "name" :  nameTextFieldSubject.value
        ]
        
        AF.request(baseURLStr + "signup", method: .post, parameters: params, encoding: URLEncoding.httpBody).validate().responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let json = try? decoder.decode(LoginResultDTO.self, from: data)
                    print("success login!")
                    self.isLogin.accept(true)
                } catch {
                    print("error!\(error)")
                    self.isLogin.accept(false)
                }
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.isLogin.accept(false)
            }
        }
    }
}
