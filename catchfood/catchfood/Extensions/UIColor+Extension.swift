//
//  UIColor+Extension.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//
import UIKit

extension UIColor {
    /// 16진수 문자열(예: "#FF5733")을 UIColor로 변환하는 생성자
    ///
    /// - Parameters:
    ///   - hex: "#RRGGBB" 또는 "RRGGBB" 형태의 문자열
    ///   - opacity: 투명도 (0.0 ~ 1.0), 기본값은 1.0
    ///
    /// 사용 예:
    /// ```
    /// let color1 = UIColor(hex: "#FF5733")
    /// let color2 = UIColor(hex: "4287f5", opacity: 0.5)
    /// ```
    ///
    /// 잘못된 형식의 문자열을 넣을 경우 기본적으로 검은색에 가까운 컬러가 생성됨
    convenience init(hex: String, opacity: Double = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }

}
