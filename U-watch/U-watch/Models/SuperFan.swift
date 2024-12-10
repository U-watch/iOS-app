//
//  SuperFan.swift
//  U-watch
//
//  Created by 손동현 on 12/3/24.
//

import Foundation

// 개별 팬 정보를 나타내는 구조체
struct SuperFan: Codable {
    let authorName: String            // 팬 이름
    let authorProfileImageUrl: String // 팬 프로필 이미지 URL
    let commentCount: Int             // 댓글 수
}

// 서버 응답을 나타내는 구조체
struct SuperFanResponse: Codable {
    let code: String                  // 응답 코드
    let message: String               // 응답 메시지
    let data: [SuperFan]              // 열혈 팬 리스트
}
