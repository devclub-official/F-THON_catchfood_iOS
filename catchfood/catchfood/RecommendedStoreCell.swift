//
//  VotingMenuCell.swift
//  catchfood
//
//  Created by 정종찬 on 4/18/25.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RecommendedStoreCell : UITableViewCell {
    
    var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(hex: "#F2F2F2")
        return view
    }()
    
    lazy var menuImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        imageView.layer.borderWidth = 1
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
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    var separator : UIView = {
        let view = UIView()
        view.backgroundColor = .grayScale800
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var timeFromStepLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    var voteMembersView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    var voteButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let viewModel = RecommendedStoreCellViewModel()
    
    var disposeBag : DisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        setViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
        
        menuImageView.image = nil
        menuNameLabel.text = ""
        restaurantNameLabel.text = ""
        categoryLabel.text = ""
        timeFromStepLabel.text = ""
    }
    
    func setViewLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview().inset(12)
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
        
        containerView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.left.equalTo(categoryLabel.snp.right).offset(5)
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.width.equalTo(1)
            make.height.equalTo(10)
        }
        
        containerView.addSubview(timeFromStepLabel)
        timeFromStepLabel.snp.makeConstraints { make in
            make.left.equalTo(separator.snp.right).offset(5)
            make.centerY.equalTo(categoryLabel.snp.centerY)
        }
        
        containerView.addSubview(voteMembersView)
        voteMembersView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        containerView.addSubview(voteButton)
        voteButton.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(voteMembersView.snp.bottom).offset(10)
            make.bottom.equalTo(-10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    func bind(_ store : RecommendedStore, ongoing : Int?)
    {
        viewModel.voteToggleRelay
            .subscribe { [weak self] voted in
                self?.voteButton.setImage(voted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle"), for: .normal)
            }
            .disposed(by: disposeBag)
        
        voteButton.rx.tap
            .scan(false) { (lastState, newValue) in
                !lastState
             }
            .bind { [weak self] vote in
                self?.viewModel.voteToggleRelay.accept(vote)
                
                if vote
                {
                    guard let ongoing = ongoing else {return}
                    self?.viewModel.votingFoot(store: store, ongoing: ongoing)
                }
            }
            .disposed(by: disposeBag)
        
        ImageLoadHelper.shared.loadImage(from: store.representativeMenu.imageUrl) { [weak self] image in
            self?.menuImageView.image = image
        }
        
        menuNameLabel.text = store.representativeMenu.name
        restaurantNameLabel.text = store.storeName
        categoryLabel.text = store.category
        timeFromStepLabel.text = "\(store.distanceInMinutesByWalk)분"
        voteButton.setImage(store.isVotedByMe ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "checkmark.circle"), for: .normal)
        
        store.votedMembers.forEach { [weak self] name in
            let view = MemberView()
            view.setupData(name)
            self?.voteMembersView.addArrangedSubview(view)
        }
        
    }
}
