//
//  UserStatusAfterReturnVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class UserStatusAfterReturnVC: UIViewController {
  
  fileprivate let userStatusAfterReturnView = UserStatusAfterReturnView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI

  fileprivate func setUI() {
    let guid = view.safeAreaLayoutGuide
    userStatusAfterReturnView.delegate = self
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = .white
    
    [userStatusAfterReturnView].forEach {
      view.addSubview($0)
    }
    
    userStatusAfterReturnView.snp.makeConstraints {
      $0.edges.equalTo(guid)
    }
  }
}

// MARK: - UserStatusAfterReturnViewDelegate

extension UserStatusAfterReturnVC: UserStatusAfterReturnViewDelegate {
  func didTapButton(_ sender: UIButton) {
    print("didTapButton")
    switch sender {
    case userStatusAfterReturnView.closeButton:
      dismiss(animated: false, completion: nil)
    default:
      break
    }
  }
}
