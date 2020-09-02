//
//  ReservationDashboardVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/02.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationDashboardVC: UIViewController {
  
  lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.hamburger.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapNavigationButton(_:))
    )
    barButtonItem.tintColor = .white
    
    return barButtonItem
  }()
  
  lazy var rightNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      title: "고객센터",
      style: .plain,
      target: self,
      action: #selector(didTapNavigationButton(_:))
    )
    barButtonItem.tintColor = .white
    
    return barButtonItem
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    // test code
    view.backgroundColor = CommonUI.mainDark
    
    // setUI
    setNavigation()
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    navigationItem.leftBarButtonItem = self.leftNavigationButton
    navigationItem.rightBarButtonItem = self.rightNavigationButton
    
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
  }
  
  // MARK: - Action
  
  @objc fileprivate func didTapNavigationButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      print("lef navigation button press")
    default:
      print("right navigation button press")
    }
  }
}
