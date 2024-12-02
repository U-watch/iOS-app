//
//  DetailViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/2/24.
//

import UIKit

class DetailViewController: UIViewController, DetailTabBarDelegate {
    
    var video: Video?
    var containers = [UIView]()
    
    @IBOutlet weak var tabbar: DetailTabBar!
    
    override func viewDidLoad() {
        navigationItem.title = video?.title
        
        // tag 1 means container
        for container in view.subviews.filter({ $0.tag == 1 }) {
            containers.append(container)
        }
        tabbar.tabBarDelegate = self
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
