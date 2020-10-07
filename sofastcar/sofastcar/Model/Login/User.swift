//
//  User.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct UserData: Decodable {
  let results: [User]
  let previous: String?
  let next: String?
}

struct User: Decodable {
  let userUid: Int
  let name: String
  let email: String
  let creditPoint: Int
  let phoneNumber: String
  let totalDrivinDistance: Int
  
  enum CodingKeys: String, CodingKey {
    case userUid = "id"
    case name
    case email
    case creditPoint = "credit_point"
    case phoneNumber = "phone"
    case totalDrivinDistance = "total_driving_distance"
  }
}

class SignUpUserData: CustomStringConvertible {

  // 사용자 인적 정보
  var username: String!
  var userBirthDay: String!
//  var userGender: Int = 0
//  var userContury: String = ""
//  var mobileCompany: String = "" // skt, kt, LGU+
  var userPhoneNumber: String!
  var drivingAmount: Int!

  // 마케팅 정보 동의 여부
//  var marketingAgreeTime: Date = Date()
//  var smsMarketing: Bool = false
//  var pushMarketing: Bool = false
//  var emailMarketing: Bool = false

  var description: String { // 일반 print 출력 문자열
    "\(username), \(userBirthDay), \(userPhoneNumber)"
  }
  //\(marketingAgreeTime), \(smsMarketing), \(pushMarketing), \(emailMarketing)

  init(name: String, birthDay: String, phoneNumber: String, drivingAmount: Int) {
    self.username = name
    self.userBirthDay = birthDay
    self.userPhoneNumber = phoneNumber
    self.drivingAmount = drivingAmount
  }
}

