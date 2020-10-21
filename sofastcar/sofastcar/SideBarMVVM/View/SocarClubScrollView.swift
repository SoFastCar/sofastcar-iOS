//
//  SocarClubScrollView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/25.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class SocarClubScrollView: UIScrollView {
  // MARK: - Properties
  var socarClubVC: SocarClubVC?
  var username = "김광수"
  var userLevel = 4
  var socarClubLable: Int = 0
  var userTotalDrivingKm: Int = 800
  var userDrivingKm: Int = 200
  lazy var guide = contentView.layoutMarginsGuide
  var downLoadButtonArray: [UIButton] = []
  var couponViewArray: [UIView] = []
  let movPlayerHeight: CGFloat = 220
  
  // MARK: - First Section Properties
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
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize-1)
    return label
  }()
  
  let seperateView = DotsLineView()
  
  // MARK: - Second Section UI Properties
  lazy var secondTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "레벨 \(userLevel) 혜택과 함께 쏘카클럽만의\n드라이빙 코스를 만나보세요!"
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 18)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  let movPlayerView = UIView()
  
  let drivingMovPlayer: AVPlayer = {
    let videoPath = Bundle.main.path(forResource: "SocarClub", ofType: ".mov")
    let player = AVPlayer(url: URL(fileURLWithPath: videoPath!))
    player.actionAtItemEnd = .none
    return player
  }()
  
  let socarClubRecommnedCourceLabel: UILabel = {
    let label = UILabel()
//    label.text = "쏘카클럽 드라이빌 추천 코스 보러가기 >"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    label.textColor = .systemGray2
    let attributedString = NSMutableAttributedString.init(string: "쏘카클럽 드라이빙 추천 코스 보러가기 >")
    attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range: NSRange.init(location: 0, length: attributedString.length))
    label.attributedText = attributedString
    return label
  }()
  
  // MARK: - Third Section UI Properties
  let seperateView1 = DotsLineView()
  
  lazy var thirdSectionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "레벨 \(userLevel)의 혜택"
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = .gray
    return label
  }()
  
  let couponTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "• 매달 드리는 쿠폰"
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  let couponSubTitleLable: UILabel = {
    let label = UILabel()
    label.text = "매달 1일 레벨별 할인 쿠폰을 드립니다."
    label.font = .systemFont(ofSize: 15)
    label.textColor = .gray
    return label
  }()
  
  let showLavelBenefitsButton: UIButton = {
    let button = UIButton()
    button.setTitle("레벨별 혜택보기", for: .normal)
    button.setTitleColor(CommonUI.mainBlue, for: .normal)
    button.backgroundColor = .white
    button.layer.borderWidth = 2
    button.layer.borderColor = UIColor.systemGray4.cgColor
    return button
  }()
  
  // MARK: - Life Cycle
  init(frame: CGRect, couponArray: [Coupon]) {
    super.init(frame: frame)
    configureScrollView(couponArray: couponArray)
    
    //first Section
    configureSocarDrivingUI()
    configuerCircleUI()
    configureLabelInCircle()
    addSeparateView()
    
    //second Section
    configureSecondSectionUI()
    
    //third SEction
    configureThirdSectionUI(couponArray: couponArray)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - First Section UI Setting
  private func configureScrollView(couponArray: [Coupon]) {
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    } else {
      heightPadding = 0
    }
    backgroundColor = .white
    let verticalPadding = Int(movPlayerHeight) + 110*couponArray.count + 10*(couponArray.count) + 140
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+CGFloat(verticalPadding))
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding+CGFloat(verticalPadding))
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
        
    let animation = CABasicAnimation(keyPath: "strokeEnd")
    animation.fromValue = 0
    animation.toValue = 1
    animation.duration = 3
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    
    let path = UIBezierPath(arcCenter: CGPoint(x: circleGuide.outLineCircleCenterX+85,
                                               y: circleGuide.outlineCircleCenterY+85),
                            radius: circleGuide.outLineCircleWidth/2,
                            startAngle: .pi * -180 / 360,
                            endAngle: .pi * 270 / 360,
                            clockwise: true)
    
    let layer = CAShapeLayer()
    layer.path = path.cgPath
    layer.lineWidth = circleGuide.userExCircleLineWidth
    layer.fillColor = nil
    layer.strokeColor = CommonUI.mainBlue.cgColor
    layer.lineWidth = circleGuide.userExCircleLineWidth
    layer.strokeEnd = 1
    layer.add(animation, forKey: animation.keyPath)
    
    displayLevelImageView.layer.addSublayer(layer)
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
  
  private func addSeparateView() {
    contentView.addSubview(seperateView)
    
    seperateView.snp.makeConstraints {
      $0.top.equalTo(userClubLevelInfoLable.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    seperateView.draw(seperateView.frame)
  }
  
  // MARK: - Second Section UI Setting
  private func configureSecondSectionUI() {
    [secondTitleLabel, movPlayerView, socarClubRecommnedCourceLabel, seperateView1].forEach {
      contentView.addSubview($0)
    }
    
    secondTitleLabel.snp.makeConstraints {
      $0.top.equalTo(seperateView.snp.bottom).offset(40)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    movPlayerView.snp.makeConstraints {
      $0.top.equalTo(secondTitleLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(200)
    }
    
    let playerLayer = AVPlayerLayer(player: drivingMovPlayer)
    playerLayer.frame = CGRect(x: -20, y: 0, width: UIScreen.main.bounds.width, height: movPlayerHeight)
    movPlayerView.layer.addSublayer(playerLayer)
    drivingMovPlayer.play()
    
    socarClubRecommnedCourceLabel.snp.makeConstraints {
      $0.top.equalTo(movPlayerView.snp.bottom).offset(20)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    seperateView1.snp.makeConstraints {
      $0.top.equalTo(socarClubRecommnedCourceLabel.snp.bottom).offset(40)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    seperateView1.draw(seperateView1.frame)
  }
  
  // MARK: - Third Section UI Setting
  private func configureThirdSectionUI(couponArray: [Coupon]) {
    [thirdSectionTitleLabel, couponTitleLabel, couponSubTitleLable, showLavelBenefitsButton].forEach {
      contentView.addSubview($0)
    }
    
    thirdSectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(seperateView1.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    couponTitleLabel.snp.makeConstraints {
      $0.top.equalTo(thirdSectionTitleLabel.snp.bottom).offset(40)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    couponSubTitleLable.snp.makeConstraints {
      $0.top.equalTo(couponTitleLabel.snp.bottom).offset(10)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    for coupon in couponArray {
      let couponView = CouponView(frame: .zero, coupon: coupon)
      couponView.draw(couponView.frame)
      downLoadButtonArray.append(couponView.downloadButton)
      couponViewArray.append(couponView)
    }
    
    let stackView = UIStackView(arrangedSubviews: couponViewArray)
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    
    contentView.addSubview(stackView)
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(couponSubTitleLable.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(110*couponArray.count + 10*(couponArray.count-1))
    }
    
    showLavelBenefitsButton.snp.makeConstraints {
      $0.top.equalTo(stackView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(60)
    }
  }
}
