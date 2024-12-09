//
//  AnalysisResult.swift
//  U-watch
//
//  Created by 이승규 on 12/7/24.
//

import Foundation

struct AnalysisResult {
    var analysisDate: Date
    var commentCountHistory: [Date: Int]
    var wordCloundUrl: URL
    var topKeywords: [TopKeyword]
    var positiveGauge: Float
    var countByEmotion: [CommentEmotion: Float]
    var countByCategory: [CommentCategory: Float]
}

struct VideoAnalysis: Decodable {
    let positiveRate: Float
    let sentimentDistribution: SentimentDistribution
    let categoryDistribution: CategoryDistribution
}

struct SentimentDistribution: Decodable {
    let JOY: Float
    let FEAR: Float
    let SURPRISE: Float
    let SADNESS: Float
    let ANGER: Float
    let DISGUST: Float
}

struct CategoryDistribution: Decodable {
    let REACTION: Float
    let INSULT: Float
    let QUESTION: Float
    let FEEDBACK: Float
    let SPAM: Float
}

struct TopKeywords: Decodable {
    let topKeyword1: String
    let topKeyword2: String
    let topKeyword3: String
    let topKeyword1Count: Int
    let topKeyword2Count: Int
    let topKeyword3Count: Int
}

struct VideoInfo: Decodable {
    let videoId: String
    let title: String
    let thumbnail: URL
    let viewCount: Int
    let commentCount: Int
    let lastUpdated: Date
    let wordCloudUrl: URL
}
