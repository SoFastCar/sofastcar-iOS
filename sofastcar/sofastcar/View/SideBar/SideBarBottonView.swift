//
//  SideBarBottonView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SideBarBottonView: UIView {
  // MARK: - Properties
  let businessButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "business"), for: .normal)
    return button
  }()
  
  let businessLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 비지니스"
    return label
  }()
  
  let planButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "plan"), for: .normal)
    return button
  }()
  
  let planLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 플랜"
    return label
  }()
  
  let pairingButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "pairing"), for: .normal)
    return button
  }()
  
  let pairingLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 페어링"
    return label
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray6
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    [businessButton, planButton, pairingButton].forEach {
      addSubview($0)
      $0.backgroundColor = .white
      $0.layer.cornerRadius = 10
      $0.layer.borderWidth = 1
      $0.layer.borderColor = UIColor.systemGray2.cgColor
      $0.clipsToBounds = true
    }
    
    [businessLabel, planLabel, pairingLabel].forEach {
      addSubview($0)
      $0.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-3)
      $0.textColor = .darkGray
    }
    
    planButton.snp.makeConstraints {
      $0.top.equalTo(self).offset(10)
      $0.centerX.equalTo(snp.centerX)
      $0.width.height.equalTo(45)
    }
    
    planLabel.snp.makeConstraints {
      $0.top.equalTo(planButton.snp.bottom).offset(10)
      $0.centerX.equalTo(planButton.snp.centerX)
    }
    
    businessButton.snp.makeConstraints {
      $0.centerY.equalTo(planButton.snp.centerY)
      $0.trailing.equalTo(planButton.snp.leading).offset(-40)
      $0.width.height.equalTo(45)
    }
    
    businessLabel.snp.makeConstraints {
      $0.top.equalTo(businessButton.snp.bottom).offset(10)
      $0.centerX.equalTo(businessButton.snp.centerX)
    }
    
    pairingButton.snp.makeConstraints {
      $0.centerY.equalTo(planButton.snp.centerY)
      $0.leading.equalTo(planButton.snp.trailing).offset(40)
      $0.width.height.equalTo(45)
    }
    
    pairingLabel.snp.makeConstraints {
      $0.top.equalTo(pairingButton.snp.bottom).offset(10)
      $0.centerX.equalTo(pairingButton.snp.centerX)
    }
  }
}
