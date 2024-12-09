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
    var countByEmotion: [CommentEmotion: Int]
    var countByCategory: [CommentCategory: Int]
}
