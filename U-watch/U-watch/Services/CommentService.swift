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
    
    var commentDict: [String: [AnyHashable: [Comment]]] = [:]
    
    private(set) var isFetching: Bool = false
    
    func fetchComments(forVideoId id: String,
                       forEmotion emotion: CommentEmotion? = nil,
                       forCategory category: CommentCategory? = nil,
                       atPage page: Int,
                       withSize size: Int = 10) async throws -> [Comment] {
        isFetching = true
        var apiResponse: APIResponse<[Comment]>
        do {
            apiResponse = try await APIClient.fetch(from: "comments/\(id)/all")
        } catch CustomError.response(let code, let message) {
            print("Response Error: \(code)")
            return []
        }
        
        let secondKey = getSecondKey(forEmotion: emotion, forCategory: category)
        if commentDict[id] == nil { commentDict[id] = [:] }
        if commentDict[id]![secondKey] == nil { commentDict[id]![secondKey] = [] }
        
        commentDict[id]![secondKey] = apiResponse.data
        
        isFetching = false
        return commentDict[id]![secondKey]!
    }
    
    func getComments(forVideoId id: String, forEmotion emotion: CommentEmotion? = nil, forCategory category: CommentCategory? = nil) -> [Comment] {
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
