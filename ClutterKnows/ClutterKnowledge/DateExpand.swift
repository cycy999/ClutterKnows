//
//  DateExpand.swift
//  ClutterKnows
//
//  Created by 陈岩 on 2018/1/3.
//  Copyright © 2018年 陈岩. All rights reserved.
//

import UIKit

class DateExpand: NSObject {

    let calendar = Calendar.current
    
    func test() {
        let currentDate = Date()
        print(currentDate)//格林威治时间
        print(stringFromDate(date: currentDate))
        compareDate()
        calculate()
        valueCalculate()
        getTimes()
        getNumOfDaysInMonth()
        getAllDaysWithCalendar()
    }
    
    func dateFromString(str: String) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale.current //设置时区
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        return dateformatter.date(from: str)
    }
    
    
    func stringFromDate(date: Date) -> String {
        
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale.current //设置时区
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateformatter.string(from: date)
    }
    
    /*
     系统自带样式输出日期
     none:
     full:Wednesday, January 3, 2018
     long:January 3, 2018
     medium:Jan 3, 2018
     short:1/3/18
     2018-01-03
     */
    func stylePrintDate() {
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        print("none:" + dateformatter.string(from: date))
        dateformatter.dateStyle = .full
        print("full:" + dateformatter.string(from: date))
        dateformatter.dateStyle = .long
        print("long:" + dateformatter.string(from: date))
        dateformatter.dateStyle = .medium
        print("medium:" + dateformatter.string(from: date))
        dateformatter.dateStyle = .short
        print("short:" + dateformatter.string(from: date))
        dateformatter.dateFormat = "yyyy-MM-dd"
        print(dateformatter.string(from: date))
    }
    
    /*
     自定义说明符输出日期
     EEEE: 代表一天的全名,比如Monday.使用1-3个E就代表简写,比如Mon.
     
     MMMM: 代表一个月的全名,比如July.使用1-3个M就代表简写,比如Jul.
     
     dd: 代表一个月里的几号,比如07或者30.
     
     yyyy: 代表4个数字表示的年份,比如2016.
     
     HH: 代表2个数字表示的小时,比如08或17.
     
     mm: 代表2个数字表示的分钟,比如01或59.
     
     ss: 代表2个数字表示的秒,比如2016.
     
     zzz: 代表3个字母表示的时区,比如GTM(格林尼治标准时间,GMT+8为北京所在的时区,俗称东八区)
     
     GGG: BC或者AD, 即公元前或者公元
     
     系统自带的样式不够用时, 就可以使用自定义说明符自定义Date的输出格式.
     
     自定义说明符的另一个巨大的作用就是可以将复杂的字符类型的日期格式(比如Fri, 08 Aug 2016 09:22:33 GMT)转换成Date类型.
     
     自定义格式的使用最重要的就是自定义说明符的使用,说明符是一些对日期对象有特点含义的简单的字符.下面首先列举一些这里会用到的说明符:
     
     dateFormatter.dateFormat = "EEEE, MMMM, dd, yyyy"
     stringDate = dateFormatter.string(from: currentDate)
     print(stringDate) // Friday, August, 19, 2016
     
     dateFormatter.dateFormat = "HH:mm:ss E M dd zzz GGG"
     stringDate = dateFormatter.string(from: currentDate)
     print(stringDate) // 14:20:31 Fri 8 19 GMT+8 AD
     */
    
    func selectDayWith(day: Int) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        var beforeDate = DateComponents()
        beforeDate.day = day
        if let selectDay = Calendar.current.date(byAdding: beforeDate, to: Date(), wrappingComponents: true) {
            let dayString = dateformatter.string(from: selectDay)
            return dayString
        }
        return ""
    }
    
    //MARK: - 获取时间的年月日时分秒星期
    func getTimes() {
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        var comps = DateComponents()
        comps = calender.dateComponents([.year, .month, .day, .weekday, .hour, .minute], from: Date())
        print(comps.year, comps.month, comps.day, comps.hour, comps.minute, comps.weekday! - 1)
    }
    
    //MARK: - 当月有多少天
    func getNumOfDaysInMonth() -> Int{
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let date = Date()
        let range = calendar.range(of: Calendar.Component.day, in: Calendar.Component.month, for: date)
        print(range as Any)
        if let leng = range {
            print(leng.count)
            return leng.count
        }
        return 0
        //Optional(Range(1..<32))
        //31
    }
    
    func getAllDaysWithCalendar() {
        let dayCount = getNumOfDaysInMonth()
        let formatter = DateFormatter()
        let date = Date()
        formatter.locale = Locale.current
        formatter.dateFormat = "yyyy-MM"
        let str = formatter.string(from: date)
        formatter.dateFormat = "yyyy-MM-dd HH"
        var allDaysArray = [Date]()
        for i in 1 ..< dayCount + 1 {
            let sr = str + "-\(i)" + " 09"
            if let date = formatter.date(from: sr) {
                allDaysArray.append(date)
                
                print(date)
            }
        }
    }
    
    //MARK: - 日期比较
    func compareDate() {
        let dateFormmater = DateFormatter()
        dateFormmater.dateFormat = "MMM dd, yyyy zzz"
        
        let date1 = dateFormmater.date(from: "May 08, 2016 GMT")
        
        let date2 = dateFormmater.date(from: "May 10, 2016 GMT")
        
        print("date1:",date1 as Any)
        print("date2:",date2 as Any)

        //first Method
        print((date1! as NSDate).earlierDate(date2!)) //返回日期更早的对象
        print((date1! as NSDate).laterDate(date2!)) //返回日期晚的对象
        
        //second Method
        if date1?.compare(date2!) == ComparisonResult.orderedAscending {
            print("date1 is earlier")
        } else if date1?.compare(date2!) == .orderedDescending {
            print("date2 is earlier")
        } else if date1?.compare(date2!) == .orderedSame {
            print("same date")
        }
        
        //third Method：原理是分别将date1 和 date2 与一个参考日期进行比对, 然后通过判断两个日期和参考日期的差距
        if date1!.timeIntervalSinceReferenceDate > date2!.timeIntervalSinceReferenceDate {
            print("date1 is later")
        } else if date1!.timeIntervalSinceReferenceDate < date2!.timeIntervalSinceReferenceDate {
            print("date2 is later")
        } else {
            print("same date")
        }
        /*
         date1: Optional(2016-05-08 00:00:00 +0000)
         date2: Optional(2016-05-10 00:00:00 +0000)
         2016-05-08 00:00:00 +0000
         2016-05-10 00:00:00 +0000
         date1 is earlier
         date2 is later
         */
    }
    
    //MARK: - 日期计算
    func calculate() {
        
        let current = Date()
        print(current)
        
        var newDateComponents = DateComponents()
        newDateComponents.month = 2
        newDateComponents.day = 15
        newDateComponents.hour = 5
        
        let calendarDate = calendar.date(byAdding: newDateComponents, to: current, wrappingComponents: true)
        print(calendarDate as Any)
        /*
         2018-01-03 07:10:54 +0000
         Optional(2018-03-18 12:10:54 +0000)
         */
    }
    
    //MARK: 日期计算的时间差
    func valueCalculate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from: "2016-08-08 18:25:17")
        let date2 = dateFormatter.date(from: "1985-02-05 07:45:38")
        
        //First Method
        let diffComponents = (calendar as NSCalendar).components([NSCalendar.Unit.year, .month, .day], from: date2!, to: date1!, options: NSCalendar.Options.init(rawValue: 0))
        print("date1 and date2 is different: \(String(describing: diffComponents.year))year, \(String(describing: diffComponents.month))month,\(String(describing: diffComponents.day))day")
        //date1 and date2 is different: Optional(31)year, Optional(6)month,Optional(3)day
        
        //Second Method
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        
        let interval = date2?.timeIntervalSince(date1!)
        let diffString = dateComponentsFormatter.string(from: interval!)
        //print(interval as Any)//-994243179.0)
        print(diffString as Any)
        //Optional("-31 years, 6 months, 10 hours, 39 minutes, 39 seconds")
        
        //third Method
        //dateComponentsFormatter.allowedUnits = [Calendar.Unit.year]
        //diffString = dateComponentsFormatter.string(from: date1!, to: date2!)
        //print(diffString) // Optional("-31 years")
        //最后一个方法调用了stringFrom:to:方法来计算. 注意使用该方法之前, 必须至少在allowedUnits属性中设置一个calendar unit, 否则这个方法将会返回nil, 所以在使用该方法之前, 先指定想要怎么样看到输出, 然后再让执行输出的方法。
    }
}
