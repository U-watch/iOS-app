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
        guard let day = components.day else {
            return "잘못된 날짜"
        }
        return if day == 0 {
            "오늘"
        } else if day >= 365 {
            "\(Int(day / 365))년전"
        } else {
            "\(day)일전"
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
    
    static func getDiscription(of guage: Float) -> String {
        if guage > 80 {
            "매우 긍정적"
        } else if guage > 60 {
            "긍정적"
        } else if guage > 40 {
            "중립"
        } else if guage > 20 {
            "부정적"
        } else {
            "매우 부정적"
        }
    }
    
    static func getDescription(of emotion: CommentEmotion) -> String {
        switch emotion {
        case CommentEmotion.joy: "기쁨"
        case CommentEmotion.anger: "화남"
        case CommentEmotion.sadness: "슬픔"
        case CommentEmotion.suprise: "놀람"
        case CommentEmotion.fear: "공포"
        case CommentEmotion.disgust: "역겨움"
        }
    }
    
    static func getDescription(of category: CommentCategory) -> String {
        switch category {
        case CommentCategory.reaction: "반응"
        case CommentCategory.feedback: "피드백"
        case CommentCategory.question: "질문"
        case CommentCategory.spam: "스팸/광고"
        case CommentCategory.curse: "욕설/비방"
        }
    }
}
