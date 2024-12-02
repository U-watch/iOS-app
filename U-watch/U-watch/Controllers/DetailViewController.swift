//
//  DetailViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/2/24.
//

import UIKit

class DetailViewController: UIViewController {
    var video: Video?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        titleLabel.text = video?.title
    }
}
