//
//  PaddingLabel.swift
//  catchfood
//
//  Created by 방유빈 on 4/19/25.
//


import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 5.0, left: 10.0, bottom: 5.0, right: 10.0)
    override var text: String? {
        didSet {
            invalidateIntrinsicContentSize()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    convenience init(title: String) {
        self.init()
        self.text = title
        self.backgroundColor = .primaryColor
        self.textColor = .white
        self.font = .boldSystemFont(ofSize: 14)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.isUserInteractionEnabled = true
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let adjustedSize = CGSize(width: size.width - padding.left - padding.right,
                                  height: size.height - padding.top - padding.bottom)
        var contentSize = super.sizeThatFits(adjustedSize)
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }

    override var bounds: CGRect {
        didSet {
            if bounds.size != oldValue.size {
                invalidateIntrinsicContentSize()
            }
        }
    }
}
