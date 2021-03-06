//
//  VehicleTakePictureViewFooter.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleTakePictureImageView: UIView {
  
  var vehiclePositionString: String? {
    didSet {
      vehiclePositionLabel.text = vehiclePositionString
    }
  }
  
  var vehicleImageStirng: String? {
    didSet {
      vehicleImageView.image = UIImage(named: vehicleImageStirng ?? "empty")
    }
  }
  
  fileprivate let vehiclePositionLabel: UILabel = {
    let label = UILabel()
    label.text = "전면"
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "전면")
    imageView.contentMode = .scaleAspectFit
    imageView.alpha = 0.5
    
    return imageView
  }()
  
  let vehicleTakePictureButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.camera.rawValue),
      for: .normal
    )
    button.tintColor = .white
    button.backgroundColor = UIColor(
      red: 55 / 255,
      green: 69 / 255,
      blue: 84 / 255,
      alpha: 1
    )
    button.layer.cornerRadius = 30
    
    return button
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Layout
  
  private func setUI() {
    [vehiclePositionLabel, vehicleImageView, vehicleTakePictureButton].forEach {
      self.addSubview($0)
    }
    
//    vehicleImageView.addSubview(vehicleTakePictureButton)
    
    vehiclePositionLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.trailing.equalToSuperview().offset(20)
    }
    
    vehicleImageView.snp.makeConstraints {
      $0.top.equalTo(vehiclePositionLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
    
    vehicleTakePictureButton.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.height.equalTo(60)
      $0.width.equalTo(60)
    }
  }
}
