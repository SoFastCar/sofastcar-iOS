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
  let maskWidth = UIScreen.main.bounds.width*0.9
  lazy var mastheight = maskWidth*0.63
  lazy var rect = CGRect(x: UIScreen.main.bounds.width*0.05,
                    y: UIScreen.main.bounds.height/2-mastheight/2,
                    width: maskWidth,
                    height: mastheight)
  
  lazy var activityIndicator: UIActivityIndicatorView = {
    let activity = UIActivityIndicatorView()
    activity.style = .large
    activity.hidesWhenStopped = true
    activity.color = CommonUI.mainBlue
    return activity
  }()
  
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
  
  let regonSucessTopLine: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  let regonSucessBottomLine: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    return view
  }()
  
  lazy var cardCaptureGuideView = CardCaptureGuideView(frame: rect)
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .clear
    let maskWidth = UIScreen.main.bounds.width*0.9
    let mastheight = maskWidth*0.63
    let rect = CGRect(x: UIScreen.main.bounds.width*0.05,
                      y: UIScreen.main.bounds.height/2-mastheight/2,
                      width: maskWidth,
                      height: mastheight)
    
    configureBackgroundView()
    mask(viewToMask: backgroundView, maskRect: rect, invert: true)
    configureLayout()
    configureCenterView()
    configureSucessTopButtonLine()
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
  
  private func configureBackgroundView() {
    addSubview(backgroundView)
    backgroundView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func configureCenterView() {
    cardCaptureGuideView.backgroundColor = .clear
    cardCaptureGuideView.draw(rect)
    addSubview(cardCaptureGuideView)
    
    cardCaptureGuideView.addSubview(activityIndicator)
    activityIndicator.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  private func configureSucessTopButtonLine() {
    [regonSucessTopLine, regonSucessBottomLine].forEach {
      cardCaptureGuideView.addSubview($0)
    }
    
    regonSucessTopLine.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(5)
    }
    
    regonSucessBottomLine.snp.makeConstraints {
      $0.bottom.leading.trailing.equalToSuperview()
      $0.height.equalTo(5)
    }
  }
}

class CardCaptureGuideView: UIView {
  override func draw(_ rect: CGRect) {
    let path = UIBezierPath()
    CommonUI.mainBlue.set()
    //left top
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: 50))
    path.move(to: CGPoint(x: rect.minX, y: rect.minY))
    path.addLine(to: CGPoint(x: 50, y: rect.minY))
    //right top
    path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX-50, y: rect.minY))
    path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY+50))
    //left bottom
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX+50, y: rect.maxY))
    path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY-50))
    //right Bottom
    path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX-50, y: rect.maxY))
    path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY-50))
    
    path.lineWidth = 10
    path.stroke()
  }
}
