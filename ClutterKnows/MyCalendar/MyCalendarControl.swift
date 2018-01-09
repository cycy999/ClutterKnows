//
//  MyCalendarControl.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/8.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class MyCalendarControl: NSObject {

    var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    
    var date = Date(timeIntervalSinceNow: 60 * 60 * 8) {
        didSet {
            currentMonth = calendar.dateComponents([.year, .month], from: date)
        }
    }
    
    var jumpMonth = 0 {
        didSet {
            var comps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            if jumpMonth == 0 {
                date = Date(timeIntervalSinceNow: 60 * 60 * 8)
            } else {
                if let month = comps.month {
                    comps.month = month + jumpMonth
                    date = calendar.date(from: comps)!
                }
            }
            refreshDate()
        }
    }
    
    //所展示的当前页面的月份信息
    var currentMonth: DateComponents!
    
    var todayDate: DateComponents!
        
    override init() {
        super.init()
        calendar.locale = Locale(identifier: "zh_CN")
        //calendar.timeZone = TimeZone(abbreviation: "EST")!
        calendar.timeZone = TimeZone(secondsFromGMT: 60 * 60 * 8)!
        currentMonth = calendar.dateComponents([.year, .month], from: date)
        todayDate = calendar.dateComponents([.year, .month, .day], from: date)
    }
    
    var calendarModels = [DateComponents]()
    
    func refreshDate() {
        var models = [DateComponents]()
        let firstIndex = dayWeekOfMonth(date: firstDayDateOfMonth())
        for index in 1 ..< firstIndex + 1 {
            let date = dateOfMonthSelectDay(selectedDay: -firstIndex + index)
            let comps = calendar.dateComponents([.year, .month, .day], from: date!)
            models.append(comps)
        }
        for index in 1 ..< daysOfMonth(date: date) + 1 {
            let date = dateOfMonthSelectDay(selectedDay: index)
            let comps = calendar.dateComponents([.year, .month, .day], from: date!)
            models.append(comps)
        }
        let lastIndex = dayWeekOfMonth(date: lastDayOfMonth(date: date)!)
        for index in 0 ..< 6 - lastIndex {
            let date = dateOfMonthSelectDay(selectedDay: daysOfMonth(date: self.date) + index + 1)
            let comps = calendar.dateComponents([.year, .month, .day], from: date!)
            models.append(comps)
        }
        calendarModels = models
    }
  
    
}

extension MyCalendarControl {
    
    //今天日期在日历UI中的下标
    func dateInCalendarToday() -> Int? {
        if let date_firstday = firstDayOfMonth(date: date) {
            let components = calendar.dateComponents([.era, .year, .minute, .day], from: date)
            let firstDayWeek = dayWeekOfMonth(date: date_firstday)
            return components.day! - 1 + firstDayWeek
        }
        return nil
    }
    
    //获取当月的第一天date
    func firstDayDateOfMonth() -> Date {
        if let date = firstDayOfMonth(date: date) {
            return date
        }
        return Date()
    }
    
    
    //获取对应日期是星期几
    func dayWeekOfMonth(date: Date) -> Int {
        var comps = calendar.dateComponents([.year, .month, .weekday], from: date)
        if let weekday = comps.weekday {
            return weekday - 1
        }
        return 0
    }
    
    
    //某个月最后一天日期date
    func lastDayOfMonth(date: Date) -> Date? {
        var comps = calendar.dateComponents([.year, .month, .weekday], from: date)
        if let count = calendar.range(of: .day, in: .month, for: date)?.count {
            comps.day = count
            return calendar.date(from: comps)
        }
        return nil
    }
    
    
    //以当前为标准，之后某个月的1号date
    func firstDayOfMonth(date: Date, months: Int = 0) -> Date? {
        var comps = calendar.dateComponents([.era, .year, .month], from: date)
        comps.day = 1
        if months != 0 {
            if let month = comps.month {
                comps.month = month + months
            }
        }
        return calendar.date(from: comps)
    }
    
    //某个月一共多少天
    func daysOfMonth(date: Date) -> Int {
        if let days = calendar.range(of: .day, in: .month, for: date)?.count {
            return days
        }
        return 0
    }
    
    func dateOfMonthSelectDay(selectedDay: Int) -> Date? {
        var comps: DateComponents = calendar.dateComponents([.era, .year, .month, .day], from: date)
        comps.day = selectedDay
        let dateinfo = calendar.date(from: comps)
        return dateinfo
    }
}
