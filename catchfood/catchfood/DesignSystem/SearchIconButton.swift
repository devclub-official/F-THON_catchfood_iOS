//
//  SearchIconButton.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import UIKit

/// 시스템 돋보기 아이콘을 가진, 공통 스타일의 원형 버튼
public final class SearchIconButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    private func setupStyle() {
        let image = UIImage(systemName: "magnifyingglass")
        setImage(image, for: .normal)

        tintColor = .black
        backgroundColor = .white
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}
