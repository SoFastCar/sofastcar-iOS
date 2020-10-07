//
//  ReservationNetWorkService.swift
//  sofastcar
//
//  Created by 요한 on 2020/10/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import Alamofire

class ReservationNetWorkService {
  
  static let shared = ReservationNetWorkService()

  let reservationBaseUrl = "https://sofastcar.moorekwon.xyz/reservations"
  let reservationUidUrl = UserDefaults.getReservationUid()
  var urlGetOneCall = ""
  
  let session = URLSession(configuration: .default)
  
  func buildURL() -> String {
//    urlGetOneCall = "/" + "\(String(describing: reservationUidUrl))"
      urlGetOneCall = "/" + "\(String(describing: reservationUidUrl))"
      return reservationBaseUrl + urlGetOneCall
  }

  func getReservationInfo(onSuccess: @escaping (Reservation) -> Void, onError: @escaping (String) -> Void) {
    
    guard let url = URL(string: buildURL()) else {
        onError("Error building URL")
        return
    }
    
    AF.request(url, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"]).validate(statusCode: 200..<300).responseDecodable(of: Reservation.self) { (response) in
      switch response.result {
      case .success(let value):
          onSuccess(value)
          print("value: \(value)")
      case .failure(let error):
          print("error: \(String(describing: error.errorDescription))")
      }
    }
  }
}
