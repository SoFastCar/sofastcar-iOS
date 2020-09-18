//
//  SingUpCompleteVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import UserNotifications

class SingUpCompleteVC: UIViewController {
  // MARK: - Properties
  var passBlurView: UIView!
  var passPushViewFunc: (() -> Void)?
  var user: SignUpUserData?
  
  let contentView = UIView()
  
  let imageLabel: UILabel = {
    let label = UILabel()
    label.text = "🎉"
    label.font = .systemFont(ofSize: 70)
    return label
  }()
  
  let welcomTitleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 20)
    label.text = "쏘카 가입을 환영합니다!"
    return label
  }()
  
  let welcomContentsLabel: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 18)
    textView.text = "서비스 시용을 위해 결제 및 운전면허증 정보 등록이 필요합니다."
    return textView
  }()
  
  lazy var okButton: UIButton = {
    let button = UIButton()
    button.setTitle("확인", for: .normal)
    button.setTitleColor(CommonUI.mainBlue, for: .normal)
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(tabOkButton), for: .touchUpInside)
    return button
  }()
  
  let sepView: UIView = {
    let view = UIView()
    view.backgroundColor = .gray
    return view
  }()
  
  lazy var marketingAgreeTextView: UITextView = {
    let textView = UITextView()
    let text = """
    (주)쏘카
    회원님이 \(Date())에 요청하신 마케팅 정보 수신동의는 ~~~~ 처리 되었습니다.
    """
    let font = UIFont.systemFont(ofSize: 13)
    textView.attributedText = NSAttributedString.attributedStringWithLienSpacing(text: text, font: font)
    return textView
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .none
    configureNavigationController()
    configureContentView()
    configureLayout()
    configureNotification()
  }
  
  private func configureNavigationController() {
     self.navigationController?.navigationBar.topItem?.title = ""
   }
  
  private func configureContentView() {
    contentView.backgroundColor = .white
    view.addSubview(contentView)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    contentView.frame = CGRect(x: 0,
                        y: UIScreen.main.bounds.height/2,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height/2)
  }
  
  private func configureLayout() {
    [imageLabel, welcomTitleLabel, welcomContentsLabel, sepView, marketingAgreeTextView, okButton].forEach {
      contentView.addSubview($0)
    }
    
    let guide = contentView.layoutMarginsGuide
    imageLabel.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
    }
    
    welcomTitleLabel.snp.makeConstraints {
      $0.top.equalTo(imageLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
    }
    
    welcomContentsLabel.snp.makeConstraints {
      $0.top.equalTo(welcomTitleLabel).offset(5)
      $0.leading.trailing.equalTo(guide)
    }
    
    sepView.snp.makeConstraints {
      $0.top.equalTo(welcomContentsLabel.snp.top).offset(10)
      $0.leading.equalTo(guide)
      $0.width.equalTo(20)
      $0.height.equalTo(2)
    }
    
    marketingAgreeTextView.snp.makeConstraints {
      $0.top.equalTo(sepView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(110)
    }
    
    okButton.snp.makeConstraints {
      $0.top.equalTo(marketingAgreeTextView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(50)
    }
  }
  
  private func configureNotification() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
          print("error", error.localizedDescription)
          return
        }
        // Enable or disable features based on the authorization.
      print(granted)
    }
  }
  
  // MARK: - Handler
  @objc private func tabOkButton() {
    UIView.animate(withDuration: 0.5) {
      self.passBlurView.alpha = 0
    }
    self.dismiss(animated: true) {
      self.passPushViewFunc!()
    }
    
  }
}
