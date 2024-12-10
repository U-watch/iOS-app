//
//  My.swift
//  U-watch
//
//  Created by 손동현 on 11/30/24.
//

import Foundation

struct My: Codable {
    let code: String
    let message: String
    let data: UserData
}

struct UserData: Codable {
    let id: Int
    let googleId: String
    let name: String
    let email: String
    let profileImageUrl: String
    let role: String
    let channelTitle: String
}
