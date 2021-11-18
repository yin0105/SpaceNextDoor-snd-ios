//
//  Ext+Date.swift
//  WeFresh-iOS
//
//  Created by JH Lee on 2020/4/6.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import UIKit

extension Date {
    
    static func compareTimeOfSize(startD: String, endD: String, formatStr: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") -> Bool {
        //字符串转Date
//        let formatter = DateFormatter()
//        formatter.dateFormat = formatStr
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        formatter.locale = Language.current.locale
        formatter.calendar = Calendar(identifier: .gregorian)
        
        let startDate = formatter.date(from: startD)
        let endDate = formatter.date(from: endD)
        
        //当前时间
        let nowDate = Date()
        let calendar: Calendar = Calendar.current

        //开始时间不能小于当前时间
        let commponentTemp: DateComponents = calendar.dateComponents([.day,.hour, .minute], from: startDate ?? Date(), to: nowDate)
        guard commponentTemp.day! > 0 || commponentTemp.hour! > 0 || commponentTemp.minute! > 0 else {
            return false
        }
        
        //判断结束时间是否为空
        let commponent:DateComponents = calendar.dateComponents([.day,.hour, .minute], from: nowDate , to: endDate ?? Date())
        guard commponent.day! > 0 || commponent.hour! > 0 || commponent.minute! > 0 else{
            return false
        }
        return true
    }
    
    
    static func transferDateToTimeInterval(date:String, formatStr: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")-> Int {
        //字符串转Date
        let formatter = DateFormatter()
        formatter.dateFormat = formatStr
        
        return Int(formatter.date(from: date)?.timeIntervalSince1970 ?? 0)
    }
    
    
    static func transferDateStringToDateString(from:String, fromformat: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ", toFormat: String = "HH:mm")-> String {

        let time = Date(timeIntervalSince1970: TimeInterval(self.transferDateToTimeInterval(date: from, formatStr: fromformat) - 25200))
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = toFormat
        return dfmatter.string(from: time)
    }
}


// Out Of Alcohol Service Time
extension Date{
    
    static func jundgeIsAlcoholServiceTime(date: String) ->Bool {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH"
        
        var currentHour = formatter.string(from: Date()).substring(with: NSRange(location: 11, length: 2))
        if !date.contains("Delivery Now") {
            currentHour = date.substring(with: NSRange(location: 0, length: 2))
        }
                       
        for time in 0...10 {
            if Int(currentHour) == time {
                return false
            }
        }
        
        for time in 14...16 {
            if Int(currentHour) == time {
                return false
            }
        }
      
        return true
    }
}
