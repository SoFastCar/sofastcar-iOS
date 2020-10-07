//
//  ReservationData.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct UserReservation: Decodable {
  let results: [Reservation]
  let previous: String?
  let next: String
}

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
