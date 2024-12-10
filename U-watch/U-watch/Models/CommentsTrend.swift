//
//  CommentsTrend.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

import Foundation

struct CommentsTrend: Decodable {
    let interval: Int
    let startedAt: Date
    let commentCount: [Int]
}
