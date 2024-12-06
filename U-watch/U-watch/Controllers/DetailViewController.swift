//
//  DetailViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/2/24.
//

import UIKit
import Foundation

protocol CommentHolder: AnyObject {
    func updateComment(forVideoId id: Int64)
    func startLoading()
    func finishLoading()
}

class DetailViewController: UIViewController, DetailTabBarDelegate {
    
    var video: Video?
    var containers = [UIView]()
    var controllers = [UIViewController]()
    
    @IBOutlet weak var analyzedDateLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    @IBOutlet weak var tabbar: DetailTabBar!
    
    override func viewDidLoad() {
        navigationItem.title = video!.title
        
        analyzedDateLabel.text = "최근 분석일: \(TextUtils.getFormattedDate(of: video!.uploadDate))"
        commentCountLabel.text = TextUtils.getFormatedNumber(of: video!.commentCount)
        viewCountLabel.text = TextUtils.getFormatedNumber(of: video!.viewCount)

        // tag 1 means container
        for container in view.subviews.filter({ $0.tag == 1 }) {
            containers.append(container)
        }
        tabbar.tabBarDelegate = self
        switchIndex(0)
    }
    
    func switchIndex(_ index: Int) {
        for (i, container) in containers.enumerated() {
            if i == index {
                container.isHidden = false
            } else {
                container.isHidden = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.controllers.append(segue.destination)
        if let destinationVC = segue.destination as? OverviewViewController {
            destinationVC.video = video
            // TODO: Pass Data
        }
        if let destinationVC = segue.destination as? AllCommentsViewController {
            destinationVC.video = video
            // TODO: Pass Data
        }
        if let destinationVC = segue.destination as? EmotionViewController {
            destinationVC.video = video
            // TODO: Pass Data
        }
        if let destinationVC = segue.destination as? CategoryViewController {
            destinationVC.video = video
            // TODO: Pass Data
        }
    }
}
