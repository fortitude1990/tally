//
//  CalendarHelper.swift
//  tally
//
//  Created by 李志敬 on 2019/3/18.
//  Copyright © 2019 李志敬. All rights reserved.
//

import UIKit

class CalendarHelper: NSObject {



    
  static func days(month: String) -> Int{

       let oneState = ["2", "02"]
       let twoState = ["1","01", "3","03", "5","05", "7","07", "8", "08", "10", "12"]
//        let threeState = ["4", "04", "6", "06", "9", "09", "11"]
        
        if oneState.contains(month){
            return 28
        }
        
        if twoState.contains(month) {
            return 31
        }
        
        return 30
    }
    
    static func days(date: Date) -> Int {
        
        let format = DateFormatter.init()
        format.dateFormat = "MM"
        let month = format.string(from: date)
        return days(month: month)
        
    }
    
    static func month(date: String, dateFormat: String) -> String{
        let format = DateFormatter.init()
        format.dateFormat = dateFormat
        let d = format.date(from: date)
        format.dateFormat = "MM"
        return format.string(from: d ?? Date.init())
    }
    
    
    static func weekday(date: Date) -> String {
        
        let weekDays = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        
        var calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let timeZone = TimeZone.init(identifier: "Chinese")
        calendar.timeZone = timeZone!
        let components = calendar.component(Calendar.Component.weekday, from: date)
        return weekDays[components]
        
    }
    
    static func dateString(date: String, originFromat: String, resultFromat: String) -> String {
        
        let format = DateFormatter.init()
        format.dateFormat = originFromat
        let d = format.date(from: date)
        format.dateFormat = resultFromat
        return format.string(from: d ?? Date.init())
        
    }
    
    static func nowDateString(dateFormat: String) -> String{
        let format = DateFormatter.init()
        format.dateFormat = dateFormat
        return format.string(from: Date.init())
    }
    
    static func dateString(date: Date, dateFormat: String) -> String{
        let format = DateFormatter.init()
        format.dateFormat = dateFormat
        return format.string(from: date)
    }
    
    static func year(date: Date) -> String{
        return dateString(date: date, dateFormat: "yyyy")
    }
    
    static func month(date: Date) -> String{
        return dateString(date: date, dateFormat: "MM")
    }
    
    static func day(date: Date) -> String{
        return dateString(date: date, dateFormat: "dd")
    }
    
    static func date(dateString: String, dateFormat: String) -> Date{
        let format = DateFormatter.init()
        format.dateFormat = dateFormat
        return format.date(from: dateString) ?? Date.init()
    }
    
}
