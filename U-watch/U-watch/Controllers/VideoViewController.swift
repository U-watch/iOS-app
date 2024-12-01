//
//  VideosViewController.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import Foundation
import UIKit
import SDWebImage

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let videos = try await VideoService.shared.fetchVideos()
            setVideos(videos: videos)
        }
    }
    
    func setVideos(videos: [Video]) {
        DispatchQueue.main.async {
            self.videos = videos
            self.tableView.reloadData()
        }
    }
}
