//
//  SocarClubScrollView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/25.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SocarClubScrollView: UIScrollView {
  // MARK: - Properties
  var username = "김광수"
  var userLevel = 4
  var socarClubLable: Int = 0
  var userTotalDrivingKm: Int = 800
  var userDrivingKm: Int = 200
  lazy var guide = contentView.layoutMarginsGuide
  
  struct CircleImageContract {
    let circlePadding: CGFloat = 20
    
    let middleCircleWidth: CGFloat = 150
    lazy var outLineCircleWidth: CGFloat = middleCircleWidth + circlePadding
    
    lazy var middleCircleCenterX: CGFloat = UIScreen.main.bounds.width/2 - middleCircleWidth/2 - CGFloat(20)
    let middleCircleCenterY: CGFloat = 30
    
    lazy var outLineCircleCenterX: CGFloat = UIScreen.main.bounds.width/2 - outLineCircleWidth/2 - CGFloat(20)
    lazy var outlineCircleCenterY: CGFloat = middleCircleCenterY - circlePadding/2
    
    let outLineCircleLineWidth: CGFloat = 4
    let userExCircleLineWidth: CGFloat = 8
    
    let middleCircleColor = CommonUI.mainDark.cgColor
    let outLineCircleColor = UIColor.systemGray4.cgColor
    let userExCircleColor = CommonUI.mainBlue.cgColor
  }
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 0, right: 15)
    return view
  }()
  
  lazy var drivingDistanceInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "지금까지 쏘카와 함께\n \(userTotalDrivingKm)km 드라이브했어요."
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 25)
    label.textColor = .black
    return label
  }()
  
  let displayLevelImageView: UIImageView = {
    let view = UIImageView()
    view.backgroundColor = .white
    return view
  }()
  
  lazy var usernameLabel: UILabel = {
    let label = UILabel()
    label.text = "\(username)의 레벨"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize, weight: .light)
    label.textColor = .systemGray2
    return label
  }()
  
  lazy var userLevelLabel: UILabel = {
    let label = UILabel()
    label.text = "Level \(userLevel)"
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  lazy var userClubLevelInfoLable: UILabel = {
    let label = UILabel()
    label.text = "다음 레벨까지 남은거리 \(userDrivingKm)km\n레벨 \(socarClubLable)가 되면 탈때마다 차량 손해면책 상품을 10%\n 할인해드려요"
    label.numberOfLines = 3
    label.textAlignment = .center
    label.textColor = .darkGray
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    return label
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configureScrollView()
    configureSocarDrivingUI()
    configuerCircleUI()
    configureLabelInCircle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureScrollView() {
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    } else {
      heightPadding = 0
    }
    backgroundColor = .white
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    self.addSubview(contentView)
  }
  
  private func configureSocarDrivingUI() {
    [drivingDistanceInfoLabel, displayLevelImageView, userClubLevelInfoLable].forEach {
      contentView.addSubview($0)
    }
    
    drivingDistanceInfoLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
      $0.height.equalTo(100)
    }
    
    displayLevelImageView.snp.makeConstraints {
      $0.top.equalTo(drivingDistanceInfoLabel.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(200)
    }
    
    userClubLevelInfoLable.snp.makeConstraints {
      $0.top.equalTo(displayLevelImageView.snp.bottom).offset(30)
      $0.centerX.equalTo(contentView.snp.centerX)
      $0.height.equalTo(100)
    }
  }
  
  private func configuerCircleUI() {
    var circleGuide = CircleImageContract()
    
    let width = UIScreen.main.bounds.width - 20 - 20
    UIGraphicsBeginImageContext(CGSize(width: width, height: 200))
    
    let context = UIGraphicsGetCurrentContext()!
    // middle Circle
    let middleCircleConfigure = CGRect(x: circleGuide.middleCircleCenterX,
                                       y: circleGuide.middleCircleCenterY,
                                       width: circleGuide.middleCircleWidth,
                                       height: circleGuide.middleCircleWidth)
    context.addEllipse(in: middleCircleConfigure)
    context.setFillColor(CommonUI.mainDark.cgColor)
    context.fillPath()
    context.strokePath()
    
    //outLine Circle
    let outLineCircleConfigure = CGRect(x: circleGuide.outLineCircleCenterX,
                                        y: circleGuide.outlineCircleCenterY,
                                        width: circleGuide.outLineCircleWidth,
                                        height: circleGuide.outLineCircleWidth)
    context.setLineWidth(circleGuide.outLineCircleLineWidth)
    context.setStrokeColor(circleGuide.outLineCircleColor)
    context.addEllipse(in: outLineCircleConfigure)
    context.strokePath()
    
    displayLevelImageView.image = UIGraphicsGetImageFromCurrentImageContext()
    
    let layer = CAShapeLayer()
    let path = UIBezierPath(arcCenter: CGPoint(x: circleGuide.outLineCircleCenterX+85,
                                               y: circleGuide.outlineCircleCenterY+85),
                            radius: circleGuide.outLineCircleWidth/2,
                            startAngle: .pi * -180 / 360,
                            endAngle: .pi * 270 / 360,
                            clockwise: true)
//    path.lineWidth = circleGuide.userExCircleLineWidth
//    path.lineCapStyle = .square
//    path.lineJoinStyle = .bevel
//    CommonUI.mainBlue.set()
//    path.stroke()
    
    layer.path = path.cgPath
    
    let animation = CABasicAnimation(keyPath: "fillColor")
    animation.fromValue = 0
    animation.toValue = CommonUI.mainBlue.cgColor
    animation.duration = 5
    layer.fillColor = nil
    layer.strokeColor = CommonUI.mainBlue.cgColor
    layer.lineWidth = circleGuide.userExCircleLineWidth
    layer.add(animation, forKey: "fillColor")
    
    displayLevelImageView.layer.addSublayer(layer)
    UIGraphicsEndImageContext()
  }
  
  private func configureLabelInCircle() {
    [usernameLabel, userLevelLabel].forEach {
      displayLevelImageView.addSubview($0)
    }
    
    usernameLabel.snp.makeConstraints {
      $0.centerX.equalTo(displayLevelImageView.snp.centerX)
      $0.centerY.equalTo(displayLevelImageView.snp.centerY).offset(-10)
    }
    
    userLevelLabel.snp.makeConstraints {
      $0.centerX.equalTo(displayLevelImageView.snp.centerX)
      $0.centerY.equalTo(displayLevelImageView.snp.centerY).offset(15)
    }
  }
}
