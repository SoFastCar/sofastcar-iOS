//
//  Time.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class Time {
  // 참고 URL: https://ownstory.tistory.com/21
  enum PresnetDateString: String {
    case castMddEHHmm = "M/dd (E) HH:mm"
    case castMddEHH = "M/dd (E) HH"
    case castMMddE = "MM / dd (E)"
    case todayE = "오늘 (E)"
    case todayH = "오늘 H"
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
}
