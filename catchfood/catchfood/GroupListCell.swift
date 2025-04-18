//
//  GroupListCell.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import UIKit
import SnapKit

class GroupListCell: UITableViewCell {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hex: "#999").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private var groupNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    
    private var groupMembersView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewLayout()
    {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(8)
        }
        
        containerView.addSubview(groupNameLabel)
        groupNameLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(20)
            make.right.equalTo(-20)
        }
        
        containerView.addSubview(groupMembersView)
        groupMembersView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(groupNameLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func bind(_ group : Group)
    {
        groupNameLabel.text = group.name
        group.members.forEach { [weak self] name in
            let view = MemberView()
            view.setupData(name)
            self?.groupMembersView.addArrangedSubview(view)
        }
    }
}
