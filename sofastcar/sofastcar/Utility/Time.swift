//
//  Time.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class Time {
  static let min = 60
  static let hour = min * 60
  static let day = hour * 24
  
  // 참고 URL: https://ownstory.tistory.com/21
  enum PresnetDateString: String {
    case castYYYYMMDDHHmm = "YYYYMMddHHmm"
    case castMddEHHmm = "M/dd (E) HH:mm"
    case castMddEHH = "M/dd (E) HH"
    case castMMddE = "MM / dd (E)"
    case castMMd = "MM/d"
    case todayE = "오늘 (E)"
    case todayH = "오늘 H"
    case todayHHmm = "오늘 HH:mm"
    case tommorowHHmm = "내일 HH:mm"
    case hourHHmm = "HH:mm"
    case tomorrow = "내일 (E)"
    case hourH = "H"
    case hourHH = "HH"
    case dayd = "d"
    case minMM = "mm"
  }
  
  static func getTimeString(type: PresnetDateString, date: Date) -> String {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = type.rawValue
    return format.string(from: date)
  }
  
  static func getDiffTwoDateValueReturnString(start: Date, end: Date) -> String {
    let calendar = Calendar.current
    var returnText = "총 "
    let offsetComps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: start, to: end)
    if let day = offsetComps.day,
      day != 0 {
      returnText.append("\(day)일 ")
    }
    if let hour = offsetComps.hour,
      hour != 0 {
      returnText.append("\(hour)시간 ")
    }
    if let minute = offsetComps.minute,
      minute != 0 {
      returnText.append("\(minute)분 ")
    }
    returnText.append("이용")
    return returnText
  }
  
  static func getDayIndex(start: Date, end: Date) -> Int {
    let calendar = Calendar.current
    let offsetComps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: start, to: end)
    guard let dayIndex = offsetComps.day else { return 0 }
    return dayIndex
  }
  
  static func getStartEndTimeShowLabel(start: Date, end: Date) -> String {
    var returnString = ""
    let todayString = Time.getTimeString(type: .dayd, date: Date())
    let tommorowString = Time.getTimeString(type: .dayd, date: Date().addingTimeInterval(TimeInterval(day)))
    // start Time
    if todayString == Time.getTimeString(type: .dayd, date: start) {
      returnString.append("\(Time.getTimeString(type: .todayHHmm, date: start))")
    } else if tommorowString == Time.getTimeString(type: .dayd, date: start) {
      returnString.append("\(Time.getTimeString(type: .tommorowHHmm, date: start))")
    } else {
      returnString.append("\(Time.getTimeString(type: .castMddEHHmm, date: start))")
    }
    returnString.append(" - ")
    //end Time
    if todayString == Time.getTimeString(type: .dayd, date: end) {
      returnString.append("\(Time.getTimeString(type: .hourHHmm, date: end))")
    } else if tommorowString == Time.getTimeString(type: .dayd, date: end) {
      returnString.append("\(Time.getTimeString(type: .tommorowHHmm, date: end))")
    } else {
      returnString.append("\(Time.getTimeString(type: .castMddEHHmm, date: end))")
    }
    return returnString
  }
    
    static func getStartEndTimeShowLabelShort(start: Date) -> String {
      var returnString = ""
      let todayString = Time.getTimeString(type: .dayd, date: Date())
      let tommorowString = Time.getTimeString(type: .dayd, date: Date().addingTimeInterval(TimeInterval(day)))
      // start Time
      if todayString == Time.getTimeString(type: .dayd, date: start) {
        returnString.append("\(Time.getTimeString(type: .todayHHmm, date: start))")
      } else if tommorowString == Time.getTimeString(type: .dayd, date: start) {
        returnString.append("\(Time.getTimeString(type: .tommorowHHmm, date: start))")
      } else {
        returnString.append("\(Time.getTimeString(type: .castMddEHHmm, date: start))")
      }
      return returnString
    }
  
  static func getDivideRentTodalTimeByHalfHour(start: Date, end: Date) -> Int {
    return Int((end.timeIntervalSince1970 - start.timeIntervalSince1970))/Time.hour*2
  }
  
  static func getInitialStartAndEndTimeForReservation(complete: (_ startTime: Date, _ endTime: Date) -> Void) {
    let date = floor(Date().timeIntervalSince1970)
    let restMinDate = Double(Int(date) % 600)
    var startTime = Date(timeIntervalSince1970: date-restMinDate)
    startTime.addTimeInterval(TimeInterval(20*Time.min))
    let endTime = startTime.addingTimeInterval(TimeInterval(Time.hour*4))
    complete(startTime, endTime)
  }
  /*
   "date_time_start": "2020-10-05T05:23:06Z",
   "date_time_end": "2020-10-05T05:23:06Z"
   */
  static func toStringUTC(changeForDate date: Date) -> String {
    var resultString = ""
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = "yyyy-MM-dd"
    resultString.append(dateFormatter.string(from: date))
    resultString.append("T")
    dateFormatter.dateFormat = "hh:mm:ss"
    resultString.append(dateFormatter.string(from: date))
    resultString.append("+00:00")
    return resultString
  }
    
    static func toUTCString(changeForString string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = CommonUI.locale as Locale // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let tempDate = dateFormatter.date(from: string)!
        return tempDate
    }
}
