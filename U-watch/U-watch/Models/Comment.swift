//
//  Comment.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import Foundation

struct Comment: Codable {
    var authorName: String
    var authorProfileImage: URL
    var commentText: String
    var publishedAt: Date
    var likeCount: Int
//    var emotion: CommentEmotion
//    var cateogry: CommentCategory
}

enum CommentEmotion: String, Codable {
    case joy = "JOY"
    case anger = "ANGER"
    case sadness = "SADNESS"
    case suprise = "SUPRISE"
    case fear = "FEAR"
    case disgust = "DIGUST"
}

enum CommentCategory: String, Codable {
    case reaction = "REACTION"
    case feedback = "FEEDBACK"
    case question = "QUESTION"
    case spam = "SPAM"
    case curse = "INSULT"
}
