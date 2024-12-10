//
//  TestCell.swift
//  U-watch
//
//  Created by 손동현 on 12/10/24.
//

import UIKit

class TestCell: UITableViewCell {
    @IBOutlet weak var authorProfileImageUrl: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var commentCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCircularImageView()
    }

    private func setupCircularImageView() {
        authorProfileImageUrl.layer.cornerRadius = authorProfileImageUrl.frame.size.width / 2
        authorProfileImageUrl.clipsToBounds = true
    }
}
