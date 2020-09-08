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
  let reservationStateView: ReservationStateView = {
    let scrollView = ReservationStateView()
    
    return scrollView
  }()
  
  let carKey: CarKeyView = {
    let view = CarKeyView()
    
    return view
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    view.backgroundColor = CommonUI.reservationBackground
    
    setNavigation()
    
    [reservationStateView, carKey].forEach {
      view.addSubview($0)
    }
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
