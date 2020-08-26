//
//  TouVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class TouVC: UIViewController {
  // MARK: - Properties
  let touView = TouView()

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    touView.frame = self.view.frame
    
    configureButtonAction()
  }
  
  override func loadView() {
    view = touView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    title = "약관 동의"
  }

  private func configureButtonAction() {
    touView.allAcceptButton.addTarget(self, action: #selector(tabAllAcceptButton(_:)), for: .touchUpInside)
    touView.serviceAcceptButton.addTarget(self, action: #selector(tabServiceAcceptButton(_:)), for: .touchUpInside)
    touView.socarTouAcceptButton.addTarget(self, action: #selector(tabServiceAcceptButton(_:)), for: .touchUpInside)
    touView.personalInfoAcceptButton.addTarget(self, action: #selector(tabServiceAcceptButton(_:)), for: .touchUpInside)
    touView.locationInfoAcceptButton.addTarget(self, action: #selector(tabServiceAcceptButton(_:)), for: .touchUpInside)
    touView.marketingAcceptButton.addTarget(self, action: #selector(tabMarketingButton(_:)), for: .touchUpInside)
    touView.pushAcceptButton.addTarget(self, action: #selector(tabMarketingButton(_:)), for: .touchUpInside)
    touView.emailAcceptButton.addTarget(self, action: #selector(tabMarketingButton(_:)), for: .touchUpInside)
    touView.continueSignUpButton.addTarget(self, action: #selector(singupContinueButtonTap), for: .touchUpInside)
  }
  
  // MARK: - Handler
  @objc private func tabAllAcceptButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    [touView.serviceAcceptButton, touView.socarTouAcceptButton, touView.personalInfoAcceptButton,
     touView.locationInfoAcceptButton, touView.marketingAcceptButton, touView.pushAcceptButton, touView.smsAcceptButton, touView.emailAcceptButton].forEach {
      $0.isSelected = sender.isSelected
    }
    checkEnableSignUpContinueButton() // 가입 계속하기 버튼 활성화 체크
  }
  
  @objc private func tabServiceAcceptButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender == touView.serviceAcceptButton {
      touView.socarTouAcceptButton.isSelected = sender.isSelected
      touView.personalInfoAcceptButton.isSelected = sender.isSelected
      touView.locationInfoAcceptButton.isSelected = sender.isSelected
      checkAllAccept() // 3개 버튼 눌렸을 시 서비스 이용약관 전체 동의 활성화
    } else {
      if touView.socarTouAcceptButton.isSelected == false ||
        touView.personalInfoAcceptButton.isSelected == false ||
        touView.locationInfoAcceptButton.isSelected == false {
        touView.serviceAcceptButton.isSelected = false
      } else {
        touView.serviceAcceptButton.isSelected = true
      }
    }
    checkEnableSignUpContinueButton() // 가입 계속하기 버튼 활성화 체크
  }
  
  @objc private func tabMarketingButton(_ sender: UIButton) {
    sender.isSelected.toggle()
    if sender == touView.marketingAcceptButton {
      touView.pushAcceptButton.isSelected = sender.isSelected
      touView.smsAcceptButton.isSelected = sender.isSelected
      touView.emailAcceptButton.isSelected = sender.isSelected
      checkAllAccept()
    } else {
      touView.marketingAcceptButton.isSelected = sender.isSelected ? true : false
    }
    
    [touView.pushAcceptButton, touView.smsAcceptButton, touView.emailAcceptButton].forEach {
      if $0.isSelected == true {
        touView.marketingAcceptButton.isSelected = true
      }
    }
  }
  
  @objc private func singupContinueButtonTap() {
    print("Tab Button")
  }
  
  private func checkAllAccept() {
    if touView.serviceAcceptButton.isSelected == true &&
      touView.marketingAcceptButton.isSelected == true {
      touView.allAcceptButton.isSelected = true
    } else {
      touView.allAcceptButton.isSelected = false
    }
  }
  
  private func checkEnableSignUpContinueButton() {
    let trigger = touView.serviceAcceptButton.isSelected
    touView.continueSignUpButton.isEnabled = trigger
    touView.continueSignUpButton.backgroundColor = trigger ? #colorLiteral(red: 0.00789394509, green: 0.7206848264, blue: 0.9998746514, alpha: 1) : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
  }
}
