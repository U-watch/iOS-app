//
//  DistributionView.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

import UIKit

class DistributionView: UIView {

    var data: [String: Float]? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        
    }

    private func updateUI() {
        
    }
}

class DistributionViewBar: UIView {
    
    var key: String? {
        didSet {
            updateUI()
        }
    }
    var value: Float? {
        didSet {
            updateUI()
        }
    }
    var highlight: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    var titleLabel: UILabel?
    var valueBar: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func awakeFromNib() {
        updateUI()
    }
    
    override func layoutSubviews() {
        updateUI()
    }
    
    private func setup() {
        titleLabel = UILabel()
        valueBar = UIView()
        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        valueBar?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel!)
        addSubview(valueBar!)
    }
    
    private func updateUI() {
        guard let titleLabel = self.titleLabel else {
            return
        }
        guard let valueBar = self.valueBar else {
            return
        }
        guard let value = self.value else {
            return
        }

        titleLabel.text = key
        
        if self.highlight {
            titleLabel.textColor = .systemRed
            valueBar.backgroundColor = .systemRed
        } else {
            titleLabel.textColor = .systemGray
            titleLabel.backgroundColor = .systemGray5
        }
        
        titleLabel.frame = CGRect(x: 8, y: 0, width: 55, height: 20)
        let totalWidth = self.bounds.width - 63
        valueBar.frame = CGRect(x: 63, y: 0, width: totalWidth * CGFloat(value / 100), height: 20)

    }
}
