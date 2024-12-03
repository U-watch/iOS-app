//
//  CommentService.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import Foundation

class CommentService {
    static let shared = CommentService()
    
    private init() {}
    
    var commentDict: [Int64: [Comment]] = [:]
    
    func fetchComments(forVideoId id: Int64) async throws {
        try await Task.sleep(nanoseconds: 1_000_000_000 * 4)
        
        var comments = [Comment]()
        for _ in 1...20 {
            comments.append(Comment(
                writerId: "@i_watch_you", content: "오늘 영상 꿀잼 ㅋㅋ", profileUrl: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fcool-profile-picture-87h46gcobjl5e4xu.jpg&f=1&nofb=1&ipt=38b304b587c323cafbec5b5c1024649fc31c8977ca6050f6b9e35a420d5c79ae&ipo=images")!, updatedAt: Date()
            ))
        }
        
        commentDict[id] = comments
    }
}
