//
//  Sentiment.swift
//  U-watch
//
//  Created by 손동현 on 11/30/24.
//

import Foundation

struct SentimentResponse: Codable {
    let code: String        // 응답 코드
    let message: String     // 응답 메시지
    let data: SentimentData // 감정 데이터
}

struct SentimentData: Codable {
    let joy: Double            // 기쁨
    let anger: Double          // 분노
    let sadness: Double        // 슬픔
    let surprise: Double       // 놀람
    let fear: Double           // 공포
    let disgust: Double        // 혐오
}
