//
//  ReturnVehicleStatusVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReturnVehicleStatusVC: UIViewController {
  
  fileprivate let returnVehicleStatusView = ReturnVehicleStatusView()

  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    [returnVehicleStatusView].forEach {
      view.addSubview($0)
    }
    
    returnVehicleStatusView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(view.frame.height / 3)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
