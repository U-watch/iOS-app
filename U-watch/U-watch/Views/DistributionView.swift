//
//  DistributionView.swift
//  U-watch
//
//  Created by 이승규 on 12/10/24.
//

import UIKit

class DistributionView: UIView {

    var distData: [String: Float]? {
        didSet {
            updateUI()
        }
    }
    var bars = [DistributionViewBar]()
    let stackView = UIStackView()
    let mostLabel = UILabel()
    let percentLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mostLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        mostLabel.textColor = .systemRed
        mostLabel.translatesAutoresizingMaskIntoConstraints = false
        
        percentLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        percentLabel.textColor = .systemRed
        percentLabel.translatesAutoresizingMaskIntoConstraints = false

        stackView.axis = .vertical
//        stackView.spacing = 36
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(mostLabel)
        addSubview(percentLabel)
        addSubview(stackView)
        updateUI()
    }
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            mostLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mostLabel.topAnchor.constraint(equalTo: self.topAnchor),
            percentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            percentLabel.topAnchor.constraint(equalTo: mostLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: percentLabel.bottomAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func updateUI() {
        guard let data = self.distData else {
            return
        }
        for (key, value) in data {
            let bar = DistributionViewBar(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 20))
            bar.key = key
            bar.value = value
            bars.append(bar)
            stackView.addArrangedSubview(bar)
        }
        var maxIndex = 0
        for i in 0..<bars.count {
            if bars[maxIndex].value! < bars[i].value! {
                maxIndex = i
            }
        }
        
        for i in 0..<bars.count {
            if i == maxIndex {
                bars[i].highlight = true
            } else {
                bars[i].highlight = false
            }
        }
        
        mostLabel.text = bars[maxIndex].key
        percentLabel.text = "\(Int(bars[maxIndex].value!))%"
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
            valueBar.backgroundColor = .systemGray4
        }
        
        let padding: CGFloat = 8
        let labelWidth: CGFloat = 72
        titleLabel.frame = CGRect(x: padding, y: 0, width: labelWidth, height: 20)
        let totalWidth = self.bounds.width - (padding + labelWidth)
        valueBar.frame = CGRect(x: padding + labelWidth, y: 0, width: totalWidth * CGFloat(value / 100), height: 20)

    }
}
