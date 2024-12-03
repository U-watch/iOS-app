//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit
import Foundation
import SkeletonView

class AllCommentsViewController: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate {
    var video: Video?
    var comments = [Comment]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...20 {
            comments.append(Comment(
                writerId: "@i_watch_you", content: "오늘 영상 꿀잼 ㅋㅋ", profileUrl: URL(string: "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwallpapers.com%2Fimages%2Fhd%2Fcool-profile-picture-87h46gcobjl5e4xu.jpg&f=1&nofb=1&ipt=38b304b587c323cafbec5b5c1024649fc31c8977ca6050f6b9e35a420d5c79ae&ipo=images")!, updatedAt: Date()
            ))
        }
        
        tableView.rowHeight = 72
        tableView.estimatedRowHeight = 72
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentViewCell", for: indexPath) as! CommentViewCell
        cell.comment = comments[indexPath.row]
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CommentViewCell"
    }
    
}
