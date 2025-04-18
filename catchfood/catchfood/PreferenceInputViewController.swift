//
//  PreferenceInputViewController .swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class PreferenceInputViewController: UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let nicknameTitleLable: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "ㅇㅇㅇ님의"
        return label
    }()
    private let titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "취향을 입력해주세요."
        return label
    }()
    
    private let subinfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .aTeamSubTextColor
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontSizeToFitWidth = true
        label.text = "각 내용당 100자 안으로 자유롭게 입력해주세요"
        return label
    }()
    
    private let likeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나는 이런걸 좋아해요"
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let likeTextCount: UILabel = {
        let label = UILabel()
        label.text = "0/100"
        label.textColor = .aTeamBodyTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let likeTextView = CFTextView(placeholder: "예시) 저는 매운걸 좋아하고, 한식을 가장 좋아해요")
    
    private let dislikeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "나는 이런걸 싫어해요"
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let dislikeTextCount: UILabel = {
        let label = UILabel()
        label.text = "0/100"
        label.textColor = .aTeamBodyTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let dislikeTextView = CFTextView(placeholder: "예시) 저는 오이를 싫어해요")
    
    private let etcTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "추가로 고려해주세요"
        label.textColor = .aTeamHeadLineTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let etcTextCount: UILabel = {
        let label = UILabel()
        label.text = "0/100"
        label.textColor = .aTeamBodyTextColor
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    private let etcTextView = CFTextView(placeholder: "예시)한끼에 만오천원 이하였으면 좋겠어요")
    
    private let saveButton = CFButton(styleType: .filled, title: "편집하기")
    
    private let currentMode = BehaviorRelay<PreferenceInputMode>(value: .view)
    
    private let vm = PreferenceInputViewModel()
    private let disposeBag = DisposeBag()
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bind()
    }
    
    private func bind() {
        // 버튼 탭 → 모드 전환 스트림
        saveButton.rx.tap
            .withUnretained(self)
            .subscribe { vc, _ in
                let mode: PreferenceInputMode = vc.currentMode.value == .edit ? .view : .edit
                vc.currentMode.accept(mode)
            }
            .disposed(by: disposeBag)
        likeTextView.rx.text
            .orEmpty
            .map { String($0.prefix(100)) }
            .bind(to: likeTextView.rx.text)
            .disposed(by: disposeBag)
        
        dislikeTextView.rx.text
            .orEmpty
            .map { String($0.prefix(100)) }
            .bind(to: dislikeTextView.rx.text)
            .disposed(by: disposeBag)
        
        etcTextView.rx.text
            .orEmpty
            .map { String($0.prefix(100)) }
            .bind(to: etcTextView.rx.text)
            .disposed(by: disposeBag)

        let input = PreferenceInputViewModel.Input(
            changeMode: currentMode.asObservable(),
            likeMessage: likeTextView.rx.text.orEmpty.asObservable(),
            dislikeMessage: dislikeTextView.rx.text.orEmpty.asObservable(),
            etcMessage: etcTextView.rx.text.orEmpty.asObservable()
        )
        
        let output = vm.transform(input: input)

        output.currentMode
            .drive(onNext: { [weak self] mode in
                self?.setupMode(mode)
            })
            .disposed(by: disposeBag)

        output.likeMessageCount
            .drive(onNext: { [weak self] cnt in
                self?.likeTextCount.text = "\(cnt)/100"
            })
            .disposed(by: disposeBag)
        output.dislikeMessageCount
            .drive(onNext: { [weak self] cnt in
                self?.dislikeTextCount.text = "\(cnt)/100"
            })
            .disposed(by: disposeBag)
        output.etcMessageCount
            .drive(onNext: { [weak self] cnt in
                self?.etcTextCount.text = "\(cnt)/100"
            })
            .disposed(by: disposeBag)
    }
    
    private func setupMode(_ mode: PreferenceInputMode) {
        switch mode {
        case .edit:
            likeTextView.isEditable = true
            dislikeTextView.isEditable = true
            etcTextView.isEditable = true
            saveButton.setTitle("저장하기", for: .normal)
        case .view:
            likeTextView.isEditable = false
            dislikeTextView.isEditable = false
            etcTextView.isEditable = false
            saveButton.setTitle("편집하기", for: .normal)
        }
    }
}

extension PreferenceInputViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubviews(views: [
            nicknameTitleLable,
            titleLable,
            subinfoLabel,
            likeTitleLabel,
            likeTextCount,
            likeTextView,
            dislikeTitleLabel,
            dislikeTextCount,
            dislikeTextView,
            etcTitleLabel,
            etcTextCount,
            etcTextView,
            saveButton
        ])
        
        nicknameTitleLable.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(nicknameTitleLable.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        subinfoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLable.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        likeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(subinfoLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(16)
        }
        likeTextCount.snp.makeConstraints { make in
            make.top.equalTo(likeTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        likeTextView.snp.makeConstraints { make in
            make.top.equalTo(likeTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        dislikeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(likeTextView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        dislikeTextCount.snp.makeConstraints { make in
            make.top.equalTo(dislikeTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        dislikeTextView.snp.makeConstraints { make in
            make.top.equalTo(dislikeTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        etcTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dislikeTextView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        etcTextCount.snp.makeConstraints { make in
            make.top.equalTo(etcTitleLabel)
            make.trailing.equalToSuperview().inset(16)
        }
        
        etcTextView.snp.makeConstraints { make in
            make.top.equalTo(etcTitleLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(etcTextView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-40)
        }
    }
}
