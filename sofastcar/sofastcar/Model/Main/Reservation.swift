//
//  ReservationData.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct Reservation: Decodable {
  var reservationUid: Int
  var car: Int
  var zone: Int
  var insurance: String
  var startTime: String
  var endTime: String
  var creatTime: String
  var updateTime: String
  
  enum CodingKeys: String, CodingKey {
    case reservationUid = "id"
    case car
    case zone
    case insurance
    case startTime = "date_time_start"
    case endTime = "date_time_end"
    case creatTime = "created_at"
    case updateTime = "updated_at"
  }
}
