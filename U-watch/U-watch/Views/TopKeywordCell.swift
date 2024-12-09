//
//  TopKeywordCell.swift
//  U-watch
//
//  Created by 이승규 on 12/6/24.
//

import UIKit

class TopKeywordCell: UIView {
    
    var topKeyword: TopKeyword? {
        didSet {
            updateUI()
        }
    }
    var tapCallback: ((TopKeyword) -> Void)?
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        loadFromXib(ofName: "TopKeywordCell")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let tapCallback = self.tapCallback else {
            return
        }
        guard let topKeyword = self.topKeyword else {
            return
        }
        tapCallback(topKeyword)
    }
    
    private func updateUI() {
        guard let topKeyword = self.topKeyword else {
            return
        }
        gradeLabel.text = getSymbolOf(grade: topKeyword.grade)
        keywordLabel.text = topKeyword.keyword
        countLabel.text = "\(topKeyword.count)회"
    }
    
    private func getSymbolOf(grade: Grade) -> String {
        return switch grade {
            case Grade.first:
                "🥇"
            case Grade.second:
                "🥈"
            case Grade.third:
                "🥉"
        }
    }
}
