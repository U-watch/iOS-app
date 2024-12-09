//
//  VideoService.swift
//  U-watch
//
//  Created by 이승규 on 11/30/24.
//

import Foundation

class VideoService {
    static let shared = VideoService()
    
    private init() {}
    
    var videos = [Video]()

    func fetchVideos(atPage: Int, withSize: Int = 10) async throws {
        do {
            let response: APIResponse<[Video]> = try await APIClient.fetch(from: "video/top-videos?channelId=UCsJ6RuBiTVWRX156FVbeaGg")
            videos = response.data
        } catch {
//            print("Error occured: \(error)")
        }
    }
    
    func analyzeVideo(withId id: String, executeAfterFinished action: @escaping () -> Void) {
        let index = videos.firstIndex(where: { $0.videoId == id })
        if (index == nil) { return }
        videos[index!].analyzingStatus = Status.IN_PROGRESS
        Task {
            try await Task.sleep(nanoseconds: 1_000_000_000 * 2)
            videos[index!].analyzingStatus = Status.COMPLETED
            action()
        }
    }
}
