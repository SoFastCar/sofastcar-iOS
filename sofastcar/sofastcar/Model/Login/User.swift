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
  var name: String
  let email: String
  let creditPoint: Int
  var phoneNumber: String
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
