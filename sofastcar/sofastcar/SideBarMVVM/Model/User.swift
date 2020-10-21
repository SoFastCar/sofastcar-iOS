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
}

extension UserData {
  
  static var empty: UserData = {
    return UserData(results: [User(userUid: 0, name: "로딩중..", email: "로딩중..", creditPoint: 0, phoneNumber: "로딩중..", totalDrivinDistance: 0)])
  }()
  
  static var all: Resource<UserData> = {
    let url = URL(string: "https://sofastcar.moorekwon.xyz/members")!
    return Resource(url: url)
  }()
  
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
