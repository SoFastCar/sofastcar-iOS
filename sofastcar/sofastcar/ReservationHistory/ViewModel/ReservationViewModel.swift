//
//  RentalHistoryViewModel.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct ReservationListViewModel {
  
  let reservationList: [ReservationViewModel]
  
}

extension ReservationListViewModel {
  
  init(_ reservations: [Reservation]) {
    self.reservationList = reservations.sorted { (reservation1, reservation2) -> Bool in
      reservation1.startTime > reservation2.startTime
    }.compactMap(ReservationViewModel.init)
  }
  
}

extension ReservationListViewModel {
  
  func reservationAt(_ index: Int) -> ReservationViewModel {
    return self.reservationList[index]
  }
  
}

struct ReservationViewModel {
  
  let reservation: Reservation
  
  init(_ reservation: Reservation) {
    self.reservation = reservation
  }
  
}

extension ReservationViewModel {
  
  var car: Observable<Int> {
    return Observable<Int>.just(self.reservation.car)
  }
  
  var zone: Observable<Int> {
    return Observable<Int>.just(self.reservation.zone)
  }
  
  var usingTime: Observable<String> {
    let startTime = Time.toUTCString(changeForString: self.reservation.startTime)
    let endTime = Time.toUTCString(changeForString: self.reservation.endTime)
    let printedString = "\(Time.getTimeString(type: .castMddEHHmm, date: startTime)) - \(Time.getTimeString(type: .castMddEHHmm, date: endTime))"
    return Observable<String>.just(printedString)
  }
  
  var timeGap: Observable<String> {
    let startTime = Time.toUTCString(changeForString: self.reservation.startTime)
    let endTime = Time.toUTCString(changeForString: self.reservation.endTime)
    let timeGapString = Time.getDiffTwoDateValueReturnString(start: startTime, end: endTime)
    return Observable<String>.just(timeGapString)
  }
  
}

/*
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
 */
