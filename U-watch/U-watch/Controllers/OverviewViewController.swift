//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class OverviewViewController: UIViewController {
    var video: Video?
    
    @IBOutlet weak var firstKeywordCell: TopKeywordCell!
    @IBOutlet weak var secondKeywordSell: TopKeywordCell!
    @IBOutlet weak var thirdKeywordCell: TopKeywordCell!
    
    override func viewDidLoad() {
        firstKeywordCell.topKeyword = TopKeyword(keyword: "키워드 1", grade: Grade.first, count: 3605)
        firstKeywordCell.tapCallback = onTopKeywordTap(topKeyword:)
        secondKeywordSell.topKeyword = TopKeyword(keyword: "키워드 2", grade: Grade.second, count: 1055)
        secondKeywordSell.tapCallback = onTopKeywordTap(topKeyword:)
        thirdKeywordCell.topKeyword = TopKeyword(keyword: "키워드 3", grade: Grade.third, count: 203)
        thirdKeywordCell.tapCallback = onTopKeywordTap(topKeyword:)
    }
    
    func onTopKeywordTap(topKeyword: TopKeyword) {
        let storyboard = UIStoryboard(name: "Videos", bundle: nil)
        let modalVC = storyboard.instantiateViewController(identifier: "KeywordCommentsViewController") as! KeywordCommentsViewController
        
        modalVC.modalPresentationStyle = .popover
        modalVC.modalTransitionStyle = .coverVertical
        modalVC.video = video!

        present(modalVC, animated: true, completion: nil)
    }
}
