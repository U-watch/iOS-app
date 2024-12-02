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
        let viewCount = if (video.viewCount < 1_0000) {
            "\(video.viewCount)"
        } else {
            "\(video.viewCount / 1_0000)만"
        }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: video.uploadDate, to: Date())
        let date = if (components.day == 0) {
            "오늘"
        } else {
            "\(components.day ?? 0)일전"
        }
        infoLabel.text = "조회수 \(viewCount)회 / \(date)"
        
        thumbnail.sd_setImage(with: video.thumbnail, placeholderImage: UIImage(named: "placeholder"))
        
        button.status = video.status
        
        if (video.status == Status.analyzing) {
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
