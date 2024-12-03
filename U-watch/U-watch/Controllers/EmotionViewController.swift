//
//  OverviewViewController.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import UIKit

class EmotionViewController: UIViewController, CommentHolder {
    
    var video: Video?
    var comments = [Comment]()
    
    func updateComment(forVideoId id: Int64) {
        comments = CommentService.shared.commentDict[id] ?? []
    }
    
    func startLoading() {
        // TODO: start loading
    }
    
    func finishLoading() {
        // TODO: end loading
    }
}
