//
//  ReservationConfirmTableHeaderView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationConfirmTableHeaderView: UIView {

  // MARK: - Properties
  enum ReservationType: Int {
    case normal = 0
    case socarSave = 1
    case burum
  }
  
  var padding: CGFloat = 10
  var isSocarSaveCar = false
  
  let carName: UILabel = {
    let label = UILabel()
    label.text = "아반떼AD"
    label.textColor = .darkGray
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let socarSaveInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "실속형 서비스 쏘카세이브 차량입니다."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let socarSaveInfoButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let carOptionLabel: UILabel = {
    let label = UILabel()
    label.text = "휘발류"
    label.backgroundColor = .systemGray6
    label.font = .systemFont(ofSize: 11, weight: .ultraLight)
    label.textColor = .gray
    label.textAlignment = .center
    label.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    label.contentMode =
    return label
  }()
  
  let carImageContainerView = UIView()
  
  let carImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "testCar")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  // MARK: - Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    self.layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    let guide = self.layoutMarginsGuide
    
    configureCarDetailInfoUI(guide)
    
    configureCarImageUI(guide)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureCarDetailInfoUI(_ guide: UILayoutGuide) {
    [carName, socarSaveInfoLabel, socarSaveInfoButton, carOptionLabel].forEach {
      addSubview($0)
    }
    
    carName.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    socarSaveInfoLabel.snp.makeConstraints {
      $0.top.equalTo(carName.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(carName)
    }
    
    socarSaveInfoButton.snp.makeConstraints {
      $0.centerY.equalTo(socarSaveInfoLabel.snp.centerY)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(carName).multipliedBy(5)
    }
    
    carOptionLabel.snp.makeConstraints {
      $0.top.equalTo(socarSaveInfoLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(carName)
    }
  }
  
  private func configureCarImageUI(_ guide: UILayoutGuide) {
    addSubview(carImageContainerView)
    carImageContainerView.snp.makeConstraints {
      $0.top.equalTo(carOptionLabel.snp.bottom).offset(padding)
      $0.leading.trailing.equalTo(guide)
//      $0.height.equalTo(200)
      $0.bottom.equalTo(guide)
    }
    
    carImageContainerView.addSubview(carImage)
    carImage.snp.makeConstraints {
      $0.centerX.equalTo(carImageContainerView.snp.centerX)
      $0.centerY.equalTo(carImageContainerView.snp.centerY)
      $0.width.equalTo(UIScreen.main.bounds.width*2/3)
    }
  }
}
