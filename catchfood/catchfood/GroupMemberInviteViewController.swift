//
//  GroupMemberInviteViewController.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class GroupMemberInviteViewController: UIViewController {
    private let memberTF = CFTextField(placeholder: "초대할 닉네임을 적어주세요")
    private let inviteButton = CFButton(styleType: .outline, title: "초대")
    
    private let memberListLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .aTeamHeadLineTextColor
        label.text = "멤버 목록"
        return label
    }()
    
    private let tableView = UITableView()
    
    private let viewModel = GroupMemberInviteViewModel()
    private let disposeBag = DisposeBag()
    private let inviteTrigger = PublishRelay<String>()
    private var members: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewLayout()
        setupTableView()
        bind()
    }
    
    private func setViewLayout() {
        view.backgroundColor = .white
        view.addSubviews(views: [
            memberTF,
            inviteButton,
            memberListLabel,
            tableView
        ])
        
        memberTF.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        inviteButton.snp.makeConstraints { make in
            make.top.equalTo(memberTF.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        memberListLabel.snp.makeConstraints { make in
            make.top.equalTo(inviteButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(memberListLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
    }

    private func bind() {
        // 초대 버튼 탭 시 inviteTrigger로 닉네임 전달
        inviteButton.rx.tap
            .withUnretained(self)
            .compactMap { vc, _ in
                vc.memberTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            }
            .filter { !$0.isEmpty }
            .bind(to: inviteTrigger)
            .disposed(by: disposeBag)
        
        // ViewModel transform
        let input = GroupMemberInviteViewModel.Input(inviteMember: inviteTrigger.asObservable())
        let output = viewModel.transform(input: input)
        
        // 멤버 리스트 바인딩
        output.currentMember
            .drive(onNext: { [weak self] memberList in
                print(memberList)
                self?.members = memberList
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
        
        output.inviteSuccess
            .emit(onNext: { [weak self] in
                self?.memberTF.text = ""
            })
            .disposed(by: disposeBag)
    }
}

extension GroupMemberInviteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = members[indexPath.row]
        return cell
    }
}
