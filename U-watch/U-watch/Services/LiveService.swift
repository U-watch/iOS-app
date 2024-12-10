//
//  LiveService.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

actor LiveService {
    static let shared = LiveService()
    private init() {}
    
    let interval: UInt64 = 5
    var index = 0
    let store = [
        LiveResult(viewCount: 32, wordCloudName: "wc1", emotionDistribution: [
            CommentEmotion.joy: 6,
            CommentEmotion.anger: 2,
            CommentEmotion.sadness: 1,
            CommentEmotion.suprise: 10,
            CommentEmotion.fear: 2,
            CommentEmotion.disgust: 1,
        ]),
        LiveResult(viewCount: 57, wordCloudName: "wc2", emotionDistribution: [
            CommentEmotion.joy: 4,
            CommentEmotion.anger: 1,
            CommentEmotion.sadness: 5,
            CommentEmotion.suprise: 8,
            CommentEmotion.fear: 3,
            CommentEmotion.disgust: 1,
        ]),
        LiveResult(viewCount: 89, wordCloudName: "wc3", emotionDistribution: [
            CommentEmotion.joy: 8,
            CommentEmotion.anger: 1,
            CommentEmotion.sadness: 0,
            CommentEmotion.suprise: 13,
            CommentEmotion.fear: 3,
            CommentEmotion.disgust: 2,
        ]),
        LiveResult(viewCount: 117, wordCloudName: "wc4", emotionDistribution: [
            CommentEmotion.joy: 6,
            CommentEmotion.anger: 2,
            CommentEmotion.sadness: 1,
            CommentEmotion.suprise: 10,
            CommentEmotion.fear: 2,
            CommentEmotion.disgust: 1,
        ]),
        LiveResult(viewCount: 171, wordCloudName: "wc5", emotionDistribution: [
            CommentEmotion.joy: 14,
            CommentEmotion.anger: 2,
            CommentEmotion.sadness: 0,
            CommentEmotion.suprise: 5,
            CommentEmotion.fear: 2,
            CommentEmotion.disgust: 3,
        ]),
        LiveResult(viewCount: 339, wordCloudName: "wc0", emotionDistribution: [
            CommentEmotion.joy: 21,
            CommentEmotion.anger: 0,
            CommentEmotion.sadness: 0,
            CommentEmotion.suprise: 5,
            CommentEmotion.fear: 1,
            CommentEmotion.disgust: 0,
        ])
    ]
        
    func next() async throws -> LiveResult {
        try await Task.sleep(nanoseconds: 1_000_000_000 * interval)
        let result = store[index]
        index = (index + 1) % store.count
        return result
    }
}
