//
//  UIView+Extension.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import UIKit

extension UIView {
    /// 여러 개의 서브뷰를 한 번에 추가하는 편의 메서드
    ///
    /// - Parameter views: 추가할 뷰 배열
    ///
    /// 사용 예:
    /// ```
    /// view.addSubviews(views: [label, button, imageView])
    /// ```
    func addSubviews(views: [UIView]) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
