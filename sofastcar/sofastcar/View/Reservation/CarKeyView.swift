//
//  CarKeyView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class CarKeyView: UIView {
  
  let screenSize = UIScreen.main.bounds
  
  enum CarKeyState {
    case expanded
    case collapsed
  }
  
  let carKeyViewHeight: CGFloat = 600
  let carKeyViewHandleAreaHeight: CGFloat = 235
  
  var visualEffectView = UIVisualEffectView()
  var cardVisible = false
  var nextState: CarKeyState {
    return cardVisible ? .collapsed : .expanded
  }
  var runningAnimations = [UIViewPropertyAnimator]()
  var animationProgressWhenInterrupted: CGFloat = 0
  
  fileprivate let handleArea: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  
  fileprivate let handler: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.layer.cornerRadius = 2
    view.alpha = 0.1
    
    return view
  }()
  
  fileprivate let smartKeyLabel: UILabel = {
    let label = UILabel()
    label.text = "스마트키"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let onLabel: UILabel = {
    let label = UILabel()
    label.text = "ON"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate let boltIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.bolt.rawValue)
    imageView.tintColor = .black
    imageView.snp.makeConstraints {
      $0.width.equalTo(10)
      $0.height.equalTo(10)
    }
    imageView.alpha = 0.3
    
    return imageView
  }()
  
  fileprivate let openOneSecondLabel: UILabel = {
    let label = UILabel()
    label.text = "1초만에 문 열기"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let rightChevronIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue)
    imageView.tintColor = CommonUI.mainDark
    imageView.snp.makeConstraints {
      $0.width.equalTo(7)
      $0.height.equalTo(15)
    }
    
    return imageView
  }()
  
  fileprivate let underGestureView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  fileprivate let returnButton: UIButton = {
    let button = UIButton()
    button.setTitle("반납하기", for: .normal)
    button.setTitleColor(CommonUI.mainDark, for: .normal)
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.1).cgColor
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  fileprivate let lockView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.1).cgColor
    
    return view
  }()
  
  fileprivate let lockButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.lock.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let milestoneLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .black
    label.alpha = 0.3
    
    return label
  }()
  
  fileprivate let unlockButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.unlock.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate lazy var lockStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        lockButton,
        milestoneLabel,
        unlockButton
      ]
    )
    stackView.axis = .horizontal
    stackView.spacing = 50
    
    return stackView
  }()
  
  fileprivate let riseGestureView: UIView = {
    let view = UIView()
    view.isHidden = true
    
    return view
  }()
  
  fileprivate let emergencyButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.warning.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let emergencyLabel: UILabel = {
    let label = UILabel()
    label.text = "비상등"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let emergencyRiseMilestoneLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textColor = .black
    label.alpha = 0.1
    
    return label
  }()
  
  fileprivate let hornButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.horn.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let hornLabel: UILabel = {
    let label = UILabel()
    label.text = "경적"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = CGRect(
      x: 0,
      y: screenSize.height - 255,
      width: screenSize.width,
      height: screenSize.height - 255
    )
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    self.backgroundColor = .white
    self.clipsToBounds = true
    self.layer.cornerRadius = 10
    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    [handleArea, smartKeyLabel, onLabel, boltIcon, openOneSecondLabel, rightChevronIcon, underGestureView, riseGestureView].forEach {
      self.addSubview($0)
    }
    
    [returnButton, lockView, visualEffectView].forEach {
      underGestureView.addSubview($0)
    }
    
    [emergencyButton, emergencyLabel, emergencyRiseMilestoneLabel, hornButton, hornLabel].forEach {
      riseGestureView.addSubview($0)
    }
    
    handleArea.addSubview(handler)
    lockView.addSubview(lockStackView)
    
    handleArea.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.leading.trailing.equalTo(self)
      $0.height.equalTo(45)
    }
    
    handler.snp.makeConstraints {
      $0.centerX.centerY.equalTo(handleArea)
      $0.width.equalTo(40)
      $0.height.equalTo(5)
    }
    
    smartKeyLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.leading.equalTo(self).offset(40)
    }
    
    onLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.leading.equalTo(smartKeyLabel.snp.trailing).offset(10)
    }
    
    boltIcon.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.trailing.equalTo(openOneSecondLabel.snp.leading).offset(-10)
      $0.centerY.equalTo(openOneSecondLabel)
    }
    
    openOneSecondLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.trailing.equalTo(rightChevronIcon.snp.leading).offset(-5)
    }
    
    rightChevronIcon.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom).offset(-3)
      $0.trailing.equalTo(self).offset(-40)
    }
    
    underGestureView.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(self)
    }
    
    returnButton.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(20)
      $0.leading.equalTo(self).offset(20)
      $0.height.equalTo(60)
      $0.width.equalTo(100)
    }
    
    lockView.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(20)
      $0.leading.equalTo(returnButton.snp.trailing).offset(20)
      $0.trailing.equalTo(self).offset(-40)
      $0.height.equalTo(60)
      $0.width.equalTo(200)
    }
    
    lockStackView.snp.makeConstraints {
      $0.centerY.equalTo(lockView)
      $0.centerX.equalTo(lockView)
    }
    
    emergencyButton.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(60)
      $0.leading.equalTo(self).offset(50)
    }
    
    emergencyLabel.snp.makeConstraints {
      $0.top.equalTo(emergencyButton.snp.bottom).offset(5)
      $0.leading.equalTo(self).offset(45)
    }
    
    emergencyRiseMilestoneLabel.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(60)
      $0.leading.equalTo(emergencyButton.snp.trailing).offset(25)
    }
    
    hornButton.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(60)
      $0.leading.equalTo(emergencyRiseMilestoneLabel.snp.trailing).offset(25)
    }
    
    hornLabel.snp.makeConstraints {
      $0.top.equalTo(hornButton.snp.bottom).offset(5)
      $0.leading.equalTo(emergencyRiseMilestoneLabel.snp.trailing).offset(20)
    }
    
    setGesture()
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case returnButton:
      print("returnButton button press")
    case lockButton:
      print("lockButton button press")
    case unlockButton:
      print("unlockButton button press")
    default:
      print("error")
    }
  }
}

// MARK: - setGesture

extension CarKeyView {
  @objc func handleCarkeyTap(recongnize: UITapGestureRecognizer) {
    switch recongnize.state {
    case .ended:
      animationTransitionIfNeeded(state: nextState, duration: 0.9)
    default:
      break
    }
  }
  @objc func handleCarkeyPan(recongnize: UIPanGestureRecognizer) {
    switch recongnize.state {
    case .began:
      startInteractiveTransition(state: nextState, duration: 0.9)
      print("pan degan Transition")
    case .changed:
      updateInteractiveTransition(fractionCompleted: 0)
      print("pan update Transition")
    case .ended:
      continueInteractiveTransition()
      print("pan continue Transition")
    default:
      break
    }
  }
  
  fileprivate func setGesture() {
    let tapGestureRecongnizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCarkeyTap(recongnize:)))
    let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCarkeyPan(recongnize:)))
    
    handleArea.addGestureRecognizer(tapGestureRecongnizer)
    handleArea.addGestureRecognizer(panGestureRecongnizer)
  }
  
  fileprivate func animationTransitionIfNeeded(state: CarKeyState, duration: TimeInterval) {
    if runningAnimations.isEmpty {
      let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
        switch state {
        case .expanded:
          self.frame = CGRect(
            x: 0,
            y: self.screenSize.height - (self.screenSize.height - self.carKeyViewHandleAreaHeight),
            width: self.screenSize.width,
            height: self.screenSize.height
          )
          self.isHiddenView(view: self.underGestureView, isHidden: true)
          self.isHiddenView(view: self.riseGestureView, isHidden: false)
        case .collapsed:
          self.frame = CGRect(
            x: 0,
            y: self.screenSize.height - 255,
            width: self.screenSize.width,
            height: self.screenSize.height - 255
          )
          self.isHiddenView(view: self.underGestureView, isHidden: false)
          self.isHiddenView(view: self.riseGestureView, isHidden: true)
        }
      }
      frameAnimator.addCompletion { _ in
        self.cardVisible = !self.cardVisible
        self.runningAnimations.removeAll()
      }
      
      frameAnimator.startAnimation()
      runningAnimations.append(frameAnimator)
      
      let blurAnimation = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
        switch state {
        case .expanded:
          self.underGestureView.isHidden = true
          print("expanded")
        case .collapsed:
          print("collapsed")
        }
      }
      
      blurAnimation.startAnimation()
      runningAnimations.append(blurAnimation)
    }
  }
  
  fileprivate func startInteractiveTransition(state: CarKeyState, duration: TimeInterval) {
    if runningAnimations.isEmpty {
      animationTransitionIfNeeded(state: state, duration: duration)
    }
    for animator in runningAnimations {
      animator.pauseAnimation()
      animationProgressWhenInterrupted = animator.fractionComplete
    }
  }
  
  fileprivate func updateInteractiveTransition(fractionCompleted: CGFloat) {
    for animator in runningAnimations {
      animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
    }
  }
  
  fileprivate func continueInteractiveTransition() {
    for animator in runningAnimations {
      animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
    }
  }
  
  fileprivate func isHiddenView(view: UIView, isHidden: Bool) {
    switch view {
    case underGestureView:
      if isHidden == true {
        self.underGestureView.isHidden = true
        self.underGestureView.alpha = 0
      } else {
        self.underGestureView.isHidden = false
        self.underGestureView.alpha = 1
      }
    case riseGestureView:
      if isHidden == true {
        self.riseGestureView.isHidden = true
        self.riseGestureView.alpha = 0
      } else {
        self.riseGestureView.isHidden = false
        self.riseGestureView.alpha = 1
      }
    default:
      break
    }
  }
}
