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

class VideoViewController: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate, VideoTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VideoService.shared.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        
        let videos = VideoService.shared.videos
        if (!videos.isEmpty) {
            cell.video = videos[indexPath.row]
        }
        cell.delegate = self

        return cell
    }
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
       return "VideoTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 125
        self.tableView.estimatedRowHeight = 125
        
        if (VideoService.shared.videos.count == 0) {
            Task {
                try await VideoService.shared.fetchVideos(atPage: 0)
                completeLoading()
            }
        }
        
        self.tableView.showAnimatedSkeleton()
    }
    
    func completeLoading() {
        DispatchQueue.main.async {
            self.tableView.stopSkeletonAnimation()
            self.view.hideSkeleton()
            
            self.tableView.reloadData()
        }
    }
    
    func cellButtonPressed(forVideo video: Video) {
        if (video.status == Status.notAnalyzed) {
            Task {
                VideoService.shared.analyzeVideo(withId: video.id, executeAfterFinished: {
                    self.completeLoading()
                })
                self.completeLoading()
            }
        } else if (video.status == Status.analyzed) {
            if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
                detailVC.video = video
                navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}
