//
//  Comment.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import Foundation

struct Comment {
    var writerId: String
    var content: String
    var profileUrl: URL
    var updatedAt: Date
    var emotion: CommentEmotion
    var cateogry: CommentCategory
}

enum CommentEmotion {
    case joy
    case anger
    case sadness
    case suprise
    case fear
    case disgust
}

enum CommentCategory {
    case reaction
    case feedback
    case question
    case spam
    case curse
}
