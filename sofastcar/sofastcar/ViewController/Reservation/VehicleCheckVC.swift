//
//  VehicleCheckVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleCheckVC: UIViewController {
  
  let vehicleCheckView = VehicleCheckView()
  
  lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = CommonUI.mainDark
    
    return barButtonItem
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setUI()
    setVehicleCheckButton()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    vehicleCheckView.customDelegate = self
    self.view.backgroundColor = CommonUI.grayColor
    
    setNavigation()
    [vehicleCheckView].forEach {
      view.addSubview($0)
    }
    
    hideKeyboard()
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    navBar?.prefersLargeTitles = true
    navBar?.backgroundColor = .white
    navBar?.barTintColor = UIColor.white
    
    self.navigationItem.leftBarButtonItem = self.leftNavigationButton
    self.title = "차량 확인하기"
  }
  
  fileprivate func setVehicleCheckButton() {
    let vehicleCheckButton = vehicleCheckView.vehicleCheckStartButton
    
    if UserDefaults.getVehicleBoubleCheck() == true {
      vehicleCheckButton.setTitle("완료되었습니다.", for: .normal)
      vehicleCheckButton.setTitleColor(.gray, for: .normal)
      vehicleCheckButton.backgroundColor = .systemGray6
      vehicleCheckButton.isEnabled = false
    }
  }
  
  // MARK: - Action
  
  fileprivate func setAction() {
    vehicleCheckView.vehicleCheckStartButton.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
  }
  
  @objc func didTapButton(_ sender: UIButton) {
    print(sender)
    switch sender {
    case leftNavigationButton:
      dismiss(animated: false, completion: nil)
    case vehicleCheckView.vehicleCheckStartButton:
      print("")
      let vehicleTakePictureVC = VehicleTakePictureVC()
      let navigationController = UINavigationController(rootViewController: vehicleTakePictureVC)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(vehicleTakePictureVC, animated: false)
    default:
      break
    }
  }
}

extension VehicleCheckVC: VehicleCheckViewDelegate {
  func buttonAction(_ sender: UIButton) {
    switch sender {
    case vehicleCheckView.vehicleCheckStartButton:
      let vehicleTakePictureVC = VehicleTakePictureVC()
      let navigationController = UINavigationController(rootViewController: vehicleTakePictureVC)
      navigationController.modalPresentationStyle = .fullScreen
      self.present(navigationController, animated: false, completion: nil)
    case vehicleCheckView.vehicleCheckTagSubmitButton:
      UserDefaults.setVehiclCheck(check: true)
      self.view.window?.rootViewController?.dismiss(animated: false, completion: {
        let homeVC = UINavigationController(rootViewController: ReservationDashboardVC())
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.modalTransitionStyle = .crossDissolve
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError() }
        appDelegate.window?.rootViewController?.present(homeVC, animated: true, completion: nil)
      })
    default:
      break
    }
  }
}
