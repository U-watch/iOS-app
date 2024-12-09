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
        
        emotionSegmentControl.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        super.viewDidLoad()
    }
    
    @objc private func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.emotion = CommentEmotion.joy
        case 1:
            self.emotion = CommentEmotion.anger
        case 2:
            self.emotion = CommentEmotion.sadness
        case 3:
            self.emotion = CommentEmotion.suprise
        case 4:
            self.emotion = CommentEmotion.fear
        case 5:
            self.emotion = CommentEmotion.disgust
        default:
            print("Invalid value")
        }
        
        fetchInitialData()
        startLoading()
    }
}
