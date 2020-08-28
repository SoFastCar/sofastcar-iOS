//
//  TouVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import WebKit

class TouVC: UIViewController {
  // MARK: - Properties
  let touView = TouView()
  
  let user = User()

  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "약관 동의"
    
    touView.frame = self.view.frame
    
    configureButtonAction()
  }
  
  override func loadView() {
    view = touView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let navi = navigationController {
      navi.navigationBar.isHidden = false
      navi.navigationBar.tintColor = .black
    }
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
    touView.smsAcceptButton.addTarget(self, action: #selector(tabMarketingButton(_:)), for: .touchUpInside)
    touView.continueSignUpButton.addTarget(self, action: #selector(singupContinueButtonTap), for: .touchUpInside)
    touView.touShowButton.addTarget(self, action: #selector(tabShowTouButton(_:)), for: .touchUpInside)
    touView.privacyShowButton.addTarget(self, action: #selector(tabShowTouButton(_:)), for: .touchUpInside)
    touView.locationShowButton.addTarget(self, action: #selector(tabShowTouButton(_:)), for: .touchUpInside)
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
  
  @objc private func tabShowTouButton(_ sender: UIButton) {
    var urlString: String = ""
    
    urlString = sender == touView.touShowButton ? "https://socar-docs.zendesk.com/hc/ko/articles/360048397194" :
      sender == touView.privacyShowButton ?
        "https://socar-docs.zendesk.com/hc/ko/articles/360048398254" :
        "https://socar-docs.zendesk.com/hc/ko/articles/360049150593"
    /*
     이용약관 : https://socar-docs.zendesk.com/hc/ko/articles/360048397194
     개인정보 : https://socar-docs.zendesk.com/hc/ko/articles/360048398254
     위치정보 : https://socar-docs.zendesk.com/hc/ko/articles/360049150593
     */
    guard let url = URL(string: urlString) else { return print("Error") }
    let request = URLRequest(url: url)
    touView.webView.load(request)
    touView.webView.frame = CGRect(x: 0, y: 0, width: touView.frame.width, height: touView.frame.height)
    touView.addSubview(touView.webView)
  }
  
  @objc private func tabWebViewColseButton() {
    print("Aaaa")
    touView.willRemoveSubview(touView.webView)
//    touView.addSubview(touView)
  }
  
  @objc private func singupContinueButtonTap() {
    let userAuthVC = UserAuthVC()
    user.smsMarketing = touView.smsAcceptButton.isSelected
    user.emailMarketing = touView.emailAcceptButton.isSelected
    user.pushMarketing = touView.pushAcceptButton.isSelected
    
    userAuthVC.user = self.user
    navigationController?.pushViewController(userAuthVC, animated: true)
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
