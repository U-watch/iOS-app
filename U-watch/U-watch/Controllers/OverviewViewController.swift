//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class OverviewViewController: UIViewController {
    var video: Video?
    var result: AnalysisResult?
    
    @IBOutlet weak var wordCloudImage: UIImageView!
    @IBOutlet weak var positiveGuage: UIProgressView!
    @IBOutlet weak var positiveGuageLabel: UILabel!
    @IBOutlet weak var positiveGuageDescription: UILabel!
    @IBOutlet weak var firstKeywordCell: TopKeywordCell!
    @IBOutlet weak var secondKeywordSell: TopKeywordCell!
    @IBOutlet weak var thirdKeywordCell: TopKeywordCell!
    @IBOutlet weak var emotionDistribution: DistributionView!
    @IBOutlet weak var categoryDistributionView: DistributionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstKeywordCell.tapCallback = onTopKeywordTap(topKeyword:)
        secondKeywordSell.tapCallback = onTopKeywordTap(topKeyword:)
        thirdKeywordCell.tapCallback = onTopKeywordTap(topKeyword:)
        
        Task {
            guard let video = self.video else {
                return
            }
            self.result = try await AnalysisService.shared.getResult(for: video)
            updateUI()
        }
        view.showAnimatedSkeleton()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            guard let result = self.result else {
                return
            }
            
            self.view.stopSkeletonAnimation()
            self.view.hideSkeleton()
            
            self.wordCloudImage.sd_setImage(with: result.wordCloundUrl)
            
            self.positiveGuage.progress = result.positiveGauge / 100
            self.positiveGuageLabel.text = "\(Int(result.positiveGauge))%"
            self.positiveGuageDescription.text = TextUtils.getDiscription(of: result.positiveGauge)
            
            self.firstKeywordCell.topKeyword = result.topKeywords[0]
            self.secondKeywordSell.topKeyword = result.topKeywords[1]
            self.thirdKeywordCell.topKeyword = result.topKeywords[2]
            
            var data = [String: Float]()
            for (key, value) in result.countByEmotion {
                data[TextUtils.getDescription(of: key)] = value
            }
            self.emotionDistribution?.distData = data
            
            var data2 = [String: Float]()
            for (key, value) in result.countByCategory {
                data2[TextUtils.getDescription(of: key)] = value
            }
            self.categoryDistributionView?.distData = data2
        }
    }
    
    func onTopKeywordTap(topKeyword: TopKeyword) {
        let storyboard = UIStoryboard(name: "Videos", bundle: nil)
        let modalVC = storyboard.instantiateViewController(identifier: "KeywordCommentsViewController") as! KeywordCommentsViewController
        
        modalVC.modalPresentationStyle = .popover
        modalVC.modalTransitionStyle = .coverVertical
        modalVC.keyword = topKeyword.keyword
        
        modalVC.video = video!

        present(modalVC, animated: true, completion: nil)
    }
}
