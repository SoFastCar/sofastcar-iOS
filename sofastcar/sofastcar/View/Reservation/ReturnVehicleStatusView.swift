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
    
    [warningImage, descriptionLabel].forEach {
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
  }
}
