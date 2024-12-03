//
//  Video.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import Foundation

struct Video {
    var id: Int64
    var title: String
    var viewCount: Int
    var commentCount: Int
    var uploadDate: Date
    var thumbnail: URL
    var status: Status
}

enum Status {
    case analyzed
    case analyzing
    case notAnalyzed
}
