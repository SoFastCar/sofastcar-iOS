//
//  AppDelegate.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    var rootView: UIViewController = UIViewController()
//    UserDefaults.resetUserAuthTocken() // 로그아웃필요할때 사용
//    UserDefaults.setReadyToDrive(isDriveReady: false)
    if UserDefaults.getUserAuthTocken() != nil {
      if UserDefaults.getReadyToDrive() == true {
        let reservationDashBoard = ReservationDashboardVC()
        rootView = reservationDashBoard
      } else {
        changeUserAuthTocken()
        let mainVC = MainVC()
        mainVC.socarZoneProvider = SocarZoneProvider()
        rootView = mainVC
      }
    } else {
      rootView = InitVC()
    }
    
    let navigationController = UINavigationController(rootViewController: rootView)
    let backButtonImage = UIImage(systemName: "arrow.left")
    navigationController.navigationBar.backIndicatorImage = backButtonImage
    navigationController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigationController.navigationBar.topItem?.title = ""
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    window?.overrideUserInterfaceStyle = .light // add woobin: dark mode off
    return true
  }
  
  func changeUserAuthTocken() {
    DispatchQueue.global().sync {
      let urlString = "https://sofastcar.moorekwon.xyz/api-jwt-auth/refresh/"
      let url = URL(string: urlString)!
      guard let currnetUserAuthToken = UserDefaults.getUserAuthTocken() else { return }
      
      let sendData = [ "token": "\(currnetUserAuthToken)"]
      guard let jsonSendData = try? JSONSerialization.data(withJSONObject: sendData) else { return }
      
      var request = URLRequest(url: url)
      request.httpMethod = "POST"
      request.addValue("\(currnetUserAuthToken)", forHTTPHeaderField: "Authorization")
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      request.httpBody = jsonSendData
      
      let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        if let error = error {
          print("Error", error.localizedDescription)
          return
        }
        guard let header = response as? HTTPURLResponse,
          (200..<300) ~= header.statusCode else { print("Create User Auth token Error"); return }
        print("Response Code: \(header.statusCode)")
        
        guard let responseData = data else { return }
        
        if let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: String] {
          if let newUserAuthToken = jsonData["token"] {
            UserDefaults.saveUserAuthTocken(authToken: newUserAuthToken)
            print(newUserAuthToken)
          }
        }
      }
      task.resume()
    }
  }
}
