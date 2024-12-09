//
//  DetailTabBar.swift
//  U-watch
//
//  Created by 이승규 on 12/2/24.
//

import UIKit

protocol DetailTabBarDelegate: AnyObject {
    func switchIndex(_ index: Int)
}

class DetailTabBar: UIToolbar {
    @IBInspectable var selectedIndex: Int = 0
    @IBInspectable var gap: CGFloat = 16
    @IBInspectable var fontSize: CGFloat = 14
    var tabBarDelegate: DetailTabBarDelegate?

    private var shadowView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowView == nil {
            addBottomShadow()
        }
        
        updateItems()
    }
    
    private func addBottomShadow() {
        let shadowView = UIView(frame: CGRect(x: 0, y: self.bounds.height - 1, width: self.bounds.width, height: 1))
        self.addSubview(shadowView)
        shadowView.backgroundColor = .systemGray5
//
//        NSLayoutConstraint.activate([
//            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            shadowView.heightAnchor.constraint(equalToConstant: 1)
//        ])
    }
    
    private func updateItems() {
        if items == nil { return }
        
        for (index, item) in items!.enumerated() {
            let label = UILabel()
            label.text = item.title
            label.font = UIFont.systemFont(ofSize: fontSize)
            label.sizeToFit()
            
            let button = UIView(frame: CGRect(x: 0, y: 0, width: label.frame.width + gap * 2, height: bounds.height))
            button.addSubview(label)
            
            let offset_y = CGFloat((button.bounds.height - label.frame.height) / 2)
            label.frame = CGRect(x: gap, y: offset_y, width: label.frame.width, height: label.frame.height)
            
            let shadow = UIView(frame: CGRect(x: gap, y: bounds.height - 3, width: label.frame.width, height: 3))
            button.addSubview(shadow)
            
            item.customView = button
            
            if index == selectedIndex {
                label.textColor = tintColor
                label.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
                shadow.backgroundColor = tintColor
            } else {
                label.textColor = .systemGray
                shadow.backgroundColor = .systemGray
            }
        }
    }
    
    private func updateIndex(_ index: Int) {
        selectedIndex = index
        updateItems()
        tabBarDelegate?.switchIndex(index)
    }
    
    private func setup() {
        setShadowImage(UIImage(), forToolbarPosition: .any)
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        self.clipsToBounds = false
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        if (items == nil) { return }
        for (index, item) in items!.enumerated() {
            let tappedLocation = sender.location(in: item.customView)
            if let customView = item.customView {
                if (tappedLocation.x <= customView.frame.width &&
                    tappedLocation.y <= customView.frame.height) {
                    updateIndex(index)
                    return
                }
            }
        }
    }
    
}
