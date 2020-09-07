//
//  PhoneAuthResponse.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/06.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class PhoneAuthResponse: Decodable {
  var responseKey: Int
  var phoneNumber: String
  var registrationId: String
  
  enum CodingKeys: String, CodingKey {
    case responseKey = "id"
    case phoneNumber = "phone_number"
    case registrationId = "registration_id"
  }
}
