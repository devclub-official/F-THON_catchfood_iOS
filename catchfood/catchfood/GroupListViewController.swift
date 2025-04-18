//
//  GroupListViewController.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GroupListViewController: UIViewController {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private var dismissButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        return button
    }()
    
    private var groupListTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(GroupListCell.self, forCellReuseIdentifier: "GROUP_LIST_CELL")
        return tableView
    }()
    
    private var goToCreateGroupButton : UIButton = {
        let button = UIButton()
        button.setTitle("그룹 생성하기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    private let viewModel = GroupListViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func setViewLayout()
    {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        containerView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        containerView.addSubview(goToCreateGroupButton)
        goToCreateGroupButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(32)
        }
        
        containerView.addSubview(groupListTableView)
        groupListTableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(dismissButton.snp.bottom).offset(10)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bind()
    {
        dismissButton.rx.tap
            .bind { [weak self] _ in
                self?.dismiss(animated: false)
            }
            .disposed(by: disposeBag)
        
        viewModel.groupListsRelay.bind(to: groupListTableView.rx.items(cellIdentifier: "GROUP_LIST_CELL", cellType: GroupListCell.self)){ row, element, cell in
            cell.bind(element)
        }
        .disposed(by: disposeBag)
        
        goToCreateGroupButton.rx.tap
            .bind { [weak self] _ in
                let vc = GroupGenerateViewController()
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
