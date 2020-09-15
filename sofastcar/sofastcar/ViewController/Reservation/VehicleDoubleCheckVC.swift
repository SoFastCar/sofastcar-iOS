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
    view.backgroundColor = .white
    let guid = view.safeAreaLayoutGuide
    
    [vehicleDoubleCheckView].forEach {
      view.addSubview($0)
    }
    
    vehicleDoubleCheckView.snp.makeConstraints {
      $0.edges.equalTo(guid)
    }
  }
}
