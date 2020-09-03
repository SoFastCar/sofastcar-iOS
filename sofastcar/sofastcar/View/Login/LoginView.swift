//
//  LoginView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class LoginView: UIView {
  // MARK: - Properties
  let backButton: UIButton = {
    let button = UIButton()
    let attributeImage = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
    let leftChevronImage = UIImage(systemName: "arrow.left", withConfiguration: attributeImage)
    button.setImage(leftChevronImage, for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "로그인"
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = .darkGray
    return label
  }()
  
  let emailTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.placeholder = "가입한 이메일 주소 입력"
    textfield.keyboardType = .emailAddress
    textfield.returnKeyType = .next
    textfield.clearButtonMode = .whileEditing
    textfield.clearsOnBeginEditing = false
    return textfield
  }()
  
  let passwordTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.placeholder = "비밀번호 입력"
    textfield.isSecureTextEntry = true
    textfield.returnKeyType = .done
    textfield.clearButtonMode = .whileEditing
    textfield.clearsOnBeginEditing = false
    return textfield
  }()
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그인하기", for: .normal)
    button.setTitleColor(.white, for: .normal)
    
    button.setTitle("로그인하기", for: .disabled)
    button.setTitleColor(.systemGray3, for: .disabled)
    button.backgroundColor = .systemGray4
    return button
  }()
  
  let orLabel: UILabel = {
    let label = UILabel()
    label.text = "- 또는 -"
    label.textColor = .systemGray3
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  
  let appleLoginButton: UIButton = {
    let button = UIButton()
    button.setTitle(" Apple로 로그인", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.backgroundColor = .black
    return button
  }()
  
  let idPasswordFindButton: UIButton = {
    let button = UIButton()
    button.setTitle("가입정보 찾기", for: .normal)
    button.setTitleColor(.darkGray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    return button
  }()
  
  let lineView = UIView()
  
  let kakaoButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "kakaoLogo"), for: .normal)
    return button
  }()
  
  let facebookButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "facebookLogo"), for: .normal)
    return button
  }()
  
  let naverButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "naverLogo"), for: .normal)
    return button
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    
    configureBackButtonUI()
    
    configureLayout()
    
    configureSocialLoginButtons()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  private func configureBackButtonUI() {
     addSubview(backButton)
     backButton.snp.makeConstraints {
       $0.top.equalTo(layoutMargins).offset(50)
       $0.leading.equalTo(layoutMargins).offset(10)
     }
   }
  
  private func configureLayout() {
    let guide = layoutMargins
    [titleLabel, emailTextField, passwordTextField, loginButton, orLabel,
     appleLoginButton, idPasswordFindButton, lineView].forEach {
      addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(30)
      $0.leading.equalTo(guide)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight*1.1)
    }
    
    passwordTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight*1.1)
    }
    
    loginButton.snp.makeConstraints {
      $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight*1.1)
    }
    
    orLabel.snp.makeConstraints {
      $0.top.equalTo(loginButton.snp.bottom).offset(CommonUI.sectionLabelPadding/2)
      $0.centerX.equalTo(snp.centerX)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    appleLoginButton.snp.makeConstraints {
      $0.top.equalTo(orLabel.snp.bottom).offset(CommonUI.sectionLabelPadding/2)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight*1.1)
    }
    
    idPasswordFindButton.snp.makeConstraints {
      $0.top.equalTo(appleLoginButton.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.centerX.equalTo(snp.centerX)
    }
    
    lineView.backgroundColor = .darkGray
    lineView.snp.makeConstraints {
      $0.top.equalTo(idPasswordFindButton.snp.bottom)
      $0.leading.trailing.equalTo(idPasswordFindButton)
      $0.height.equalTo(1)
    }
  }
  
  private func configureSocialLoginButtons() {
    [kakaoButton, facebookButton, naverButton].forEach {
      addSubview($0)
    }
    
    facebookButton.snp.makeConstraints {
      $0.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
      $0.centerX.equalTo(self.snp.centerX)
      $0.width.height.equalTo(40)
    }
    
    kakaoButton.snp.makeConstraints {
      $0.centerY.equalTo(facebookButton.snp.centerY)
      $0.trailing.equalTo(facebookButton.snp.leading).offset(-20)
      $0.width.height.equalTo(40)
    }
    
    naverButton.snp.makeConstraints {
      $0.centerY.equalTo(facebookButton.snp.centerY)
      $0.leading.equalTo(facebookButton.snp.trailing).offset(20)
      $0.width.height.equalTo(40)
    }
  }
}
