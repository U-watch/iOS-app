//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class EmotionViewController: CommonCommentViewController {
    
    @IBOutlet weak var emotionSegmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        emotion = CommentEmotion.joy
        super.viewDidLoad()
    }
}
