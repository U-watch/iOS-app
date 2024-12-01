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

    func fetchVideos(atPage: Int, withSize: Int = 10) async throws -> [Video] {
        try await Task.sleep(nanoseconds: 1_000_000_000 * 2)
        videos = [
            Video(title: "샘플 비디오 1", viewCount: 53000, uploadDate: Date(), thumbnail: URL(string: "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8JTIzaW1hZ2V8ZW58MHx8MHx8fDA%3D")!, status: Status.notAnalyzed),
            Video(title: "샘플 비디오 2", viewCount: 303029, uploadDate: Date(), thumbnail: URL(string: "https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg")!, status: Status.analyzed),
            Video(title: "샘플 비디오 3", viewCount: 7523090, uploadDate: Date(), thumbnail: URL(string: "https://www.aiarty.com/images/home-img/slider2.jpg")!, status: Status.analyzing),
        ]
        
        return videos
    }
}
