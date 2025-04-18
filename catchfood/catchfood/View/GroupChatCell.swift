//
//  GroupChatCell.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import UIKit
import SnapKit

class GroupChatCell: UITableViewCell {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#fef01b")
        view.layer.cornerRadius = 10
        return view
    }()
    
    private var chatTextLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        chatTextLabel.text = ""
    }
    
    func setViewLayout()
    {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(4)
            make.width.equalTo(200)
        }
        
        containerView.addSubview(chatTextLabel)
        chatTextLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    func bind(_ message : Chatting)
    {
        chatTextLabel.text = message.message
    }
}


