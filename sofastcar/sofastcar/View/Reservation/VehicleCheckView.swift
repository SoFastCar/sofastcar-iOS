//
//  VehicleCheckView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleCheckView: UIScrollView {
  fileprivate let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.grayColor
    
    return view
  }()
  
  fileprivate let vehicleCheckStartView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let vehicleCheckStartTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 확인하기"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleCheckStartDescriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "운행 전 외관 촬영"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleCheckStartDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 외관에서 흠집이나 사고 흔적을 발견했다면 반드시 촬영해주세요. 운행이 불가능한 손상이 있다면 고객센터로 문의해주세요."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let vehicleCheckStartSubDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "꼭 해야 하나요"
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let vehicleCheckStartSubDescriptionButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.questionMark.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let vehicleCheckStartButton: UIButton = {
    let button = UIButton()
    button.setTitle("외관 촬영 시작하기", for: .normal)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  fileprivate let vehicleCheckTagView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let vehicleCheckTagDescriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "운행 전 추가 확인"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleCheckTagDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 내부 상태와 관련된 테그를 선택하거나 메모를 남겨주세요. 차량 게시판에 경고등이 들어와있다면 고객센터로 문의해주세요."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
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
    
    setScrollView()
    setConstraints()
  }
  
  fileprivate func setScrollView() {
    
    self.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
    )
    self.addSubview(contentView)
    
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 {
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    
    self.contentSize = .init(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 44
    )
    contentView.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 144
    )
  }
  
  fileprivate func setConstraints() {
    let guid = contentView.safeAreaLayoutGuide
    
    [vehicleCheckStartView, vehicleCheckTagView].forEach {
      contentView.addSubview($0)
    }
    
    // vehicleCheckStartView
    vehicleCheckStartView.snp.makeConstraints {
      $0.top.equalTo(guid)
      $0.leading.trailing.equalTo(guid)
      $0.height.equalTo(320)
    }
    vehicleCheckStartConstraints()
    
    // vehicleCheckTagView
    vehicleCheckTagView.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guid)
      $0.height.equalTo(500)
    }
    vehicleCheckTagConstraints()
  }
  
  fileprivate func vehicleCheckStartConstraints() {
    let guid = vehicleCheckStartView.safeAreaLayoutGuide
    
    [
      vehicleCheckStartTitleLabel,
      vehicleCheckStartDescriptionTitleLabel,
      vehicleCheckStartDescriptionLabel,
      vehicleCheckStartSubDescriptionLabel,
      vehicleCheckStartSubDescriptionButton,
      vehicleCheckStartButton
    ].forEach {
        vehicleCheckStartView.addSubview($0)
    }
    
    vehicleCheckStartTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guid).offset(10)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleCheckStartDescriptionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartTitleLabel.snp.bottom).offset(40)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleCheckStartDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
    
    vehicleCheckStartSubDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(vehicleCheckStartSubDescriptionButton.snp.leading).offset(-5)
      $0.centerY.equalTo(vehicleCheckStartSubDescriptionButton)
    }
    
    vehicleCheckStartSubDescriptionButton.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(guid).offset(-20)
    }
    
    vehicleCheckStartButton.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartSubDescriptionLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(60)
    }
  }
  
  fileprivate func vehicleCheckTagConstraints() {
    let guid = vehicleCheckTagView.safeAreaLayoutGuide
    
    [
      vehicleCheckTagDescriptionTitleLabel,
      vehicleCheckTagDescriptionLabel
    ].forEach {
      vehicleCheckTagView.addSubview($0)
    }
    
    vehicleCheckTagDescriptionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guid).offset(20)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleCheckTagDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckTagDescriptionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case vehicleCheckStartSubDescriptionButton:
      print("vehicleCheckStartSubDescriptionButton button press")
    case vehicleCheckStartButton:
      print("vehicleCheckStartButton button press")
    default:
      break
    }
  }
}
