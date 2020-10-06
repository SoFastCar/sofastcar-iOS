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
  let buttonWidthSize: CGFloat = 80
  
  let infomationLabel: UILabel = {
    let label = UILabel()
    label.textColor = CommonUI.mainBlue
    label.textAlignment = .center
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.text = "사각형 영역에 맞춘 후\n선명하게 보일 때 촬영해주세요."
    
    return label
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
    [infomationLabel, captureButton].forEach {
      addSubview($0)
    }
    
    infomationLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(50)
      $0.centerX.equalTo(self.snp.centerX)
    }
    
    captureButton.snp.makeConstraints {
      $0.bottom.equalTo(infomationLabel.snp.top)
      $0.centerX.equalTo(self.snp.centerX)
      $0.width.height.equalTo(buttonWidthSize)
    }
  }
}
