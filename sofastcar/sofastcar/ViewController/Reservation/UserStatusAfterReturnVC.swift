//
//  UserStatusAfterReturnVC.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class UserStatusAfterReturnVC: UIViewController {
  
  fileprivate let userStatusAfterReturnView = UserStatusAfterReturnView()
  
  fileprivate let floatingSurveyView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.cornerRadius = 5
    view.shadowMaker(view: view)
    
    return view
  }()
  
  fileprivate let floatingSurveyTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "🚙  만족스러운 드라이브였나요?"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
    label.textColor = CommonUI.mainBlue
    label.textAlignment = .center
    
    return label
  }()
  
  fileprivate let goodButton: UIButton = {
    let button = UIButton()
    button.setTitle("좋아요", for: .normal)
    button.setTitleColor(CommonUI.mainDark.withAlphaComponent(0.5), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
    button.layer.borderWidth = 1
    button.layer.borderColor = CommonUI.mainDark.withAlphaComponent(0.2).cgColor
    button.addTarget(self, action: #selector(didTapFeedbackButton(_:)), for: .touchUpInside)
    button.snp.makeConstraints {
      $0.width.equalTo(120)
    }
    
    return button
  }()
  
  fileprivate let notGoodButton: UIButton = {
    let button = UIButton()
    button.setTitle("별로에요", for: .normal)
    button.setTitleColor(CommonUI.mainDark.withAlphaComponent(0.5), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline).bold()
    button.layer.borderWidth = 1
    button.layer.borderColor = CommonUI.mainDark.withAlphaComponent(0.2).cgColor
    button.addTarget(self, action: #selector(didTapFeedbackButton(_:)), for: .touchUpInside)
    button.snp.makeConstraints {
      $0.width.equalTo(120)
    }
    
    return button
  }()
  
  fileprivate lazy var buttonStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [goodButton, notGoodButton])
    stackView.axis = .horizontal
    stackView.spacing = 20
    
    return stackView
  }()
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    let guid = view.safeAreaLayoutGuide
    userStatusAfterReturnView.delegate = self
    navigationController?.isNavigationBarHidden = true
    view.backgroundColor = .white
    
    [userStatusAfterReturnView, floatingSurveyView].forEach {
      view.addSubview($0)
    }
    
    userStatusAfterReturnView.snp.makeConstraints {
      $0.edges.equalTo(guid)
    }
    
    floatingSurveyView.frame = CGRect(
      x: 20,
      y: UIScreen.main.bounds.maxY - 140,
      width: UIScreen.main.bounds.width - 40,
      height: 140
    )
    
    floatingSurvey()
  }
  
  fileprivate func floatingSurvey() {
    
    [floatingSurveyTitleLabel, buttonStackView].forEach {
      floatingSurveyView.addSubview($0)
    }
    
    floatingSurveyTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.centerX.equalToSuperview()
    }
    
    buttonStackView.snp.makeConstraints {
      $0.top.equalTo(floatingSurveyTitleLabel.snp.bottom).offset(20)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(40)
    }
  }
  
  // MARK: - Action
  
  @objc func didTapFeedbackButton(_ sender: UIButton) {
    switch sender {
    case goodButton:
      print("goodButton")
    case notGoodButton:
      print("notGoodButton")
    default:
      break
    }
  }
}

// MARK: - UserStatusAfterReturnViewDelegate

extension UserStatusAfterReturnVC: UserStatusAfterReturnViewDelegate {
  func didTapButton(_ sender: UIButton) {
    print("didTapButton")
    switch sender {
    case userStatusAfterReturnView.closeButton:
      dismiss(animated: false, completion: nil)
    case userStatusAfterReturnView.detailUsageHistory:
      print("detailUsageHistory")
    default:
      break
    }
  }
}
