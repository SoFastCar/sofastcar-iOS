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
    barButtonItem.tintColor = CommonUI.grayColor
    
    return barButtonItem
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    self.view.backgroundColor = CommonUI.grayColor
    
    setNavigation()
    [vehicleCheckView].forEach {
      view.addSubview($0)
    }
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    self.navigationItem.leftBarButtonItem = self.leftNavigationButton
    
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.backgroundColor = CommonUI.grayColor
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      dismiss(animated: false, completion: nil)
    default:
      break
    }
  }
}
