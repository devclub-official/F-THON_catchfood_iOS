//
//  GroupChatViewController.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class GroupChatViewController: UIViewController {
    
    var containerView : UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }
    
    var chatListTableView : UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.showsVerticalScrollIndicator = false
        tableView.register(VotingMenuCell.self, forCellReuseIdentifier: "VOTING_MENU_CELL")
        return tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        bind()
    }
    
    func setViewLayout()
    {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        containerView.addSubview(chatListTableView)
        chatListTableView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func bind()
    {
        
    }
}
