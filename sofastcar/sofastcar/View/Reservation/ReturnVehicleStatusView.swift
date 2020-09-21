//
//  ReturnVehicleStatusView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReturnVehicleStatusView: UIView {

  fileprivate let warningImage: UIImageView = {
    let imageView = UIImageView()
    let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .large)
    imageView.image = UIImage(
      systemName: CommonUI.SFSymbolKey.warning.rawValue,
      withConfiguration: config
    )
    imageView.tintColor = CommonUI.mainDark
    
    return imageView
  }()
  
  fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "반납을 위해 아래 항목을 확인해주세요"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    
    return label
  }()
  
  fileprivate let startingStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "시동"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    return label
  }()
  
  fileprivate let headlightStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "전조등"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    return label
  }()

  fileprivate let lockStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "잠금 상태"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    return label
  }()
  
  fileprivate let doorCloseStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 문"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    return label
  }()
  
  fileprivate let returnTimeStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "반납 시간"
    label.textColor = CommonUI.mainDark
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    
    return label
  }()
  
  fileprivate lazy var vehicleStatusLabelStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        startingStatusLabel,
        headlightStatusLabel,
        lockStatusLabel,
        doorCloseStatusLabel,
        returnTimeStatusLabel
      ]
    )
    stackView.axis = .vertical
    stackView.spacing = 20
    
    return stackView
  }()
  
  
  
  fileprivate lazy var vehicleReturnOptionStatusStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        startingStatusLabel,
        headlightStatusLabel,
        lockStatusLabel,
        doorCloseStatusLabel,
        returnTimeStatusLabel
      ]
    )
    stackView.axis = .vertical
    stackView.spacing = 20
    
    return stackView
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    self.backgroundColor = .white
    
    [warningImage, descriptionLabel, vehicleStatusLabelStackView, vehicleReturnOptionStatusStackView].forEach {
      self.addSubview($0)
    }
    
    setConstraints()
  }
  
  fileprivate func setConstraints() {
    
    warningImage.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(warningImage.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    vehicleStatusLabelStackView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    vehicleReturnOptionStatusStackView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(30)
      $0.leading.equalTo(vehicleStatusLabelStackView.snp.trailing).offset(30)
    }
  }
}
