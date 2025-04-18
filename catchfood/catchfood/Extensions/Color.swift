//
//  Untitled.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import UIKit

extension UIColor {
    // MARK: - Brand
    /// 메인 강조 색상 (버튼, 포인트 등)
    static let primaryColor = UIColor(hex: "#ED6324")
    /// 서브 강조 색상 (포인트 강조, 배지 등)
    //static let secondaryColor = UIColor(hex: "#FFBE0B")
    
    // MARK: - State
    /// 성공 상태 (ex. 완료 알림, 체크 표시)
    static let successColor = UIColor(hex: "#4CAF50")
    /// 에러/실패 상태 (ex. 경고, 실패 알림)
    static let errorColor = UIColor(hex: "#EF4444")
    
    // MARK: - Text Color
    /// 제목 및 강한 강조 텍스트 색상 (ex. 헤드라인, 강조 텍스트)
    static let aTeamHeadLineTextColor = grayScale800
    
    /// 일반 본문 텍스트 (ex. 기본 UI 텍스트)
    static let aTeamBodyTextColor = grayScale500
    
    /// 보조 설명 텍스트 (ex. 설명 문구, 시간 등)
    static let aTeamSubTextColor = grayScale300
    
    /// View 테두리 등 사용되는 색상
    static let aTeamBorderColor = grayScale200
    
    /// 얇은 구분선 또는 배경 위 선 표현 시 사용
    static let aTeamStrokeColor = grayScale100
        
    
    // MARK: - GrayScale
    // 50(가장 연한색) ~ 800(가장 진한색)
    // 필요에 따라 사용
    static let grayScale50 = UIColor(hex: "#FAFAFC")
    static let grayScale100 = UIColor(hex: "#F2F2F5")
    static let grayScale200 = UIColor(hex: "#E9E9EE")
    static let grayScale300 = UIColor(hex: "#CCCCD0")
    static let grayScale400 = UIColor(hex: "#AFAFB2")
    static let grayScale500 = UIColor(hex: "#949297")
    static let grayScale600 = UIColor(hex: "#76747B")
    static let grayScale700 = UIColor(hex: "#595860")
    static let grayScale800 = UIColor(hex: "#3B3B45")
}
