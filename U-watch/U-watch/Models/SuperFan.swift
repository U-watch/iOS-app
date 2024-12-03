//
//  SuperFan.swift
//  U-watch
//
//  Created by 손동현 on 12/3/24.
//

import Foundation

// 개별 팬 정보를 나타내는 구조체
struct SuperFan: Codable {
    let userId: String          // 사용자 ID
    let username: String        // 사용자 이름
    let profileImage: String    // 프로필 이미지 URL
    let interactionCount: Int   // 상호작용 횟수
}

// 서버 응답을 나타내는 구조체
struct SuperFanResponse: Codable {
    let superFans: [SuperFan]   // 열혈 팬 리스트
}
