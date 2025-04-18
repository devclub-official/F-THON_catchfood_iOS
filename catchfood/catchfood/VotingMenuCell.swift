//
//  VotingMenuCell.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import UIKit
import SnapKit

class VotingMenuCell : UITableViewCell {
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var menuImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var menuNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    var restaurantNameLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    var categoryLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var timeFromStepLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    var voteButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setViewLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setViewLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(8)
        }
        
        containerView.addSubview(menuImageView)
        menuImageView.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        containerView.addSubview(menuNameLabel)
        menuNameLabel.snp.makeConstraints { make in
            make.left.equalTo(menuImageView.snp.right).offset(10)
            make.top.equalTo(menuImageView.snp.top)
            make.right.equalTo(-10)
        }
        
        containerView.addSubview(restaurantNameLabel)
        restaurantNameLabel.snp.makeConstraints { make in
            make.left.equalTo(menuNameLabel.snp.left)
            make.top.equalTo(menuNameLabel.snp.bottom).offset(6)
            make.right.equalTo(-10)
        }
        
        containerView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(menuImageView.snp.bottom).offset(12)
        }
        
        containerView.addSubview(timeFromStepLabel)
        timeFromStepLabel.snp.makeConstraints { make in
            make.left.equalTo(categoryLabel.snp.right).offset(12)
            make.centerY.equalTo(categoryLabel.snp.centerY)
        }
        
        containerView.addSubview(voteButton)
        voteButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.bottom.equalTo(-20)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func bind()
    {
        
    }
}
