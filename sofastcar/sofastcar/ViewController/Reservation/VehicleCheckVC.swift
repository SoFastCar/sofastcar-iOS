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
    print("🏆", UserDefaults.getVehicleBoubleCheck())
    setUI()
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
    default:
      break
    }
  }
}
