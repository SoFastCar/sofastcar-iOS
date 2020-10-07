//
//  ReservationDashboardVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/02.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class ReservationDashboardVC: UIViewController {
  
  var coreBluetoothIO: CoreBluetoothIO!
  
  let reservationStateView: ReservationStateView = {
    let scrollView = ReservationStateView()
    
    return scrollView
  }()
  
  let carKey: CarKeyView = {
    let view = CarKeyView()
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UserDefaults.setVehiclCheck(check: false)
    setUI()
    
    reservationNetWork()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    carKey.customDelegate = self
    view.backgroundColor = CommonUI.reservationBackground
    
    setNavigation()
    
    [reservationStateView, carKey].forEach {
      view.addSubview($0)
    }
    
    setGesture()
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    self.navigationItem.leftBarButtonItem = reservationStateView.leftNavigationButton
    self.navigationItem.rightBarButtonItem = reservationStateView.rightNavigationButton
    
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.backgroundColor = UIColor.clear
  }
  
  fileprivate func setGesture() {
    let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(didTapVehiclePictureView(recongnize:)))
    
    reservationStateView.vehiclePictureViewButton.addGestureRecognizer(tapGestureRecongnizer)
  }
  
  fileprivate func reservationNetWork() {
    ReservationNetWorkService.shared.getReservationInfo { (result) in
      
      let now = Date()
      let dateFormatter = DateFormatter()
      dateFormatter.locale = Locale(identifier: "ko-KR")
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      let startDate = dateFormatter.date(from: result.startTime)!
      
      let startConvertDateFormatter = DateFormatter()
      startConvertDateFormatter.locale = Locale(identifier: "ko-KR")
      startConvertDateFormatter.dateFormat = "M/dd (E) HH:mm"
      
      let startConvertDate = startConvertDateFormatter.string(from: Date(timeIntervalSince1970: startDate.timeIntervalSince1970))
      
      print(startDate.timeIntervalSince1970)
      print(now.timeIntervalSince1970)
      
      let useSocarTime = Int(startDate.timeIntervalSince1970 - now.timeIntervalSince1970) / 60
      
      let progressValue = 1 - (Double(useSocarTime) / (startDate.timeIntervalSince1970 / 60) * 100)
      
      self.reservationStateView.reservationRemainingTimeString = "쏘카 이용 \(useSocarTime)분 전 "
      self.reservationStateView.reservationTimeString = startConvertDate
      self.reservationStateView.reservationProgressValue = Float(progressValue)

      print("🚗", progressValue)
      print("🚙", result.creatTime)
      print("🚙", result.startTime)
      print("🚙", result.endTime)
      
      self.socarNetWork(result)
      
      self.socarzonNetWork(result)
      
    } onError: { (errorMessage) in
      debugPrint(errorMessage)
    }
  }
  
  fileprivate func socarNetWork(_ result: Reservation) {
    let socarUrl = "https://sofastcar.moorekwon.xyz/carzones/\(result.zone)/cars/\(result.car)/info"
    
    AF.request(socarUrl, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"]).validate(statusCode: 200..<300).responseDecodable(of: Socar.self) { (response) in
      switch response.result {
      case .success(let value):
        self.reservationStateView.reservationCarImageString = value.image
        self.reservationStateView.numberPlateString = value.number
        self.reservationStateView.carTypeString = value.name
        self.reservationStateView.carOilTypeString = value.fuelType
      case .failure(let error):
        print("error: \(String(describing: error.errorDescription))")
      }
    }
  }
  
  fileprivate func socarzonNetWork(_ result: Reservation) {
    let socarzonUrl = "https://sofastcar.moorekwon.xyz/carzones/\(result.zone)"
    
    AF.request(socarzonUrl, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"]).validate(statusCode: 200..<300).responseDecodable(of: SocarZoneData.self) { (response) in
      switch response.result {
      case .success(let value):
        self.reservationStateView.reservationPlaceStateSubString = value.name
        self.reservationStateView.returnPlaceStirng = value.name
      case .failure(let error):
        print("error: \(String(describing: error.errorDescription))")
      }
    }
  }
  
  // MARK: - Action
  
  @objc func didTapVehiclePictureView(recongnize: UITapGestureRecognizer) {
    switch recongnize.state {
    case .ended:
      let vehicleCheckVC = VehicleCheckVC()
      let navigationController = UINavigationController(rootViewController: vehicleCheckVC)
      navigationController.modalPresentationStyle = .overFullScreen
      self.present(navigationController, animated: false)
    default:
      break
    }
  }
  
  // MARK: - Network
  
}

// MARK: - CarKeyViewDelegate

extension ReservationDashboardVC: CarKeyViewDelegate {
  func buttonAction(_ sender: UIButton) {
    switch sender {
    case carKey.returnButton:
      print("return")
      //      UserDefaults.setReadyToDrive(isDriveReady: false)
      //      let provideVC = MainVC()
      //      provideVC.socarZoneProvider = SocarZoneProvider()
      //      let mainVC = UINavigationController(rootViewController: provideVC)
      //      mainVC.modalPresentationStyle = .overFullScreen
      
      let mainVC = ReturnVehicleStatusVC()
      mainVC.modalPresentationStyle = .overFullScreen
      self.present(mainVC, animated: false, completion: nil)
    case carKey.rightChevronButton:
      print("rightChevronButton")
      coreBluetoothIO = CoreBluetoothIO(serviceUUID: "0xFFE0", delegate: self)
    case carKey.lockButton:
      print("lockButton")
    case carKey.unlockButton:
      print("unlockButton")
    case carKey.emergencyButton:
      print("emergencyButton")
      coreBluetoothIO.writeValue(value: 1)
    case carKey.hornButton:
      print("hornButton")
      coreBluetoothIO.writeValue(value: 2)
    case carKey.riseLockButton:
      print("riseLockButton")
      coreBluetoothIO.writeValue(value: 3)
    case carKey.riseUnlockButton:
      print("riseUnlockButton")
      coreBluetoothIO.writeValue(value: 4)
    case carKey.riseReturnButton:
      print("riseReturnButton")
      UserDefaults.setReadyToDrive(isDriveReady: false)
      let mainVC = UINavigationController(rootViewController: ReturnVehicleVC())
      mainVC.modalPresentationStyle = .fullScreen
      self.present(mainVC, animated: false, completion: nil)
    default:
      break
    }
  }
}

extension ReservationDashboardVC: CoreBluetoothIODelegate {
  func coreBluetoothIO(coreBluetoothIO simpleBluetoothIO: CoreBluetoothIO, didReceiveValue value: Int8) {
    if value > 0 {
      // corebluetoothio의 상태값이 0보다 클경우
    } else {
      // corebluetoothio의 상태값이 0일경우
    }
  }
}
