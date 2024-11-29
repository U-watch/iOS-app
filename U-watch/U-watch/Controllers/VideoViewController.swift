//
//  VideosViewController.swift
//  U-watch
//
//  Created by 이승규 on 11/29/24.
//

import Foundation
import UIKit
import SDWebImage

class VideoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: [Video] = [
        Video(title: "샘플 비디오 1", viewCount: 53000, uploadDate: Date(), thumbnail: URL(string: "https://plus.unsplash.com/premium_photo-1664474619075-644dd191935f?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8JTIzaW1hZ2V8ZW58MHx8MHx8fDA%3D")!, status: Status.notAnalyzed),
        Video(title: "샘플 비디오 2", viewCount: 303029, uploadDate: Date(), thumbnail: URL(string: "https://gratisography.com/wp-content/uploads/2024/10/gratisography-cool-cat-800x525.jpg")!, status: Status.analyzed),
        Video(title: "샘플 비디오 3", viewCount: 7523090, uploadDate: Date(), thumbnail: URL(string: "https://www.aiarty.com/images/home-img/slider2.jpg")!, status: Status.analyzing),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoTableViewCell", for: indexPath) as! VideoTableViewCell
        cell.video = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        items[2].uploadDate = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    }
}
