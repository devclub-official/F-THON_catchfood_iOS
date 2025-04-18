//
//  RestaurantDetailViewController.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class RestaurantDetailViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamHeadLineTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    private let paddingLabelView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .fill
        return stack
    }()
    private let categoryLabel = PaddingLabel(title: "카테고리")
    private let walkLabel = PaddingLabel(title: "도보 0분")
    
    private let contactLabel: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamBodyTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "연락처: "
        return label
    }()
    
    private let addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamBodyTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "주소: "
        return label
    }()
    
    private let businessHoursLabel: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamBodyTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "영업시간: "
        return label
    }()
    
    // TODO: 나중에 별로 바꾸기
    private let ratingStars: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamBodyTextColor
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.text = "별점: "
        return label
    }()
    
    private let menuTitle: UILabel = {
        let label = UILabel()
        label.text = "메뉴"
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let tableView = UITableView()
    
    private let vm: RestaurantDetailViewModel
    private let disposeBag = DisposeBag()
    private let restaurantId: Int
    init(restaurantId: Int) {
        self.restaurantId = restaurantId
        self.vm = RestaurantDetailViewModel(id: restaurantId)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupUI()
        bind()
    }
    private func setupTableView() {
        tableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    private func bind() {
        let input = RestaurantDetailViewModel.Input()
        let output = vm.transform(input: input)
        
        output.restaurantDetail
            .drive(onNext: { [weak self] restaurantDetail in
                self?.updateData(restaurantDetail)
            })
            .disposed(by: disposeBag)
        
        output.menus
            .drive(tableView.rx.items(cellIdentifier: "MenuCell", cellType: MenuCell.self)) { row, menu, cell in
                cell.setupData(menu: menu)
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    private func updateData(_ data: RestaurantDetail) {
        titleLabel.text = data.storeName
        categoryLabel.text = data.category
        walkLabel.text = "도보 \(data.minutesByWalk)분"
        addressLabel.text = data.address
        contactLabel.text = data.contact
        businessHoursLabel.text = "영업시간: \(data.businessHours)"
        ratingStars.text = "별점: \(data.ratingStars) 점"
        
    }
}

extension RestaurantDetailViewController {
    private func setupUI() {
        view.backgroundColor = .grayScale50
        
        view.addSubviews(views: [
            titleLabel,
            paddingLabelView,
            contactLabel,
            addressLabel,
            businessHoursLabel,
            ratingStars,
            menuTitle,
            tableView
        ])
        
        [categoryLabel, walkLabel].forEach {
            paddingLabelView.addArrangedSubview($0)
        }
        categoryLabel.setContentHuggingPriority(.required, for: .horizontal)
        categoryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        walkLabel.setContentHuggingPriority(.required, for: .horizontal)
        walkLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().inset(16)
        }
        
        paddingLabelView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(paddingLabelView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        businessHoursLabel.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        ratingStars.snp.makeConstraints { make in
            make.top.equalTo(businessHoursLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        
        menuTitle.snp.makeConstraints { make in
            make.top.equalTo(ratingStars.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(menuTitle.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaInsets).inset(20)
        }
    }
}

