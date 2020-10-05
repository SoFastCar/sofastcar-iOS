//
//  ReservationData.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct Reservation: Decodable {
  let reservationUid: Int
  let car: Int
  let zone: Int
  let insurance: String
  let startTime: String
  let endTime: String
  let creatTime: String
  let updateTime: String
  let member: Int
  
  enum CodingKeys: String, CodingKey {
    case reservationUid = "id"
    case car
    case zone
    case insurance
    case startTime = "date_time_start"
    case endTime = "date_time_end"
    case creatTime = "created_at"
    case updateTime = "updated_at"
    case member
  }
}

/*
 [
 "car": 17, -
 "insurance": light, -
 "date_time_start": 2020-10-07T01:40:00Z, -
 "id": 23,
 "updated_at": 2020-10-05T13:22:30.530651Z, -
 "created_at": 2020-10-05T13:22:30.530639Z, -
 "member": 10, -
 "date_time_end": 2020-10-07T05:40:00Z, -
 "zone": 246 -
 ]
 */
