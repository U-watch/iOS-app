//
//  DownloadButton.swift
//  U-watch
//
//  Created by 이승규 on 12/6/24.
//

import UIKit

class DownloadButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        layer.cornerRadius = 12
        clipsToBounds = true
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 40),
            heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
