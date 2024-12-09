//
//  AnalyzeButton.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import UIKit

class AnalyzeButton: UIButton {
    
    var status: Status? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        switch status {
        case .COMPLETED:
            setTitleColor(UIColor.darkGray, for: .normal)
            setTitleColor(UIColor.gray, for: .highlighted)
            setTitle("결과 보기", for: .normal)
            tintColor = UIColor.secondarySystemBackground
            isEnabled = true
        case .IN_PROGRESS:
            setTitleColor(UIColor.lightGray, for: .normal)
            setTitle("분석중", for: .normal)
            tintColor = UIColor.secondarySystemBackground
            isEnabled = false
        case .NOT_STARTED:
            setTitleColor(UIColor.white, for: .normal)
            setTitleColor(UIColor.lightText, for: .highlighted)
            setTitle("분석", for: .normal)
            tintColor = UIColor.systemBlue
            isEnabled = true
        case .none:
            return
        }
    }
}
