//
//  NewDriverLicenseEnrollinitView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/23.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class CustomCameraView: UIView {
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
    button.layer.borderWidth = 4
    button.layer.borderColor = CommonUI.mainBlue.cgColor
    return button
  }()
  
  let bottomView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.mainDark
    return view
  }()
  
  let backgroundView: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return view
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    let maskWidth = UIScreen.main.bounds.width*0.9
    let mastheight = maskWidth*0.63
    let rect = CGRect(x: UIScreen.main.bounds.width*0.05,
                      y: UIScreen.main.bounds.height/2-mastheight/2,
                      width: maskWidth,
                      height: mastheight)
    
    configureBackgroundView()
    mask(viewToMask: backgroundView, maskRect: rect, invert: true)
    configureCardRectangelBorderLayout()
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func mask(viewToMask: UIView, maskRect: CGRect, invert: Bool = false) {
    let maskLayer = CAShapeLayer()
    let path = CGMutablePath()
    if invert { // invert True 시 Mask 반전
      path.addRect(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    }
    path.addRect(maskRect)
    maskLayer.path = path
    if invert {
      maskLayer.fillRule = .evenOdd
    }
    // Set the mask of the view.
    viewToMask.layer.mask = maskLayer
  }

  private func configureLayout() {
    [infomationLabel, bottomView, captureButton].forEach {
      addSubview($0)
    }
    
    infomationLabel.snp.makeConstraints {
      $0.top.equalTo(self.safeAreaLayoutGuide).offset(50)
      $0.centerX.equalTo(self.snp.centerX)
    }
    
    bottomView.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
    
    captureButton.snp.makeConstraints {
      $0.bottom.equalTo(bottomView.snp.top)
      $0.centerX.equalTo(self.snp.centerX)
      $0.width.height.equalTo(buttonWidthSize)
    }
  }
  
  private func configureCardRectangelBorderLayout() {
    UIGraphicsBeginImageContext(CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    if let context = UIGraphicsGetCurrentContext() {
      print("Paining Strart")
      // Draw Line
      // 선 굵기를 2.0으로 설정
      context.setLineWidth(2.0)
      // 선 색상을 빨간색으로 설정
      context.setStrokeColor(UIColor.red.cgColor)
      
      context.move(to: CGPoint(x: 50, y: 250))
      context.addLine(to: CGPoint(x: 50, y: 300))
      // 추가하 선을 콘텍스트에 그림
      context.strokePath()
      
      backgroundView.image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    }
  }
  
  private func configureBackgroundView() {
    addSubview(backgroundView)
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}