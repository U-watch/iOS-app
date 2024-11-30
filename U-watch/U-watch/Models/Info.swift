//
//  info.swift
//  U-watch
//
//  Created by 손동현 on 11/30/24.
//

import Foundation


struct Info: Codable {
    let channelName: String
    let username: String
    let profileImage: String
    let subscriberCount: Int
    let videoCount: Int
    let totalViews: Int
    let likeCount: Int
}
