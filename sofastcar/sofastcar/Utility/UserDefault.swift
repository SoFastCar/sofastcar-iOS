//
//  UserDefault.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

extension UserDefaults {
  static func saveUserAuthTocken(authToken: String) {
    UserDefaults.standard.set(authToken, forKey: "UserAuthToken")
  }
  
  static func getUserAuthTocken() -> String? {
    guard let userAuthKey = UserDefaults.standard.value(forKey: "UserAuthToken") as? String else { return nil }
    return userAuthKey
  }
}
