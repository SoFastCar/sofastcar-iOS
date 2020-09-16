//
//  VehicleDoubleCheckVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleDoubleCheckVC: UIViewController {
  
  fileprivate let vehicleDoubleCheckView = VehicleDoubleCheckView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    let guid = view.safeAreaLayoutGuide
    view.backgroundColor = .white
    vehicleDoubleCheckView.customDelegate = self
    
    [vehicleDoubleCheckView].forEach {
      view.addSubview($0)
    }
    
    vehicleDoubleCheckView.snp.makeConstraints {
      $0.edges.equalTo(guid)
    }
  }
}

// MARK: - VehicleDoubleCheckViewDelegate

extension VehicleDoubleCheckVC: VehicleDoubleCheckViewDelegate {
  func didTapButton(_ sender: UIButton) {
    switch sender {
    case vehicleDoubleCheckView.vehicleDamageButton:
      self.dismiss(animated: true, completion: nil)
    case vehicleDoubleCheckView.vehicleNoDamageButton:
      self.dismiss(animated: true, completion: nil)
    default:
      break
    }
  }
}
