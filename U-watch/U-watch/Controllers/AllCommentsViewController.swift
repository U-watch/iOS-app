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
        
        for i in 1...20 {
            comments.append(Comment(
                writerId: "asdf", content: "good video", profileUrl: URL(string: "sldkjfs")!, updatedAt: Date()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentViewCell", for: indexPath)
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "CommentViewCell"
    }
    
}
