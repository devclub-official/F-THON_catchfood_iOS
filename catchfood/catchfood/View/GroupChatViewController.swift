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
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private var memberButton = CFButton(styleType: .outline, title: "멤버초대")
    private var chatListTableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.register(RecommendedStoreCell.self, forCellReuseIdentifier: "RECOMMENDED_STORE_CELL")
        tableView.register(GroupChatCell.self, forCellReuseIdentifier: "CHAT_CELL")
        return tableView
    }()
    
    private var addGroupButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("+ 그룹", for: .normal)
        button.setTitleColor(UIColor(hex:"#fff"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        return button
    }()
    
    private let searchTextField = CFTextField(placeholder: "메세지 입력")
    private let searchButton = SearchIconButton()
    
    let viewModel = GroupChatViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //observer등록
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveUp(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
                
        NotificationCenter.default.addObserver(self, selector: #selector(textViewMoveDown(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setViewLayout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getParties()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //observer해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func setViewLayout()
    {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        containerView.addSubview(memberButton)
        containerView.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
//            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.trailing.equalToSuperview().inset(16)
            make.size.equalTo(36)
        }
        memberButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.top.equalTo(searchButton.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        containerView.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchButton)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(searchButton.snp.leading).offset(-8)
        }
        
        containerView.addSubview(addGroupButton)
        addGroupButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
        
        containerView.addSubview(chatListTableView)
        chatListTableView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(searchTextField.snp.top)
        }
        
    }
    
    func bind()
    {
        memberButton.rx.tap
            .subscribe { [weak self] _ in
                let vc = GroupMemberInviteViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        viewModel.isAccessGroupChat
            .subscribe { [weak self] isAccess in
                self?.chatListTableView.isHidden = !isAccess
                self?.addGroupButton.isHidden = isAccess
            }
            .disposed(by: disposeBag)
        
        viewModel.groupChatListItems.bind(to: chatListTableView.rx.items) { [weak self] tableView, row, item in
            let indexPath = IndexPath.init(item: row, section: 0)
            
            if let storeItem = item as? RecommendedStore
            {
                guard let cell = self?.chatListTableView.dequeueReusableCell(withIdentifier: "RECOMMENDED_STORE_CELL", for: indexPath) as? RecommendedStoreCell else {return UITableViewCell()}
                cell.bind(storeItem, ongoing: self?.viewModel.ongoing)
                return cell
            }
            else if let chatItem = item as? Chatting
            {
                guard let cell = self?.chatListTableView.dequeueReusableCell(withIdentifier: "CHAT_CELL", for: indexPath) as? GroupChatCell else {return UITableViewCell()}
                cell.bind(chatItem)
                return cell
            }
            else
            {
                return UITableViewCell()
            }
        }
        .disposed(by: disposeBag)
        
        addGroupButton.rx.tap
            .bind { [weak self] _ in
                guard let tabbar = self?.tabBarController else {return}
                let vc = GroupListViewController()
                vc.modalTransitionStyle = .coverVertical
                vc.modalPresentationStyle = .fullScreen
                tabbar.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
        searchTextField.rx.text
            .orEmpty
            .subscribe(onNext: { [weak self] text in
                guard let s = self else {return}
                if !s.viewModel.isAccessGroupChat.value
                {
                    s.searchButton.isEnabled = false
                    return
                }
                
                s.searchButton.isEnabled = !text.isEmpty
            })
            .disposed(by: disposeBag)
                       
                       
        searchButton.rx.tap
            .bind { [weak self] _ in
                //
                guard let message = self?.searchTextField.text else {return}
                
//                self?.viewModel.inputChatting(message)
                self?.viewModel.getVotePoll(message)
                self?.searchTextField.text = ""
            }
            .disposed(by: disposeBag)
    }
    
    @objc func textViewMoveUp(_ noti : Notification)
    {
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                UIView.animate(withDuration: 0.3, animations: {
                    self.searchButton.snp.updateConstraints { make in
                        make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-keyboardSize.height)
                    }
                })
            }
    }
    
    @objc func textViewMoveDown(_ noti : Notification)
    {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.searchButton.snp.updateConstraints { make in
//                make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-12)
//            }
//        })
    }
}
