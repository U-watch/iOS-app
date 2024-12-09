//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class CategoryViewController: CommonCommentViewController {

    @IBOutlet weak var categorySegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        category = CommentCategory.reaction
        
        categorySegmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        super.viewDidLoad()
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.category = CommentCategory.reaction
        case 1:
            self.category = CommentCategory.feedback
        case 2:
            self.category = CommentCategory.question
        case 3:
            self.category = CommentCategory.spam
        case 4:
            self.category = CommentCategory.curse
        default:
            print("Invalid value")
        }
        
        fetchInitialData()
        startLoading()
    }
}
