//
//  CouponDetailView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CouponDetailVC: UIViewController {
  // MARK: - Properties
  var couponDate: CouponBook?
  let padding: CGFloat = 10
  let centerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  let couponTitleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  // MARK: - SquareView
  let squareView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.systemGray2.cgColor
    return view
  }()
  
  let usedurationLabel: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.text = "차량 이용 가능 시간"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    return label
  }()
  
  let usedurationValueLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.text = "2020년 10월 31일 23시 59분"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    return label
  }()
  
  let restrictLabel: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.text = "존/차종 제한"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    return label
  }()
  
  let restrictValueLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.text = "서울특별시 내 전기차 전용"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    return label
  }()
  
  let etcLabel: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.text = "기타"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    return label
  }()
  
  let etcValueLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.numberOfLines = 3
    label.text = "전기차는 만 23세 이상부터 이용 가능합니다.\n벤츠 EQC는 만 26세 이상부터 이용 가능합니다.\n이 쿠폰 예고없이 종료될 수 있습니다."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    return label
  }()
  // MARK: - Buttom buttons
  let cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("취소", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.backgroundColor = CommonUI.mainDark
    return button
  }()
  
  let downLoadCouponButton: UIButton = {
    let button = UIButton()
    button.setTitle("쿠폰받기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.backgroundColor = CommonUI.mainBlue
    return button
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = CommonUI.mainDark.withAlphaComponent(0.7)
    configureLayout()
    configureButtonButtonSetting()
    configureSquareView()
  }
  
  private func configureLayout() {
    view.addSubview(centerView)
    centerView.snp.makeConstraints {
      $0.centerY.centerX.equalToSuperview()
      $0.height.equalTo(350)
      $0.width.equalTo(280)
    }
    
    [couponTitleLabel].forEach {
      centerView.addSubview($0)
    }
    
    couponTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.centerX.equalToSuperview()
    }
    couponTitleLabel.text = couponDate?.name
  }
  
  private func configureButtonButtonSetting() {
    [cancelButton, downLoadCouponButton].forEach {
      centerView.addSubview($0)
    }
    
    cancelButton.snp.makeConstraints {
      $0.leading.bottom.equalTo(centerView)
      $0.height.equalTo(50)
    }
    
    downLoadCouponButton.snp.makeConstraints {
      $0.leading.equalTo(cancelButton.snp.trailing)
      $0.trailing.bottom.equalTo(centerView)
      $0.width.equalTo(cancelButton.snp.width)
      $0.height.equalTo(50)
    }
    cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
  }
  
  private func configureSquareView() {
    centerView.addSubview(squareView)
    squareView.snp.makeConstraints {
      $0.top.equalTo(couponTitleLabel.snp.bottom).offset(15)
      $0.leading.equalTo(centerView).offset(10)
      $0.trailing.equalTo(centerView).offset(-10)
      $0.bottom.equalTo(cancelButton.snp.top).offset(-10)
    }
    
    squareView.layoutMargins = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 20)
    let guide = squareView.layoutMarginsGuide
    
    let separateView1 = UIView()
    separateView1.backgroundColor = .systemGray2
    let separateView2 = UIView()
    separateView2.backgroundColor = .systemGray2
    
    [usedurationLabel, usedurationValueLabel, separateView1, restrictLabel, restrictValueLabel, separateView2, etcLabel, etcValueLabel].forEach {
      squareView.addSubview($0)
    }
    
    usedurationLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    usedurationValueLabel.snp.makeConstraints {
      $0.top.equalTo(usedurationLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    
    separateView1.snp.makeConstraints {
      $0.top.equalTo(usedurationValueLabel.snp.bottom).offset(padding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    restrictLabel.snp.makeConstraints {
      $0.top.equalTo(separateView1.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    
    restrictValueLabel.snp.makeConstraints {
      $0.top.equalTo(restrictLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    
    separateView2.snp.makeConstraints {
      $0.top.equalTo(restrictValueLabel.snp.bottom).offset(padding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    etcLabel.snp.makeConstraints {
      $0.top.equalTo(separateView2.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    
    etcValueLabel.snp.makeConstraints {
      $0.top.equalTo(etcLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
  }
  
  // MARK: - handler
  @objc private func tapCancelButton() {
    dismiss(animated: false, completion: nil)
  }
  
}
