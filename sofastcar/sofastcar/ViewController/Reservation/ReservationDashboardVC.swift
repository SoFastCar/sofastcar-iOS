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
  
  let reservationStateView = ReservationStateView()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  override func loadView() {
    view = reservationStateView
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    view.backgroundColor = CommonUI.reservationBackground
    
    setNavigation()
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    self.navigationItem.leftBarButtonItem = reservationStateView.leftNavigationButton
    self.navigationItem.rightBarButtonItem = reservationStateView.rightNavigationButton
    
    navBar?.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    navBar?.shadowImage = UIImage()
    navBar?.isTranslucent = true
    navBar?.backgroundColor = UIColor.clear
  }
}
