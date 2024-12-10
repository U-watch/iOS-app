//
//  ViewController.swift
//  U-watch
//
//  Created by 손동현 on 10/9/24.
//

import UIKit
import DGCharts


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    // 테스트용 데이터
    let testSubscribers = [
        ("kingmusle", "테스트 구독자 1"),
        ("dogegotomoon", "테스트 구독자 2"),
        ("catloversd", "테스트 구독자 32")
    ]



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testSubscribers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TestCell", for: indexPath)
        _ = testSubscribers[indexPath.row]



        return cell
    }
    

    @IBOutlet weak var testimage: UIImageView!
    
    @IBOutlet weak var testimage2: UIImageView!

    @IBOutlet weak var subscriberTableView: UITableView!
    
    @IBOutlet weak var nameLabel: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        testimage.image = UIImage(named: "testimage")
        testimage2.image=UIImage(named: "testImage2")

        // 테이블 뷰 설정
        subscriberTableView.delegate = self
        subscriberTableView.dataSource = self
        

    }





}
