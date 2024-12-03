//
//  TextUtils.swift
//  U-watch
//
//  Created by 이승규 on 12/3/24.
//

import Foundation

class TextUtils {
    static func getDayPassed(from startDate: Date, to endDate: Date = Date()) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return if (components.day == 0) {
            "오늘"
        } else {
            "\(components.day ?? 0)일전"
        }
    }
    
    static func getFormatedNumber(of number: Int) -> String {
        let string = if (number < 1000) {
            "\(number)"
        } else if (number < 1_0000) {
            "\(number / 1000)천"
        } else if (number < 1_0000_0000) {
            "\(number / 1_0000)만"
        } else {
            "\(number / 1_0000_0000)억"
        }
        
        return string
    }
    
    static func getFormattedDate(of date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        return formatter.string(from: date)
    }
}
