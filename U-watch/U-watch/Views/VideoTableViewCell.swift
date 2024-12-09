//
//  CustomTableViewCell.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import UIKit
import SDWebImage

protocol VideoTableViewCellDelegate: AnyObject {
    func cellButtonPressed(forVideo video: Video)
}

class VideoTableViewCell: UITableViewCell {
    weak var delegate: VideoTableViewCellDelegate?
    
    var video: Video? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var button: AnalyzeButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func updateUI() {
        guard let video = video else { return }
        
        titleLabel.text = video.title
        
        let viewCount = TextUtils.getFormatedNumber(of: video.viewCount)
        let date = TextUtils.getDayPassed(from: video.publishedAt)
        infoLabel.text = "조회수 \(viewCount)회 / \(date)"
        
        thumbnail.sd_setImage(with: video.thumbnail, placeholderImage: UIImage(named: "placeholder"))
        
        button.status = video.analyzingStatus
        
        if (video.analyzingStatus == Status.IN_PROGRESS) {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }
    
    @objc func buttonTapped() {
        delegate?.cellButtonPressed(forVideo: video!)
    }
}
