//
//  VoteMemberView.swift
//  catchfood
//
//  Created by 정종찬 on 4/19/25.
//

import Foundation
import UIKit
import SnapKit

final class VoteMemberView : UIView {
    
    private var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.backgroundColor = .black
        return view
    }()
    
    private var nameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 10, weight: .bold)
        return label
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
            make.left.top.right.bottom.equalToSuperview().inset(4)
        }
        
        containerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.top.bottom.trailing.equalToSuperview().inset(2)
        }
    }
    
    func setupData(_ member : String)
    {
        nameLabel.text = member
    }
    
    
}
