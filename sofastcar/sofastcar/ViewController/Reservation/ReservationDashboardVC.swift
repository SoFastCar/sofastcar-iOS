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
  
  fileprivate let carInfomationButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return button
  }()
  
  fileprivate let carTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "마세라티"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let firstDelimiterLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let carOilTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "휘발유"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let secondDelimiterLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let gasStationImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "GasStation")
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { $0.width.height.equalTo(10) }
    imageView.alpha = 0.55
    
    return imageView
  }()
  
  fileprivate let carOilLevelLabel: UILabel = {
    let label = UILabel()
    label.text = "25%"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate lazy var carInfoAndOilStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        carTypeLabel,
        firstDelimiterLabel,
        carOilTypeLabel,
        secondDelimiterLabel,
        gasStationImage,
        carOilLevelLabel
      ]
    )
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 10
    
    return stackView
  }()
  
  fileprivate let reservationRemainingTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 이용 10분 전"
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate let reservationTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "8/15 (토) 14:00"
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate lazy var reservationTimeStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        reservationRemainingTimeLabel,
        reservationTimeLabel
      ]
    )
    stackView.axis = .horizontal
    
    return stackView
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

    [reservationCarImage, numberPlateLabel, carInfomationButton, carInfoAndOilStackView, reservationTimeStackView].forEach {
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
    
    carInfomationButton.snp.makeConstraints {
      $0.top.equalTo(reservationCarImage.snp.bottom).offset(5)
      $0.leading.equalTo(numberPlateLabel.snp.trailing).offset(10)
    }
    
    carInfoAndOilStackView.snp.makeConstraints {
      $0.top.equalTo(numberPlateLabel.snp.bottom).offset(10)
      $0.centerX.equalTo(guid)
    }
    
    reservationTimeStackView.snp.makeConstraints {
      $0.top.equalTo(carInfoAndOilStackView.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
  }
  
  // MARK: - Action
  
  @objc fileprivate func didTapButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      print("lef navigation button press")
    case rightNavigationButton:
      print("right navigation button press")
    case carInfomationButton:
      print("right chevron button press")
    default:
      print("error")
    }
  }
}
