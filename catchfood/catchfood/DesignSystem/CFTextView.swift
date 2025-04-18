//
//  CFTextView.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//

import UIKit

/// 앱 전반에서 사용할 공통 스타일의 텍스트뷰
public final class CFTextView: UITextView {
    
    // Placeholder label
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    public var placeholder: String? {
        didSet {
            placeholderLabel.text = placeholder
        }
    }

    public override var text: String! {
        didSet {
            updatePlaceholderVisibility()
        }
    }

    public override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
        }
    }

    public init(placeholder: String = "") {
        super.init(frame: .zero, textContainer: nil)
        self.placeholder = placeholder
        setupStyle()
        setupPlaceholder()
        updatePlaceholderVisibility()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
        setupPlaceholder()
        updatePlaceholderVisibility()
    }

    private func setupStyle() {
        font = .systemFont(ofSize: 15)
        textColor = .label
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        textContainerInset = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        delegate = self
    }

    private func setupPlaceholder() {
        addSubview(placeholderLabel)
        placeholderLabel.text = placeholder
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: topAnchor, constant: textContainerInset.top),
            placeholderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: textContainerInset.left + 2)
        ])
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

// MARK: - UITextViewDelegate
extension CFTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
}
