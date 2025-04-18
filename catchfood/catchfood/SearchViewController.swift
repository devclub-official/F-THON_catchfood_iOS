//
//  SearchViewController.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class SearchViewController: UIViewController {
    private let vm = SearchViewModel()
    private let disposeBag = DisposeBag()
    private let tableView = UITableView()
    private let searchTextField = CFTextField(placeholder: "오늘은 무엇을 먹고 싶으신가요?")
    private let searchButton = SearchIconButton()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "오늘 뭐먹지?"
        setupTableView()
        setupUI()
        bind()
    }
    
    private func setupTableView() {
        tableView.register(FoodListTableViewCell.self, forCellReuseIdentifier: "FoodListTableViewCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
    }
    private func setupUI() {
        view.backgroundColor = .grayScale50
        
        view.addSubviews(views: [tableView, searchTextField, searchButton])
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.equalToSuperview().inset(16)
        }
        searchButton.snp.makeConstraints { make in
            make.top.bottom.equalTo(searchTextField)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind() {
        let input = SearchViewModel.Input()
        let output = vm.transform(input: input)

        output.restaurants
            .drive(tableView.rx.items(cellIdentifier: "FoodListTableViewCell", cellType: FoodListTableViewCell.self)) { row, restaurant, cell in
                cell.setupData(restaurant: restaurant, isHiddenLikeButton: true)
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Restaurants.self)
            .subscribe(onNext: { [weak self] restaurant in
                // 여기에 이동 or 출력 등 원하는 동작
                print("클릭된 식당: \(restaurant.title)")
                let detailVC = RestaurantDetailViewController(restaurantId: restaurant.id)
                self?.navigationController?.pushViewController(detailVC, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
