//
//  VehicleDoubleCheckVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class VehicleDoubleCheckVC: UIViewController {
  
    // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    self.view.backgroundColor = .magenta
    
    [].forEach {
      view.addSubview($0)
    }
  }
  
}
