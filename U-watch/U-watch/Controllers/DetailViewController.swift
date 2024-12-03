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
    
    @IBOutlet weak var tabbar: DetailTabBar!
    
    override func viewDidLoad() {
        navigationItem.title = video!.title
        
        // tag 1 means container
        for container in view.subviews.filter({ $0.tag == 1 }) {
            containers.append(container)
        }
        tabbar.tabBarDelegate = self
        switchIndex(0)
        
        if CommentService.shared.commentDict[video!.id] == nil {
            Task {
                try await CommentService.shared.fetchComments(forVideoId: video!.id)
                updateComments()
                finishLoading()
            }
            startLoading()
        }
        
        updateComments()
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
    
    func startLoading() {
        DispatchQueue.main.async {
            for controller in self.controllers {
                if let commentHolder = controller as? CommentHolder {
                    commentHolder.startLoading()
                }
            }
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            for controller in self.controllers {
                if let commentHolder = controller as? CommentHolder {
                    commentHolder.finishLoading()
                }
            }
        }
    }

    func updateComments() {
        DispatchQueue.main.async {
            for controller in self.controllers {
                if let commentHolder = controller as? CommentHolder {
                    commentHolder.updateComment(forVideoId: self.video!.id)
                }
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
