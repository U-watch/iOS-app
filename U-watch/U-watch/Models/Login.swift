//
//  Login.swift
//  U-watch
//
//  Created by 손동현 on 12/4/24.
//

import Foundation
struct LoginResponse: Codable {
    let message: String
    let userId: String
    let token: String
}
