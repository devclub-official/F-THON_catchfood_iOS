//
//  GroupGenerateViewController.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import SnapKit
import UIKit
import RxSwift
import RxCocoa

class GroupGenerateViewController: UIViewController {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var dismissButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.imageView?.tintColor = .black
        return button
    }()
    
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "그룹을 만들어주세요."
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let groupNameTextField = CFTextField(placeholder: "그룹명")
    
    private var generateButton : UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.setTitle("그룹만들기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let viewModel = GroupGenerateViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        bind()
    }
    
    func setViewLayout()
    {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.bottom.right.equalToSuperview()
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(-20)
        }
        
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        containerView.addSubview(groupNameTextField)
        groupNameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        containerView.addSubview(generateButton)
        generateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(groupNameTextField.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
    }
    
    func bind()
    {
        
        viewModel.groupGenerateResult
            .subscribe { [weak self] isSuccess in
                if isSuccess
                {
                    self?.dismiss(animated: true, completion: nil)
                }
            }
            .disposed(by: disposeBag)
        
        groupNameTextField.rx.text
            .orEmpty
            .distinctUntilChanged()
            .subscribe { [weak self] name in
                self?.viewModel.groupNameSubject.accept(name)
            }
            .disposed(by: disposeBag)
        
        generateButton.rx.tap
            .bind { [weak self] _ in
                // 그룹 생성 API
                self?.viewModel.generateGroup()
            }
            .disposed(by: disposeBag)
        
        dismissButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
