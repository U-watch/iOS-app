//
//  CommentService.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import Foundation

actor CommentService {
    static let shared = CommentService()
    
    private init() {}
    
    var commentDict: [Int64: [AnyHashable: [Comment]]] = [:]
    
    private(set) var isFetching: Bool = false
    
    func fetchComments(forVideoId id: Int64,
                       forEmotion emotion: CommentEmotion? = nil,
                       forCategory category: CommentCategory? = nil,
                       atPage page: Int,
                       withSize size: Int = 10) async throws -> [Comment] {
        isFetching = true
        try await Task.sleep(nanoseconds: 1_000_000_000 * 1)
        
        let secondKey = getSecondKey(forEmotion: emotion, forCategory: category)
        if commentDict[id] == nil { commentDict[id] = [:] }
        if commentDict[id]![secondKey] == nil { commentDict[id]![secondKey] = [] }
        for _ in 1...10 {
            commentDict[id]![secondKey]!.append(Comment(
                writerId: "@i_watch_you", content: "오늘 영상 꿀잼 ㅋㅋ", profileUrl: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fcool-profile-picture-87h46gcobjl5e4xu.jpg&f=1&nofb=1&ipt=38b304b587c323cafbec5b5c1024649fc31c8977ca6050f6b9e35a420d5c79ae&ipo=images")!, updatedAt: Date(),
                emotion: CommentEmotion.joy, cateogry: CommentCategory.reaction
            ))
        }
        isFetching = false
        return commentDict[id]![secondKey]!
    }
    
    func getComments(forVideoId id: Int64, forEmotion emotion: CommentEmotion? = nil, forCategory category: CommentCategory? = nil) -> [Comment] {
        let secondKey = getSecondKey(forEmotion: emotion, forCategory: category)
        return (commentDict[id] ?? [:])[secondKey] ?? []
    }
    
    private func getSecondKey(forEmotion emotion: CommentEmotion? = nil, forCategory category: CommentCategory? = nil) -> AnyHashable {
        if emotion != nil {
            emotion
        } else if category != nil {
            category
        } else {
            "All"
        }
    }
}
