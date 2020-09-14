//
//  VehicleTakePictureViewCell.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class VehicleTakePictureViewCell: UICollectionViewCell {
  
  static let identifier = "VehicleTakePictureViewCell"
  
  let vehiclePositionLabel: UILabel = {
    let label = UILabel()
    label.text = "전면"
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  let vehicleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "전면")
    imageView.contentMode = .scaleAspectFit
    imageView.alpha = 0.5
    
    return imageView
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
    [vehiclePositionLabel, vehicleImageView].forEach {
      self.addSubview($0)
    }
    
    vehiclePositionLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.trailing.equalToSuperview().offset(20)
    }
    
    vehicleImageView.snp.makeConstraints {
      $0.top.equalTo(vehiclePositionLabel.snp.bottom)
      $0.leading.trailing.equalToSuperview()
    }
  }
}
