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
  
  fileprivate lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.leftArrow.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapNavigationButton(_:))
    )
    barButtonItem.tintColor = CommonUI.mainDark
    
    return barButtonItem
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    returnVehicleView.delegate = self
    setNavigation()
    
    [returnVehicleView].forEach {
      view.addSubview($0)
    }
    
    returnVehicleView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    navBar?.prefersLargeTitles = true
    navBar?.backgroundColor = .white
    navBar?.barTintColor = UIColor.white
    
    self.navigationItem.leftBarButtonItem = self.leftNavigationButton
    self.title = "반납 하기"
  }
  
  // MARK: - Action
  
  @objc func didTapNavigationButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      dismiss(animated: false, completion: nil)
    default:
      break
    }
  }
}

// MARK: - ReturnVehicleViewDelegate

extension ReturnVehicleVC: ReturnVehicleViewDelegate {
  func didTapButton(_ sender: UIButton) {
    switch sender {
    case returnVehicleView.rightChevronButton:
      print("rightCheveronButton")
    case returnVehicleView.returnButton:
      print("returnButton")
      let userStatusAfterReturnVC = UserStatusAfterReturnVC()
      navigationController?.pushViewController(userStatusAfterReturnVC, animated: true)
    default:
      break
    }
  }
}
