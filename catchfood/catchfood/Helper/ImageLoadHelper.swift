//
//  ImageLoadHelper.swift
//  catchfood
//
//  Created by 방유빈 on 4/18/25.
//

import UIKit

final class ImageLoadHelper {
    // 싱글톤 인스턴스
    static let shared = ImageLoadHelper()
    private init() {}

    /// 이미지 URL에서 UIImage 로드
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        // 유효한 URL인지 확인
        guard let url = URL(string: urlString) else {
            print("❌ 잘못된 URL입니다: \(urlString)")
            completion(UIImage(named: "DefaultImage"))
            return
        }

        // URLSession으로 비동기 이미지 로드
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ 이미지 다운로드 실패: \(error.localizedDescription)")
                completion(UIImage(named: "DefaultImage"))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("❌ 이미지 데이터 변환 실패")
                completion(UIImage(named: "DefaultImage"))
                return
            }

            // UI 업데이트는 반드시 메인 쓰레드에서
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
