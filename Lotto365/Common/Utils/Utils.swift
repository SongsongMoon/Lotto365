//
//  Utils.swift
//  Lotto365
//
//  Created by Song on 19/05/2020.
//  Copyright © 2020 FACTORY X. All rights reserved.
//

import UIKit
import Foundation

class Utils {
    //MARK: -Font
    static func Font(_ style: FontStyle, size: CGFloat) -> UIFont? {
        return UIFont(name: style.rawValue, size: size)
    }
    
    //MARK: - StatusBar
    static func StatusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    //MARK: - Number
    static func convertToCurrency(amount: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    
    //MARK: - Date
    static func toDate(date: String, format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.date(from: date)
    }
    
    static func CurrentDate() -> String? {
        return String(Date().millisecondsSince1970)
    }
    
    static func ChangeDateFormat(date: String, beforFormat: DateFormat, afterFormat: DateFormat) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = beforFormat.rawValue
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = afterFormat.rawValue
        
        //2014-05-22T03:46:25Z
        if let beforeDate = dateFormatterGet.date(from: date) {//2016-02-29 12:24:26
            return dateFormatterPrint.string(from: beforeDate)
        } else {
            return nil
        }
    }
    
    static func ChangeDateFormat(date: Date,
                                 afterFormat: DateFormat,
                                 locale: Locale = Locale(identifier: "ko")) -> String?
    {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = afterFormat.rawValue
        dateFormatterPrint.locale = locale
        
        return dateFormatterPrint.string(from: date)
    }
    
    static func ChangeDateFormat(seconds: String) -> Date? {
        if let unixTime = Double(seconds) {
//            Date(millis: <#T##Int64#>)
            return Date(timeIntervalSince1970: unixTime)
        }
        return nil
    }
    
    static func ChangeDateFormat(millis: String) -> Date? {
        if let unixTime = Double(millis) {
            return Date(millis: unixTime)
        }
        return nil
    }
    
    static func ChangeDateFormat(seconds: String,
                                 afterFormat: DateFormat) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(seconds) {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
//            let timezone = TimeZone.current.abbreviation() ?? "CET"  // get current TimeZone abbreviation or set to CET
//            dateFormatter.timeZone = TimeZone(abbreviation: timezone) //Set timezone that you want
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = afterFormat.rawValue
            strDate = dateFormatter.string(from: date)
        }
        
        return strDate
    }
    
    static func ChangeDateFormat(millis: String,
                                 afterFormat: DateFormat) -> String {
        var strDate = "undefined"
        
        if let unixTime = Double(millis) {
//            let date = Date(timeIntervalSince1970: unixTime)
            print(unixTime)
            
            let date = Date(millis: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = afterFormat.rawValue
            strDate = dateFormatter.string(from: date)
        }
        
        return strDate
    }
    
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (String, String, String) {
    
        let hour = String(format: "%02d", seconds / 3600)
        let minute = String(format: "%02d", (seconds % 3600) / 60)
        let second = String(format: "%02d", (seconds % 3600) % 60)
        
        return (hour, minute, second)
    }
    
    static func GetDateFromString(_ date: String, format: DateFormat) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: date)
    }
    
    static func GetStringFromDate(_ date: Date, format: DateFormat) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    static func GetTimeInterval(date: String, format: DateFormat) -> TimeInterval? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: date)?.timeIntervalSince1970
    }
    
    static func GetCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.yyyyMMddHHmmss.rawValue
        
        return formatter.string(from: Date())
    }
}

extension Utils {
    enum FontStyle: String {
        case bold = "AppleSDGothicNeo-Bold"
        case semiBold = "AppleSDGothicNeo-SemiBold"
        case medium = "AppleSDGothicNeo-Medium"
        case regular = "AppleSDGothicNeo-Regular"
    }
}

extension Utils {
    /*
     Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
     09/12/2018                        --> MM/dd/yyyy
     09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
     Sep 12, 2:11 PM                   --> MMM d, h:mm a
     September 2018                    --> MMMM yyyy
     Sep 02, 2018                      --> MMM dd, yyyy
     Sep 2, 2018                       --> MMM d, yyyy
     Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
     2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
     12.09.18                          --> dd.MM.yy
     10:41:02.112                      --> HH:mm:ss.SSS
     Sep 02, 14:11                     --> MMM dd,HH:mm
     */
    enum DateFormat: String {
        ///2018-09-12 14:11:54
        case BASIC = "yyyy-MM-dd HH:mm:ss"
        ///2018-09-12T14:11:54+0000
        case BASIC_TZ = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
        ///Sep 02, 2018
        case MMMddyyyy = "MMM dd, yyyy"
        ///Sep 02, 14:11
        case MMMddHHmm = "MMM dd, HH:mm"
        ///2019. 06. 13 13:05:10
        case yyyyMMddHHmmss = "yyyy. MM. dd HH:mm:ss"
        ///2019. 02. 01
        case yyyyMMdd = "yyyy. MM. dd"
        ///10.08
        case MMdd = "MM.dd"
        //13:11:14
        case HHmmss = "HH:mm:ss"
        //오전1:30
        case ahmm = "a h:mm"
    }
    
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(millis: Double) {
        
        self = Date(timeIntervalSince1970: (millis / 1000.0))
    }
    
    var secondsSince1970: Int64 {
        return Int64((self.timeIntervalSince1970).rounded())
    }
}
