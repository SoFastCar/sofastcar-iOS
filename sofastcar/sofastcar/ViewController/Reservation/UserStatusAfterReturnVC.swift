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
    
    [floatingSurveyTitleLabel].forEach {
      floatingSurveyView.addSubview($0)
    }
    
    floatingSurveyTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.centerX.equalToSuperview()
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
