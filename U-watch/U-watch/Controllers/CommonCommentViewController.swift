//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit
import Foundation
import SkeletonView

class CommonCommentViewController: UIViewController, SkeletonTableViewDataSource, UITableViewDelegate, CommentViewCellDelegate, UITextFieldDelegate {
    
    var video: Video?
    var emotion: CommentEmotion?
    var category: CommentCategory?
    var keyword: String?
    var comments = [Comment]()
    
    let cellIdentifier = "CommentViewCell"
    private var debounceTimer: Timer?
    private let debounceInterval: TimeInterval = 1.0
    
    @IBOutlet weak var searchBar: CommentSearchBar!
    @IBOutlet weak var downloadButton: DownloadButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var curseSwitch: CurseSwitch!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 72
        tableView.estimatedRowHeight = 72
        
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar?.delegate = self
        
        fetchInitialData()
        startLoading()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentViewCell
        cell.comment = comments[indexPath.row]
        cell.keyword = keyword
        cell.cellDelegate = self
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        // Trigger load more when the user is within 100 points of the bottom
        if offsetY > contentHeight - height - 100 {
            Task {
                if (await CommentService.shared.isFetching) { return }
                guard let id = video?.videoId else {
                    return
                }
                self.comments = try await CommentService.shared.fetchComments(
                    forVideoId: id,
                    forEmotion: emotion,
                    forCategory: category,
                    forKeyword: keyword,
                    atPage: self.comments.count / 10
                )
                tableView.reloadData()
            }
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return cellIdentifier
    }
    
    func moreButtonPushed(for comment: Comment) {
        let wrongClassificationAction = UIAlertAction(title: "잘못된 분류", style: .default) { (action) in
            // Respond to user selection of the action
        }
        let reportAction = UIAlertAction(title: "신고하기", style: .destructive) { (action) in
            // Respond to user selection of the action
        }
        let blockAction = UIAlertAction(title: "댓글 차단", style: .destructive) { (action) in
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
        print("More button pressed for \(comment.authorName)")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let timer = self.debounceTimer {
            timer.invalidate()
        }
        self.debounceTimer = Timer.scheduledTimer(withTimeInterval: self.debounceInterval, repeats: false) { timer in
            self.keyword = self.searchBar.text
            self.applyFilter(keyword: self.keyword)
        }
        return true
    }
    
    func downloadButtonPressed() {
        print("Download Button Pressed")
    }
    
    func curseSwitchValueChanged(to value: Bool) {
        print("Curse switch value changed to \(value)")
    }
    
    func startLoading() {
        tableView.showAnimatedSkeleton()
        countLabel?.showAnimatedSkeleton()
    }
    
    func finishLoading() {
        tableView.stopSkeletonAnimation()
        tableView.hideSkeleton()
        countLabel?.stopSkeletonAnimation()
        countLabel?.hideSkeleton()
    }
    
    func fetchInitialData() {
        Task {
            guard let id = video?.videoId else {
                return
            }
            var comments = await CommentService.shared.getComments(
                forVideoId: id,
                forEmotion: emotion,
                forCategory: category,
                forKeyword: keyword
            )
            if comments.count == 0 {
                comments = try await CommentService.shared.fetchComments(
                    forVideoId: id,
                    forEmotion: emotion,
                    forCategory: category,
                    forKeyword: keyword,
                    atPage: 0
                )
            }
            updateComments(comments)
        }
    }
    
    private func applyFilter(keyword: String?, cursed: Bool = false) {
        Task {
            guard let id = video?.videoId else {
                return
            }
            var comments = await CommentService.shared.getComments(
                forVideoId: id,
                forEmotion: emotion,
                forCategory: category
            )
            
            if keyword != nil && keyword!.isEmpty == false {
                comments = comments.filter({ $0.commentText.contains(keyword!) })
            }
            // TODO: Need to fileter cursed predicate
            
            updateComments(comments)
        }
    }
    
    private func updateComments(_ comments: [Comment]) {
        DispatchQueue.main.async {
            self.comments = comments
            self.tableView.reloadData()
            self.finishLoading()
            self.countLabel?.text = "댓글 \(comments.count)개"
        }
    }
}
