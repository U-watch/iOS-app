//
//  CommentListHeader.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class CommentListHeader: UIView {
    
    @IBOutlet weak var searchBar: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CommentListHeader", bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth]
        addSubview(view)
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.contentMode = .scaleAspectFit
        icon.tintColor = .gray
        
        let iconSize: CGFloat = 24
        let trailingGap: CGFloat = 12
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: trailingGap + iconSize, height: iconSize))
        
        iconContainer.addSubview(icon)
        icon.frame = CGRect(x: trailingGap, y: 0, width: iconSize, height: iconSize)
        
        searchBar.leftView = iconContainer
        searchBar.leftViewMode = .always
    }
}
