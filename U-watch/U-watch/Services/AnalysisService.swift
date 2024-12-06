//
//  AnalysisService.swift
//  U-watch
//
//  Created by 이승규 on 12/7/24.
//

import Foundation

class AnalysisService {
    static let shared = AnalysisService()
    private init() {}
    
    func getResult(for video: Video) async throws -> AnalysisResult {
        try await Task.sleep(nanoseconds: 1_000_000_000 * 3)
        
        return AnalysisResult(analysisDate: Date(),
                              commentCountHistory: [:],
                              wordCloundUrl: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fnanx.me%2Fimage%2Fwordcloud.png&f=1&nofb=1&ipt=862b329ca19a4a82819f0b3be8a0036294a8b9fe9980398b4709529e6aec6c0a&ipo=images")!,
                              topKeywords: [
                                TopKeyword(keyword: "keyword1", grade: Grade.first, count: 3952),
                                TopKeyword(keyword: "keyword2", grade: Grade.second, count: 552),
                                TopKeyword(keyword: "keyword3", grade: Grade.third, count: 203)
                              ],
                              positiveGauge: 0.78,
                              countByEmotion: [
                                CommentEmotion.joy: 203,
                                CommentEmotion.anger: 20,
                                CommentEmotion.disgust: 2,
                                CommentEmotion.fear: 101,
                                CommentEmotion.sadness: 39,
                                CommentEmotion.suprise: 59
                              ],
                              countByCategory: [
                                CommentCategory.reaction: 350,
                                CommentCategory.curse: 30,
                                CommentCategory.feedback: 29,
                                CommentCategory.question: 59,
                                CommentCategory.spam: 10
                              ])
    }
}
