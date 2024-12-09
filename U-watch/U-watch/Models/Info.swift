//
//  info.swift
//  U-watch
//
//  Created by 손동현 on 11/30/24.
//

import Foundation

struct Info: Codable {
    let code: String
    let message: String
    let data: ChannelData
}

struct ChannelData: Codable {
    let channelId: String        // 채널 ID
    let channelName: String      // 채널명
    let customUrl: String        // 커스텀 URL @채널
    let thumbnail: String        // 썸네일 이미지 URL
    let subscriberCount: Int     // 구독자 수
    let videoCount: Int          // 동영상 수
    let viewCount: Int           // 총 조회수
    let likeCount: Int           // 좋아요 수
    let wordcloud: String        // 워드클라우드 이미지 URL
}
