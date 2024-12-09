//
//  CurseSwitch.swift
//  U-watch
//
//  Created by 이승규 on 12/6/24.
//

import UIKit

class CurseSwitch: UISwitch {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        layer.cornerRadius = frame.height / 2
        backgroundColor = .systemRed
        clipsToBounds = true
    }

}
