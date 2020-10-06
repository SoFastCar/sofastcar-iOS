//
//  VehicleCustomCameraView.swift
//  sofastcar
//
//  Created by 요한 on 2020/10/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleCustomCameraView: UIView {
  // MARK: - Init
  let buttonWidthSize: CGFloat = 70
  
  fileprivate let navigationView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(
      red: 19 / 255,
      green: 22 / 255,
      blue: 28 / 255,
      alpha: 1
    )
    
    return view
  }()
  
  let closeButton: UIButton = {
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
    let closeSymbol = UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue, withConfiguration: config)
    button.setImage(
      closeSymbol,
      for: .normal
    )
//    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = .white
    
    return button
  }()
  
  fileprivate let nowVIewDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "전면"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    label.textAlignment = .center
    
    return label
  }()
  
  fileprivate let captureDescriptionView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    
    return view
  }()
  
  fileprivate let captureDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "한 면당 최대 5장까지 촬영할 수 있습니다."
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textAlignment = .center
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate let controlView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(
      red: 19 / 255,
      green: 22 / 255,
      blue: 28 / 255,
      alpha: 1
    )
    
    return view
  }()
  
  lazy var captureButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = UIColor(
      red: 19 / 255,
      green: 22 / 255,
      blue: 28 / 255,
      alpha: 1
    )
    button.layer.cornerRadius = buttonWidthSize/2
    button.layer.borderWidth = 5
    button.layer.borderColor = CommonUI.mainBlue.cgColor
    
    return button
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setUI() {
    [navigationView, captureDescriptionView, controlView].forEach {
      addSubview($0)
    }
    
    navigationView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(90)
    }
    
    navigationUI()
    
    captureDescriptionView.snp.makeConstraints {
      $0.bottom.equalTo(controlView.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    captureDescriptionUI()
    
    controlView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(150)
    }
    
    controlUI()
  }
  
  fileprivate func captureDescriptionUI() {
    [captureDescriptionLabel].forEach {
      captureDescriptionView.addSubview($0)
    }
    
    captureDescriptionLabel.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  fileprivate func controlUI() {
    [captureButton].forEach {
      controlView.addSubview($0)
    }
    
    captureButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.centerX.equalToSuperview()
      $0.width.height.equalTo(buttonWidthSize)
    }
  }
  
  fileprivate func navigationUI() {
    [closeButton, nowVIewDescriptionLabel].forEach {
      navigationView.addSubview($0)
    }
    
    closeButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(20)
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
    }
    
    nowVIewDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
  }
}
