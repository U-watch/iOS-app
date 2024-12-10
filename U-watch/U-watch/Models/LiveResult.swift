//
//  LiveResult.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

struct LiveResult: Decodable {
    let viewCount: Int
    let wordCloudName: String
    let emotionDistribution: [CommentEmotion: Int]
}
