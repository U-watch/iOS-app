//
//  Video.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import Foundation

struct Video: Codable {
    var videoId: String
    var title: String
    var thumbnail: URL
    var viewCount: Int
    var likeCount: Int
    var commentCount: Int
    var publishedAt: Date
    var analyzingStatus: Status
}

enum Status: String, Codable {
    case COMPLETED = "COMPLETED"
    case IN_PROGRESS = "IN_PROGRESS"
    case NOT_STARTED = "NOT_STARTED"
}
