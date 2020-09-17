//
//  ReservationDashboardVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/02.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationDashboardVC: UIViewController {
  
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
  
  @objc func didTapVehiclePictureView(recongnize: UITapGestureRecognizer) {
    switch recongnize.state {
    case .ended:
      let vehicleCheckVC = VehicleCheckVC()
      let navigationController = UINavigationController(rootViewController: vehicleCheckVC)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: false)
    default:
      break
    }
  }
}

// MARK: - CarKeyViewDelegate

extension ReservationDashboardVC: CarKeyViewDelegate {
  func buttonAction(_ sender: UIButton) {
    switch sender {
    case carKey.returnButton:
      print("return")
      UserDefaults.setReadyToDrive(isDriveReady: false)
      let provideVC = MainVC()
      provideVC.socarZoneProvider = SocarZoneProvider()
      let mainVC = UINavigationController(rootViewController: provideVC)
      mainVC.modalPresentationStyle = .fullScreen
      self.present(mainVC, animated: false, completion: nil)
    case carKey.lockButton:
      print("lockButton")
    case carKey.unlockButton:
      print("unlockButton")
    case carKey.emergencyButton:
      print("emergencyButton")
    case carKey.hornButton:
      print("hornButton")
    case carKey.riseLockButton:
      print("riseLockButton")
    case carKey.riseUnlockButton:
      print("riseUnlockButton")
    case carKey.riseReturnButton:
      print("riseReturnButton")
      UserDefaults.setReadyToDrive(isDriveReady: false)
      let provideVC = MainVC()
      provideVC.socarZoneProvider = SocarZoneProvider()
      let mainVC = UINavigationController(rootViewController: provideVC)
      mainVC.modalPresentationStyle = .fullScreen
      self.present(mainVC, animated: false, completion: nil)
    default:
      break
    }
  }
}
