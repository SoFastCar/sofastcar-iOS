//
//  TouView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import WebKit
import SnapKit

class TouView: UIView {
  // MARK: - Properties
  let padding: CGFloat = 20
  
  let webView: WKWebView = {
    let webView = WKWebView()
    return webView
  }()
  
  let allAcceptButton: TouButton = {
    let button = TouButton(title: "전체 내용에 동의합니다.",
                           imageName: "checkmark.circle.fill",
                           textColor: .darkGray, fontSize: 17, style: .touStyle)
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/3*2
      button.titleEdgeInsets = .init(top: 0, left: leftInset-60, bottom: 0, right: 0)
    }
    button.isSelected = false
    return button
  }()
  
  let firstSquareView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderColor = UIColor.systemGray4.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  
  let firstLine: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  
  let secondSquareView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderColor = UIColor.systemGray4.cgColor
    view.layer.borderWidth = 1
    return view
  }()
  
  let secondLine: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  
  // First Square View
  let serviceAcceptButton: TouButton = {
    let button = TouButton(title: "서비스 이용약관 전체 동의",
                           imageName: "checkmark.circle.fill", textColor: .darkGray, fontSize: 15, style: .touStyle)
    button.addImportantMark()
    button.isSelected = false
    return button
  }()
  
  let socarTouAcceptButton: TouButton = {
    let button = TouButton(title: "(필수) 쏘카 이용약관", imageName: "checkmark",
                           textColor: .darkGray, fontSize: 15, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let personalInfoAcceptButton: TouButton = {
    let button = TouButton(title: "(필수) 개인정보 수집 및 이용 동의", imageName: "checkmark",
                           textColor: .darkGray, fontSize: 15, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let locationInfoAcceptButton: TouButton = {
    let button = TouButton(title: "(필수) 위치기반서비스 이용약관", imageName: "checkmark",
                           textColor: .darkGray, fontSize: 15, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  // Second Square View
  let marketingAcceptButton: TouButton = {
    let button = TouButton(title: "(선택) 할인쿠폰⋅이벤트등 마케팅 정보 수신 동의", imageName: "checkmark.circle.fill", textColor: .darkGray, fontSize: 15, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let infoLable: UILabel = {
    let label = UILabel()
    label.text = "모든 체널 수신 동의시 1시간 무표 쿠폰을 드려요"

    label.textColor = .darkGray
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  
  let pushAcceptButton: TouButton = {
    let button = TouButton(title: "Push",
                           imageName: "checkmark.circle.fill",
                           textColor: .darkGray,
                           fontSize: 16, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let smsAcceptButton: TouButton = {
    let button = TouButton(title: "SMS", imageName: "checkmark.circle.fill",
                           textColor: .darkGray, fontSize: 16, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let emailAcceptButton: TouButton = {
    let button = TouButton(title: "Email", imageName: "checkmark.circle.fill",
                           textColor: .darkGray, fontSize: 16, style: .touStyle)
    button.isSelected = false
    return button
  }()
  
  let lastInfoTextView: UITextView = {
    let textView = UITextView()
    textView.attributedText = NSAttributedString(
      string: """
      ⋅선택 항목에 동의하지 않아도 서비스 이용은 가능합니다.
      ⋅수신 거부 시 쿠폰 혜택 및 이벤트 안내를 받으실 수 없습니다.
      """,
      attributes: [
        NSAttributedString.Key.kern: 1
      ]
    )
    textView.font = .systemFont(ofSize: 13)
    textView.textColor = .darkGray
    textView.isUserInteractionEnabled = false
    textView.backgroundColor = .none
    return textView
  }()
  
  let continueSignUpButton = CompleteButton(frame: .zero, title: "가입 계속하기")
  
  let touShowButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let privacyShowButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let locationShowButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()

  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray6
    configureLayout()
    configureFirstSquareView()
    configureSecondSquareView()
    configureButtonView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    
    [allAcceptButton, firstSquareView, secondSquareView].forEach {
      addSubview($0)
    }
    
    let safe = safeAreaLayoutGuide
    allAcceptButton.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(safe)
      $0.height.equalTo(60)
    }
    
    firstSquareView.snp.makeConstraints {
      $0.top.equalTo(allAcceptButton.snp.bottom)
      $0.leading.equalTo(self).offset(padding)
      $0.trailing.equalTo(self).offset(-padding)
      $0.height.equalTo(180)
    }
    
    secondSquareView.snp.makeConstraints {
      $0.top.equalTo(firstSquareView.snp.bottom).offset(padding)
      $0.leading.equalTo(self).offset(padding)
      $0.trailing.equalTo(self).offset(-padding)
      $0.height.equalTo(140)
    }
  }
  
  private func configureFirstSquareView() {
    // First Square View
    [serviceAcceptButton, firstLine, socarTouAcceptButton, personalInfoAcceptButton, locationInfoAcceptButton, touShowButton, privacyShowButton, locationShowButton].forEach {
      firstSquareView.addSubview($0)
    }
    
    serviceAcceptButton.snp.makeConstraints {
      $0.top.equalTo(firstSquareView)
      $0.leading.equalTo(firstSquareView).offset(padding)
      $0.height.equalTo(50)
    }
    
    firstLine.snp.makeConstraints {
      $0.top.equalTo(serviceAcceptButton.snp.bottom)
      $0.leading.trailing.equalTo(firstSquareView)
      $0.height.equalTo(1)
    }
    
    socarTouAcceptButton.snp.makeConstraints {
      $0.top.equalTo(firstLine.snp.bottom)
      $0.leading.equalTo(firstSquareView).offset(padding)
      $0.height.equalTo(43)
    }
    
    touShowButton.snp.makeConstraints {
      $0.centerY.equalTo(socarTouAcceptButton.snp.centerY)
      $0.trailing.equalTo(firstSquareView.snp.trailing).offset(-15)
    }
    
    personalInfoAcceptButton.snp.makeConstraints {
      $0.top.equalTo(socarTouAcceptButton.snp.bottom)
      $0.leading.equalTo(firstSquareView).offset(padding)
      $0.height.equalTo(43)
    }
    
    privacyShowButton.snp.makeConstraints {
      $0.centerY.equalTo(personalInfoAcceptButton.snp.centerY)
      $0.trailing.equalTo(firstSquareView.snp.trailing).offset(-15)
    }
    
    locationInfoAcceptButton.snp.makeConstraints {
      $0.top.equalTo(personalInfoAcceptButton.snp.bottom)
      $0.leading.equalTo(firstSquareView).offset(padding)
      $0.bottom.equalTo(firstSquareView)
    }
    
    locationShowButton.snp.makeConstraints {
      $0.centerY.equalTo(locationInfoAcceptButton.snp.centerY)
      $0.trailing.equalTo(firstSquareView.snp.trailing).offset(-15)
    }
  }
  
  private func configureSecondSquareView() {
    // Second Square View 140
    [marketingAcceptButton, secondLine, infoLable, pushAcceptButton, smsAcceptButton, emailAcceptButton].forEach {
      secondSquareView.addSubview($0)
    }
    
    marketingAcceptButton.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(secondSquareView)
      $0.height.equalTo(50)
    }
    
    secondLine.snp.makeConstraints {
      $0.top.equalTo(marketingAcceptButton.snp.bottom)
      $0.leading.trailing.equalTo(secondSquareView)
      $0.height.equalTo(1)
    }
    
    infoLable.snp.makeConstraints {
      $0.top.equalTo(secondLine.snp.bottom)
      $0.leading.equalTo(secondSquareView).offset(10)
      $0.height.equalTo(40)
    }
    
    pushAcceptButton.snp.makeConstraints {
      $0.top.equalTo(infoLable.snp.bottom)
      $0.leading.equalTo(secondSquareView.snp.leading).offset(10)
      $0.height.equalTo(infoLable)
      $0.width.equalTo(70)
    }
    
    smsAcceptButton.snp.makeConstraints {
      $0.top.equalTo(infoLable.snp.bottom)
      $0.leading.equalTo(pushAcceptButton.snp.trailing).offset(10)
      $0.height.equalTo(infoLable)
      $0.width.equalTo(pushAcceptButton).multipliedBy(1)
    }
    
    emailAcceptButton.snp.makeConstraints {
      $0.top.equalTo(infoLable.snp.bottom)
      $0.leading.equalTo(smsAcceptButton.snp.trailing).offset(10)
      $0.height.equalTo(infoLable)
      $0.width.equalTo(smsAcceptButton).multipliedBy(1)
    }
  }
  
  private func configureButtonView() {
    [lastInfoTextView, continueSignUpButton].forEach {
      addSubview($0)
    }
    
    lastInfoTextView.snp.makeConstraints {
      $0.top.equalTo(secondSquareView.snp.bottom).offset(10)
      $0.leading.equalTo(secondSquareView.snp.leading)
      $0.trailing.equalTo(secondSquareView.snp.trailing)
      $0.height.equalTo(80)
    }
    
    continueSignUpButton.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(self)
      $0.height.equalTo(UIScreen.main.bounds.height*0.1)
    }
  }
}
