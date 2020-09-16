//
//  vehicleCheckCell.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleCheckCell: UICollectionViewCell {
  
  static let identifier = "vehicleCheckCell"
  
  var vehicleStatusString: String? {
    didSet {
      vehicleStatusLabel.text = vehicleStatusString
    }
  }
  
  var vehicleStatusImageString: String? {
    didSet {
      vehicleStatusImageView.image = UIImage(named: vehicleStatusImageString ?? "empty")
    }
  }
  
  fileprivate let vehicleStatusLabel: UILabel = {
    let label = UILabel()
    label.text = "스크래치"
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    
    return label
  }()

  fileprivate let vehicleStatusImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "스크래치")
    imageView.contentMode = .scaleAspectFit
    
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
    [vehicleStatusLabel, vehicleStatusImageView].forEach {
      self.addSubview($0)
    }
    
    vehicleStatusLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalToSuperview()
    }
    
    vehicleStatusImageView.snp.makeConstraints {
      $0.top.equalTo(vehicleStatusLabel.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}
