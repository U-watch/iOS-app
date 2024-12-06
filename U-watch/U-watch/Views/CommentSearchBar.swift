//
//  CommentSearchBar.swift
//  U-watch
//
//  Created by 이승규 on 12/6/24.
//

import UIKit

class CommentSearchBar: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        translatesAutoresizingMaskIntoConstraints = false
        borderStyle = .none
        layer.cornerRadius = 12
        placeholder = "댓글 검색..."
        backgroundColor = UIColor(hex: "#E8EDF2")
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .gray
        
        let iconSize: CGFloat = 24
        let leadingGap: CGFloat = 12
        let trailingGap: CGFloat = 4
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: leadingGap + iconSize + trailingGap, height: iconSize))
        
        icon.frame = CGRect(x: leadingGap, y: 0, width: iconSize, height: iconSize)
        iconContainer.addSubview(icon)
        leftView = iconContainer
        leftViewMode = .always
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}
