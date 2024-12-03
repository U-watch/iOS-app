//
//  CommentViewCell.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    var comment: Comment? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        // init
    }
    
    private func updateUI() {
        guard let comment = self.comment else {
            return
        }
        
        idLabel.text = comment.writerId
        contentLabel.text = comment.content
        dateLabel.text = TextUtils.getDayPassed(from: comment.updatedAt)
        profileImage.sd_setImage(with: comment.profileUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
