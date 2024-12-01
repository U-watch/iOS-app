//
//  Comments.swift
//  U-watch
//
//  Created by 손동현 on 12/1/24.
//

import Foundation

struct CommentTrend: Codable {
    let date: String
    let comments: Int
}

struct CommentsResponse: Codable {
    let trend: [CommentTrend]
    let recentChange: String
}
