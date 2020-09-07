//
//  User.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class SignUpUserData: CustomStringConvertible {
  
  // 사용자 인적 정보
  var useranme: String = ""
  var userBirthDay: String = ""
//  var userGender: Int = 0
//  var userContury: String = ""
//  var mobileCompany: String = "" // skt, kt, LGU+
  var userPhoneNumber: Int = 0
  
  // 마케팅 정보 동의 여부
//  var marketingAgreeTime: Date = Date()
//  var smsMarketing: Bool = false
//  var pushMarketing: Bool = false
//  var emailMarketing: Bool = false
  
  var description: String { // 일반 print 출력 문자열
    "\(useranme), \(userBirthDay), \(userPhoneNumber)"
  }
  //\(marketingAgreeTime), \(smsMarketing), \(pushMarketing), \(emailMarketing)
}
