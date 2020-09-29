//
//  EventAndBenefitFooterView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class EventAndBenefitFooterView: UIView {
  // MARK: - Properties
  lazy var guide = layoutMarginsGuide
  
  let seperateView = UIView()
  
  let vipImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "vip")
    imageView.backgroundColor = .white
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "VIP 제휴 혜택"
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }()
  
  let subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카앱만 보여줘도 할인!"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    return label
  }()
  
  let checkBenefitsButton: UIButton = {
    let button = UIButton()
    button.setTitle("혜택 확인하기", for: .normal)
    button.setTitleColor(CommonUI.mainBlue, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.backgroundColor = .white
    return button
  }()
  
  // MARK: - Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: -50, right: 10)
    backgroundColor = .white
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    [seperateView, vipImageView, titleLabel, subtitleLabel, checkBenefitsButton].forEach {
      addSubview($0)
    }
    
    seperateView.backgroundColor = .systemGray4
    seperateView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(1)
    }
    
    vipImageView.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
      $0.width.height.equalTo(80)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(vipImageView.snp.bottom).offset(10)
      $0.leading.equalTo(guide)
    }
    
    subtitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(3)
      $0.leading.equalTo(guide)
    }
    
    checkBenefitsButton.snp.makeConstraints {
      $0.top.equalTo(subtitleLabel.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(50)
    }
  }
}
