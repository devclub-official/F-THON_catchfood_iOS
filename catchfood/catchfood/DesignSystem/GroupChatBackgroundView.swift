//
//  GroupBackgroundView.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import UIKit
import SnapKit

final class GroupChatBackgroundView: UIView {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup()
    {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
        }
        
        containerView.addSubview(addGroupButton)
        addGroupButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(80)
            make.height.equalTo(32)
        }
    }
}
