//
//  VideosViewController.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import Foundation
import UIKit
import SDWebImage
import SkeletonView

class VideoViewController: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var videos: [Video] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        if (!videos.isEmpty) {
            cell.video = videos[indexPath.row]
        }
        
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "VideoTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 125
        self.tableView.estimatedRowHeight = 125
        Task {
            let videos = try await VideoService.shared.fetchVideos()
            setVideos(videos: videos)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.showAnimatedSkeleton()
    }
    
    func setVideos(videos: [Video]) {
        DispatchQueue.main.async {
            self.videos = videos
            
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton()
            
            self.tableView.reloadData()
        }
    }
}
