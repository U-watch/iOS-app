//
//  ViewController.swift
//  U-watch
//
//  Created by 손동현 on 10/9/24.
//

import UIKit
import DGCharts


class HomeViewController: UIViewController {

    @IBOutlet weak var testimage: UIImageView!
    
    @IBOutlet weak var testimage2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        testimage.image = UIImage(named: "testimage")
        testimage2.image=UIImage(named: "testImage2")

    }


}
