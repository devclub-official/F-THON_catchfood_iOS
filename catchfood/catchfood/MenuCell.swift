//
//  MenuCell.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//
import UIKit
import SnapKit
final class MenuCell: UITableViewCell {
    var menu: Menu? = nil
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.aTeamBorderColor.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    private let menuImageView: UIImageView = {
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
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .aTeamBodyTextColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        menu = nil
        menuImageView.image = nil
        titleLabel.text = ""
        priceLabel.text = ""
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupData(menu: Menu) {
        self.menu = menu
        self.titleLabel.text = menu.menuName
        self.priceLabel.text = "\(menu.price) 원"
        ImageLoadHelper.shared.loadImage(from: menu.imageUrl) { [weak self] image in
            guard let self = self else { return }
            menuImageView.image = image
        }
    }
    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubviews(views: [menuImageView, infoContainer])
        infoContainer.addSubviews(views: [titleLabel, priceLabel])
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        menuImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.bottom.equalToSuperview().inset(12)
            make.centerY.equalToSuperview()
            make.size.equalTo(60)
        }
        
        infoContainer.snp.makeConstraints { make in
            make.leading.equalTo(menuImageView.snp.trailing).offset(12)
            make.top.bottom.equalTo(menuImageView).inset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.trailing.equalToSuperview()
        }
        
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}

