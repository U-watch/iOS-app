//
//  CustomError.swift
//  U-watch
//
//  Created by 이승규 on 12/9/24.
//

enum CustomError: Error {
    case validation(message: String)
    case network(message: String)
    case response(code: Int, message: String)
    case unknown
}
