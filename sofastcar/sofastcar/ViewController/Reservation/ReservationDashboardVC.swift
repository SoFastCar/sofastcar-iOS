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
  
  fileprivate lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.hamburger.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapNavigationButton(_:))
    )
    barButtonItem.tintColor = .white
    
    return barButtonItem
  }()
  
  fileprivate lazy var rightNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      title: "고객센터",
      style: .plain,
      target: self,
      action: #selector(didTapNavigationButton(_:))
    )
    barButtonItem.tintColor = .white
    
    return barButtonItem
  }()
  
  fileprivate let reservationCarImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "SampleCar")
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    view.backgroundColor = CommonUI.mainDark
    
    setNavigation()
//    setConstraints()
    
    let guid = view.safeAreaLayoutGuide
    [reservationCarImage].forEach {
      view.addSubview($0)
    }
    
    reservationCarImage.snp.makeConstraints {
      $0.top.equalTo(guid).offset(40)
      $0.centerX.equalTo(guid)
      $0.height.equalTo(view.frame.height / 6)
    }
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
