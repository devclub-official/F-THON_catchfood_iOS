//
//  ATeamButtonStyleType.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import UIKit


/// 버튼 스타일 타입
enum CFButtonStyleType {
    case filled    // Primary 버튼 (배경색 있음)
    case outline   // Secondary 버튼 (보더만 있음)
}

/// 공통 버튼 컴포넌트
final class CFButton: UIButton {
    private let styleType: CFButtonStyleType
    
    init(
        styleType: CFButtonStyleType,
        title: String
    ) {
        self.styleType = styleType
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setupStyle()
        configureCommon()
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.4
        }
    }

    private func configureCommon() {
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }

    private func setupStyle() {
        let colors = getColors()

        switch styleType {
        case .filled:
            backgroundColor = colors.background
            setTitleColor(colors.textOnFilled, for: .normal)
            layer.borderWidth = 0

        case .outline:
            backgroundColor = .clear
            setTitleColor(colors.border, for: .normal)
            layer.borderColor = colors.border.cgColor
            layer.borderWidth = 1
        }
    }

    private func getColors() -> (background: UIColor, textOnFilled: UIColor, border: UIColor) {
        return (.primaryColor, .white, .primaryColor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
