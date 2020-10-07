//
//  UserStatusAfterReturnView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

protocol UserStatusAfterReturnViewDelegate: class {
  func didTapButton(_ sender: UIButton)
}

class UserStatusAfterReturnView: UIView {
  
  weak var delegate: UserStatusAfterReturnViewDelegate?
  
  var userStatusViewTopOffset: Constraint?
  
  let closeButton: UIButton = {
    let button = UIButton()
    let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .large)
    let closeSymbol = UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue, withConfiguration: config)
    button.setImage(
      closeSymbol,
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "반납되었습니다."
    label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let userStatusView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 5
    view.alpha = 0
    view.shadowMaker(view: view)
    
    return view
  }()
  
  fileprivate let userLevelLabel: UILabel = {
    let label = UILabel()
    label.text = "Level 4"
    label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
    label.textColor = CommonUI.mainDark.withAlphaComponent(0.7)
    
    return label
  }()
  
  fileprivate let userNextLevelbaklogLabel: UILabel = {
    let label = UILabel()
    label.text = "레벨 5까지 207km 남았어요."
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark.withAlphaComponent(0.5)
    
    return label
  }()
  
  fileprivate let userAddKilometerLabel: CustomCountingLabel = {
    let label = CustomCountingLabel()
    label.count(fromValue: 0, to: 180, withDuration: 1.5, andAnimationType: .easeInCounter, andCounterType: .intType)
    label.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
//
//  fileprivate let userAddKilometerLabel: UILabel = {
//    let label = UILabel()
//    label.text = "+170km"
//    label.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
//    label.textColor = CommonUI.mainBlue
//
//    return label
//  }()
  
  fileprivate let userLevelStatusbarView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    
    return view
  }()
  
  fileprivate let userLevelPreviousStatusbar: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(
      red: 3 / 255,
      green: 135 / 255,
      blue: 220 / 255,
      alpha: 1
    )
    
    return view
  }()
  
  fileprivate let userLevelAddKilometerStatusbar: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(
      red: 6 / 255,
      green: 184 / 255,
      blue: 255 / 255,
      alpha: 1
    )
    
    return view
  }()
  
  fileprivate let userLevelBenefitLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카클럽 레벨 4인을 위한 혜택, 지금 바로 확인해보세요!"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark.withAlphaComponent(0.5)
    label.backgroundColor = .systemGray6
    label.numberOfLines = .max
    label.textAlignment = .center
    
    return label
  }()
  
  fileprivate let userPaymentDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "・ 주행요금, 하이패스, 연장 요금 등은 등록된 결제카드\n  로 결제됩니다."
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark.withAlphaComponent(0.5)
    label.numberOfLines = .max
    
    return label
  }()
  
  let detailUsageHistory: UIButton = {
    let button = UIButton()
    button.setTitle("이용내역 자세히 보기", for: .normal)
    button.setTitleColor(CommonUI.mainDark.withAlphaComponent(0.7), for: .normal)
    if let title = button.titleLabel?.text {
      button.setAttributedTitle(title.getUnderLineAttributedText(), for: .normal)
    }
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    
    return button
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
    
    animation()
    
    [closeButton, titleLabel, userStatusView, userPaymentDescriptionLabel, detailUsageHistory].forEach {
      self.addSubview($0)
    }
    
    closeButton.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(10)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(closeButton.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    userStatusView.snp.makeConstraints {
      self.userStatusViewTopOffset =  $0.top.equalTo(titleLabel.snp.bottom).offset(100).constraint
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(280)
    }
    
    userPaymentDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(userStatusView.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    detailUsageHistory.snp.makeConstraints {
      $0.top.equalTo(userPaymentDescriptionLabel.snp.bottom).offset(30)
      $0.centerX.equalToSuperview()
    }
    
    userStatus()
  }
  
  fileprivate func userStatus() {
    
    [userLevelLabel, userNextLevelbaklogLabel, userAddKilometerLabel, userLevelStatusbarView, userLevelBenefitLabel].forEach {
      userStatusView.addSubview($0)
    }
    
    userLevelLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.centerX.equalToSuperview()
    }
    
    userNextLevelbaklogLabel.snp.makeConstraints {
      $0.top.equalTo(userLevelLabel.snp.bottom).offset(10)
      $0.centerX.equalToSuperview()
    }
    
    userAddKilometerLabel.snp.makeConstraints {
      $0.top.equalTo(userNextLevelbaklogLabel.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
    }
    
    userLevelStatusbarView.snp.makeConstraints {
      $0.top.equalTo(userAddKilometerLabel.snp.bottom).offset(10)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(30)
    }
    
    userLevelBenefitLabel.snp.makeConstraints {
      $0.top.equalTo(userLevelStatusbarView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(80)
    }
    
    userLabelStatusbar()
  }
  
  fileprivate func userLabelStatusbar() {
    [userLevelPreviousStatusbar, userLevelAddKilometerStatusbar].forEach {
      userLevelStatusbarView.addSubview($0)
    }
    
    userLevelPreviousStatusbar.snp.makeConstraints {
      $0.top.leading.bottom.equalToSuperview()
      $0.width.equalToSuperview().dividedBy(4) // 현재 경험치
    }
    
    userLevelAddKilometerStatusbar.snp.makeConstraints {
      $0.top.bottom.equalToSuperview()
      $0.leading.equalTo(userLevelPreviousStatusbar.snp.trailing)
      $0.width.equalTo(0) // 추가 경험치
    }
  }
  
  // MARK: - Action
  
  @objc fileprivate func didTapButton(_ sender: UIButton) {
    delegate?.didTapButton(sender)
  }
  
  // MARK: - Animation
  
  func animation() {
    UIView.animate(withDuration: 0.5, delay: 0, animations: {
      self.userStatusView.alpha = 1
      self.userStatusViewTopOffset?.update(offset: 30)
      self.layoutIfNeeded()
    }, completion: nil)
  }
  
  func afterAnimation() {
    UIView.animate(withDuration: 0.5) {
      self.userLevelAddKilometerStatusbar.snp.updateConstraints {
        $0.width.equalTo(100)
      }
      self.layoutIfNeeded()
    }
  }
}
