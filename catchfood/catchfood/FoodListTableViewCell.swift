//
//  FoodListTableViewCell.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//
import UIKit
import SnapKit
final class FoodListTableViewCell: UITableViewCell {
    var restaurant: Restaurants? = nil
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.aTeamBorderColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()

    private let restaurantImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    private let infoContainer = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .aTeamHeadLineTextColor
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .aTeamBodyTextColor
        return label
    }()
    
    private let walkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "figure.walk")
        imageView.tintColor = .aTeamSubTextColor
        return imageView
    }()
    private let walkLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .aTeamSubTextColor
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        
        return button
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        restaurant = nil
        restaurantImageView.image = nil
        categoryLabel.text = ""
        walkLabel.text = ""
        categoryLabel.text = ""
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupData(restaurant: Restaurants, isHiddenLikeButton: Bool = false) {
        self.restaurant = restaurant
        self.categoryLabel.text = restaurant.category
        self.titleLabel.text = restaurant.title
        self.walkLabel.text = "\(restaurant.minutes)분"
        self.likeButton.isHidden = isHiddenLikeButton
        ImageLoadHelper.shared.loadImage(from: restaurant.imageStr) { [weak self] image in
            guard let self = self else { return }
            restaurantImageView.image = image
        }
    }
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubviews(views: [restaurantImageView, infoContainer, likeButton])
        infoContainer.addSubviews(views: [titleLabel, categoryLabel, walkImageView, walkLabel])
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        restaurantImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.leading.equalTo(restaurantImageView.snp.trailing).offset(12)
            make.top.bottom.equalTo(restaurantImageView).inset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.leading.equalTo(infoContainer.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.size.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
        }
        
        walkImageView.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(20)
            make.size.equalTo(20)
            make.bottom.equalToSuperview()
        }
        
        walkLabel.snp.makeConstraints { make in
            make.bottom.equalTo(categoryLabel)
            make.leading.equalTo(walkImageView.snp.trailing).offset(4)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
    }
    
}

