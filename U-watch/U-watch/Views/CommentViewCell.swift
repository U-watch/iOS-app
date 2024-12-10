//
//  CommentViewCell.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

protocol CommentViewCellDelegate: AnyObject {
    func moreButtonPushed(for comment: Comment)
}

class CommentViewCell: UITableViewCell {
    
    var keyword: String? {
        didSet {
            updateUI()
        }
    }
    
    var comment: Comment? {
        didSet {
             updateUI()
        }
    }
    
    var cellDelegate: CommentViewCellDelegate?
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        let rotationAngle = CGFloat.pi / 2
        moreButton.transform = CGAffineTransform(rotationAngle: rotationAngle)
        moreButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        // isSkeletonable = true
    }
    
    private func updateUI() {
        guard let comment = self.comment else {
            return
        }
        
        idLabel.text = comment.authorName
        dateLabel.text = TextUtils.getDayPassed(from: comment.publishedAt)
        profileImage.sd_setImage(with: comment.authorProfileImage, placeholderImage: UIImage(named: "placeholder"))
        
        guard let keyword = self.keyword else {
            contentLabel.text = comment.commentText
            return
        }
        
        let fullText = comment.commentText
        let attributedString = NSMutableAttributedString(string: fullText)
        if let range = fullText.range(of: keyword) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttribute(.backgroundColor, value: UIColor.systemYellow, range: nsRange)
        }
        
        contentLabel.attributedText = attributedString
    }
    
    @objc private func buttonPressed() {
        if let comment = self.comment {
            cellDelegate?.moreButtonPushed(for: comment)
        }
    }
}
