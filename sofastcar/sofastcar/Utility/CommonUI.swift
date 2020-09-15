//
//  CommonUI.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import UIKit

class CommonUI {
  
  static let mainBlue: UIColor = .init(red: 0.08, green: 0.7, blue: 1, alpha: 1)
  static let mainDark: UIColor = .init(red: 0.22, green: 0.28, blue: 0.33, alpha: 1)
  static let reservationBackground: UIColor = UIColor(
    red: 30 / 255,
    green: 37 / 255,
    blue: 46 / 255,
    alpha: 1
  )
  static let grayColor: UIColor = UIColor(
    red: 242 / 255,
    green: 242 / 255,
    blue: 242 / 255,
    alpha: 1
  )
  
  // Login VC
  static let userInputMenusHeight: CGFloat = 50 // 텍스트 필드 높이
  static let sectionLabelHeight: CGFloat = 25   // 입력 메뉴 라벨 높이
  static let sectionLabelPadding: CGFloat = 30  // 각 입력 섹션 메뉴당 차이
  static let sectionMiddlePadding: CGFloat = 3
  
  // Reservation
  static let titleTextFontSize: CGFloat = 17
  static let contentsTextFontSize: CGFloat = 15
  static let contentsTextViewFontSize: CGFloat = 13
  
  enum SFSymbolKey: String {
    case hamburger = "line.horizontal.3"
    case rightChevron = "chevron.right"
    case warning = "exclamationmark.triangle.fill"
    case bolt = "bolt.fill"
    case lock = "lock"
    case unlock = "lock.open"
    case horn = "speaker.1"
    case `return` = "goforward"
    case close = "xmark"
    case questionMark = "questionmark.circle"
  }
  
  static let locale = NSLocale(localeIdentifier: "ko_KO")
}
