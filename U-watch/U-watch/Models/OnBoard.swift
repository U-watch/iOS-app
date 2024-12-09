import Foundation

// API 응답을 나타내는 구조체
struct OnBoardResponse: Codable {
    let code: String
    let message: String
    let data: ChannelData
}

// 데이터 섹션 구조체
struct ChannelData: Codable {
    let channelId: String
    let channelName: String
    let thumbnail: String
}
