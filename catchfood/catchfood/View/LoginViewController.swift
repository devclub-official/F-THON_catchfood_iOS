//
//  LoginViewController.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController : UIViewController {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var logoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "app_logo")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private var nicknameTextField : UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "닉네임"
        textField.keyboardType = .default
        textField.font = .systemFont(ofSize: 18, weight: .medium)
        textField.textColor = .black
        return textField
    }()
    
    private var confirmButton : UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        button.isEnabled = false
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = LoginViewModel()
    private let loginTrigger = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        bind()
    }
    
    func setViewLayout()
    {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(0)
        }
        
        containerView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        
        containerView.addSubview(nicknameTextField)
        nicknameTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.right.equalTo(-20)
            make.height.equalTo(42)
        }
        
        containerView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(56)
        }
    }
    
    func bind()
    {
        let input = LoginViewModel.Input(login: loginTrigger.asObservable())
        let output = viewModel.transform(input: input)
        nicknameTextField.rx.text
            .orEmpty
            .map { !$0.trimmingCharacters(in: .whitespaces).isEmpty } 
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        confirmButton.rx.tap
            .withUnretained(self)
            .bind { [weak self] _ in
                self?.loginTrigger.onNext(self?.nicknameTextField.text ?? "")
            }
            .disposed(by: disposeBag)
        
        output.loginResult
            .filter { $0 }
            .emit(onNext: { [weak self] _ in
                NicknameStorageService.shared.saveNickname(self?.nicknameTextField.text ?? "")
                self?.changeToMainTabBar()
            })
            .disposed(by: disposeBag)
    }
    
    private func changeToMainTabBar() {
        let tabBarController = TabBarController()
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            return
        }

        UIView.transition(with: window, duration: 0.3, options: [.transitionFlipFromRight], animations: {
            window.rootViewController = tabBarController
        })
    }
}
