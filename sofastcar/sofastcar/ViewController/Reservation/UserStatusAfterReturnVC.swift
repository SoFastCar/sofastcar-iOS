//
//  UserStatusAfterReturnVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserStatusAfterReturnVC: UIViewController {
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI

  fileprivate func setUI() {
    navigationItem.hidesBackButton = true
    view.backgroundColor = .magenta
  }
}
