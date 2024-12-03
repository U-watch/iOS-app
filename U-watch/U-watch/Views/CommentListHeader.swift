//
//  CommentListHeader.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class CommentListHeader: UIView {
    
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var curseSwitch: UISwitch!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var downloadButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        updateLayout()
    }
    
    private func updateLayout() {
        curseSwitch.layer.cornerRadius = curseSwitch.frame.height / 2
        curseSwitch.backgroundColor = .systemRed
        curseSwitch.clipsToBounds = true
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
        let leadingGap: CGFloat = 12
        let trailingGap: CGFloat = 4
        let iconContainer = UIView(frame: CGRect(x: 0, y: 0, width: leadingGap + iconSize + trailingGap, height: iconSize))
        
        iconContainer.addSubview(icon)
        icon.frame = CGRect(x: leadingGap, y: 0, width: iconSize, height: iconSize)
        
        searchBar.leftView = iconContainer
        searchBar.leftViewMode = .always
    }
}
