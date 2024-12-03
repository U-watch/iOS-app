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
}
