//
//  CFTextField.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//


import UIKit

final class CFTextField: UITextField {
    
    private let clearButton = UIButton(type: .custom)
    private let horizontalPadding: CGFloat = 12  // ← 패딩 크기 설정
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        borderStyle = .roundedRect
        font = .systemFont(ofSize: 14, weight: .medium)
        textColor = .aTeamHeadLineTextColor
        setupClearButton()
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    


    private func setupClearButton() {
        clearButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        clearButton.tintColor = .grayScale400
        clearButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        clearButton.frame = CGRect(x: 0, y: 0, width: 36, height: 36)

        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
        rightView = clearButton
        rightViewMode = .never
    }

    @objc private func clearText() {
        self.text = ""
        sendActions(for: .editingChanged)
        updateClearButtonVisibility()
    }

    @objc private func textDidChange() {
        updateClearButtonVisibility()
    }

    private func updateClearButtonVisibility() {
        rightViewMode = (self.text?.isEmpty == false) ? .always : .never
    }

    // MARK: - Padding 적용

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: horizontalPadding, bottom: 0, right: horizontalPadding + 24))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
