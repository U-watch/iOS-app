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
        let path = if emotion != nil {
            "comments/\(id)/detail/sentiment?sentiment=\(emotion!.rawValue)"
        } else if category != nil {
            "comments/\(id)/detail/category?category=\(category!.rawValue)"
        } else {
            "comments/\(id)/all"
        }
        
        let comments = await fetch(from: path, at: page, with: size)
        
        let secondKey = getSecondKey(forEmotion: emotion, forCategory: category)
        store(comments, to: id, and: secondKey)
        
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
    
    private func fetch(from path: String, at page: Int, with size: Int) async -> [Comment] {
        var apiResponse: APIResponse<[Comment]>
        do {
            apiResponse = try await APIClient.fetch(from: path)
        } catch CustomError.response(let code, let message) {
            print("Response Error: \(code)")
            return []
        } catch {
            print(error)
            return []
        }
        return apiResponse.data
    }
    
    private func store(_ data: [Comment], to id: String, and secondKey: AnyHashable) {
        if commentDict[id] == nil { commentDict[id] = [:] }
        if commentDict[id]![secondKey] == nil { commentDict[id]![secondKey] = [] }
        
        commentDict[id]![secondKey] = data
    }

}
