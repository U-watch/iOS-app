//
//  CustomTableViewCell.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import UIKit
import SDWebImage

class VideoTableViewCell: UITableViewCell {
    
    var video: Video? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var button: AnalyzeButton!
    
    @IBAction func analyzeButton(_ sender: Any) {
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
    }
}
