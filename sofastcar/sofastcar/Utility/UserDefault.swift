//
//  UserDefault.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

extension UserDefaults {
  // MARK: - User Auth Token
  static func saveUserAuthTocken(authToken: String) {
    UserDefaults.standard.set(authToken, forKey: "UserAuthToken")
  }
  
  static func getUserAuthTocken() -> String? {
    guard let userAuthKey = UserDefaults.standard.value(forKey: "UserAuthToken") as? String else { return nil }
    return userAuthKey
  }
  
  static func resetUserAuthTocken() {
    UserDefaults.standard.set(nil, forKey: "UserAuthToken")
  }
  
  // MARK: - Reservation Finish Check & ReservationDashBoard
  static func setReadyToDrive(isDriveReady: Bool) {
    UserDefaults.standard.set(isDriveReady, forKey: "ReadyToDrive")
  }
  
  static func getReadyToDrive() -> Bool {
    guard let isReady = UserDefaults.standard.value(forKey: "ReadyToDrive") as? Bool else { return false }
    return isReady
  }
  
  // MARK: - Reservation Vehicle check
  static func setVehicleDoubleCheck(check: Bool) {
    UserDefaults.standard.set(check, forKey: "VehicleDoubleCheckVC")
  }
  
  static func getVehicleBoubleCheck() -> Bool {
    let check = UserDefaults.standard.bool(forKey: "VehicleDoubleCheckVC")
    return check
  }
  
  static func setVehiclCheck(check: Bool) {
    UserDefaults.standard.set(check, forKey: "VehicleCheckVC")
  }
  
  static func getVehicleCheck() -> Bool {
    let check = UserDefaults.standard.bool(forKey: "VehicleCheckVC")
    return check
  }
  
  // MARK: - Logout Button
  static func deleteUserSettingForLogout() {
    resetUserAuthTocken()
    setReadyToDrive(isDriveReady: false)
    setVehicleDoubleCheck(check: false)
    setVehiclCheck(check: false)
  }
}
