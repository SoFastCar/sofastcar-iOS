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
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return barButtonItem
  }()
  
  fileprivate lazy var rightNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      title: "고객센터",
      style: .plain,
      target: self,
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return barButtonItem
  }()
  
  fileprivate let reservationCarImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "SampleCar")
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  fileprivate let numberPlateLabel: UILabel = {
    let label = UILabel()
    label.text = "57하4455"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textColor = .white
    
    return label
  }()
  
  fileprivate let rightChevronButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return button
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
    setConstraints()
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
  
  fileprivate func setConstraints() {
    let guid = view.safeAreaLayoutGuide

    [reservationCarImage, numberPlateLabel, rightChevronButton].forEach {
      view.addSubview($0)
    }
    
    reservationCarImage.snp.makeConstraints {
      $0.top.equalTo(guid).offset(40)
      $0.centerX.equalTo(guid)
      $0.height.equalTo(view.frame.height / 6)
    }
    
    numberPlateLabel.snp.makeConstraints {
      $0.top.equalTo(reservationCarImage.snp.bottom)
      $0.centerX.equalTo(guid)
    }
    
    rightChevronButton.snp.makeConstraints {
      $0.top.equalTo(reservationCarImage.snp.bottom).offset(5)
      $0.leading.equalTo(numberPlateLabel.snp.trailing).offset(10)
    }
  }
  
  // MARK: - Action
  
  @objc fileprivate func didTapButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      print("lef navigation button press")
    case rightNavigationButton:
      print("right navigation button press")
    case rightChevronButton:
      print("right chevron button press")
    default:
      print("error")
    }
  }
}
