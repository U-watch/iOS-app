//
//  DetailViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/2/24.
//

import UIKit

class DetailViewController: UIViewController {
    var video: Video?
    
    override func viewDidLoad() {
        navigationItem.title = video?.title
    }
}
