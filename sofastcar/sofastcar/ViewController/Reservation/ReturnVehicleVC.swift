//
//  ReturnVehicleVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/22.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReturnVehicleVC: UIViewController {
  
  fileprivate let returnVehicleView = ReturnVehicleView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    
    [returnVehicleView].forEach {
      view.addSubview($0)
    }
    
    returnVehicleView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
