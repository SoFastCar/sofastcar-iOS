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
    button.backgroundColor = .black
    button.layer.cornerRadius = buttonWidthSize/2
    button.layer.borderWidth = 6
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
    
    captureDescriptionView.snp.makeConstraints {
      $0.bottom.equalTo(controlView.snp.top)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(50)
    }
    
    controlView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalTo(150)
    }
    
    
    
    //    captureButton.snp.makeConstraints {
//      $0.top.equalTo(navigationView.snp.bottom)
//      $0.centerX.equalTo(self.snp.centerX)
//      $0.width.height.equalTo(buttonWidthSize)
//    }
  }
}
