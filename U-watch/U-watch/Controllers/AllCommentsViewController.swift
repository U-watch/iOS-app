//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit
import Foundation
import SkeletonView

class AllCommentsViewController:
    UIViewController, SkeletonTableViewDataSource, UITableViewDelegate,
    CommentViewCellDelegate, CommentListHeaderDelegate, CommentHolder {
    
    var video: Video?
    var comments = [Comment]()
    let cellIdentifier = "CommentViewCell"
    
    @IBOutlet weak var header: CommentListHeader!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        header.headerDelegate = self
        
        tableView.rowHeight = 72
        tableView.estimatedRowHeight = 72
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentViewCell
        cell.comment = comments[indexPath.row]
        cell.cellDelegate = self
        return cell
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func moreButtonPushed(for comment: Comment) {
        let wrongClassificationAction = UIAlertAction(title: "잘못된 분류", style: .default) { (action) in
         // Respond to user selection of the action
        }
        let reportAction = UIAlertAction(title: "신고하기", style: .default) { (action) in
         // Respond to user selection of the action
        }
        let blockAction = UIAlertAction(title: "댓글 차단", style: .default) { (action) in
         // Respond to user selection of the action
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
         // Respond to user selection of the action
        }
             
        let alert = UIAlertController(title: "댓글", message: nil, preferredStyle: .actionSheet)
        alert.addAction(wrongClassificationAction)
        alert.addAction(reportAction)
        alert.addAction(blockAction)
        alert.addAction(cancelAction)
             
        self.present(alert, animated: true) {
           // The alert was presented
        }
        print("More button pressed for \(comment.writerId)")
    }
    
    func searchBarTextChanged(to text: String?) {
        print("SearchBar text changed to '\(text)'")
    }
    
    func downloadButtonPressed() {
        print("Download Button Pressed")
    }
    
    func curseSwitchValueChanged(to value: Bool) {
        print("Curse switch value changed to \(value)")
    }

    func updateComment(forVideoId id: Int64) {
        comments = CommentService.shared.commentDict[id] ?? []
        tableView.reloadData()
    }
    
    func startLoading() {
        tableView.showAnimatedSkeleton()
    }
    
    func finishLoading() {
        tableView.stopSkeletonAnimation()
        tableView.hideSkeleton()
    }
    
}
