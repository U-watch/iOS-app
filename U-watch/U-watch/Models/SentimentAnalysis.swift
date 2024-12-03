//
//  SentimentAnalysis.swift
//  U-watch
//
//  Created by 손동현 on 12/3/24.
//

import Foundation
// 감정 분석 데이터 모델
struct SentimentData: Codable {
    let positive: Int      // 긍정 비율 (%)
    let negative: Int      // 부정 비율 (%)
    let neutral: Int       // 중립 비율 (%)
}

// 감정 분포 데이터 모델
struct EmotionDistribution: Codable {
    let joy: Int           // 기쁨
    let anger: Int         // 분노
    let sadness: Int       // 슬픔
    let surprise: Int      // 놀람
    let fear: Int          // 두려움
}

// 전체 API 응답 데이터 모델
struct SentimentAnalysisResponse: Codable {
    let sentiment: SentimentData          // 감정 비율 데이터
    let mostCommonEmotion: String         // 가장 흔한 감정 (예: "기쁨")
    let emotionDistribution: EmotionDistribution // 감정 분포 데이터
}
