//
//  DefaultUserInfoView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class DefaultUserInfoView: UIScrollView {
  // MARK: - Properties
  var user: SignUpUserData? {
    didSet {
      guard let username = user?.username else { return }
      infomationLabel.text = "\(username) 님,\n쏘카 이용을 위한 기본 정보를 입력해주세요."
    }
  }
  let smallPadding: CGFloat = 10
  let padding: CGFloat = 15
  let sectionLabelHeight: CGFloat = 25
  let userInputMenusHeight: CGFloat = 50
  
  lazy var blurView: UIVisualEffectView = {
    let blurEffet = UIBlurEffect(style: .systemMaterialDark)
    let view = UIVisualEffectView(effect: blurEffet)
    view.alpha = 0
    return view
  }()

  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    return view
  }()
  
  let infomationLabel: UILabel = {
    let label = UILabel()
    label.text = "사용자 님,\n쏘카 이용을 위한 기본 정보를 입력해주세요."
    label.numberOfLines = 2
    label.textColor = .darkGray
    return label
  }()
  
  let userIdLabel: UILabel = {
    let label = UILabel()
    label.text = " 아이디"
    return label
  }()
  
  let userIdTextField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    textField.placeholder = "이메일 주소 입력"
    textField.keyboardType = .emailAddress
    textField.returnKeyType = .next
    return textField
  }()
  
  let userPasswordLabel: UILabel = {
    let label = UILabel()
    label.text = " 비밀번호"
    return label
  }()
  
  let userPasswordField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    textField.placeholder = "영문,숫자 포함 8자리 이상 입력"
    textField.isSecureTextEntry = true
    textField.returnKeyType = .next
    return textField
  }()

  let reUserPasswordLabel: UILabel = {
    let label = UILabel()
    label.text = " 비밀번호 확인"
    return label
  }()
  
  let reUserPasswordField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    textField.placeholder = "비밀번호 재입력"
    textField.isSecureTextEntry = true
    textField.returnKeyType = .default
    return textField
  }()

  let reCommendIdLabel: UILabel = {
    let label = UILabel()
    label.text = " (선택) 추천 코드"
    return label
  }()
  
  let reCommendIdField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    textField.placeholder = "프로모션코드 또는 추천인 ID(이메일)"
    textField.returnKeyType = .default
    textField.keyboardType = .emailAddress
    return textField
  }()
  
  let recommnedInfoTextView: UITextView = {
    let textView = UITextView()
    textView.text = """
    ⋅ 초대 코드를 입력하세요! 첫 드라이브를 마치면 추가
      혜택을 드립니다.
    """
    textView.font = .systemFont(ofSize: 15)
    textView.textColor = .darkGray
    textView.isUserInteractionEnabled = false
    textView.backgroundColor = .none
    return textView
  }()
  
  let inputCompleteButton: CompleteButton = {
    let button = CompleteButton(frame: .zero, title: "입력 완료")
    return button
  }()
  
  let userNameWaringLable: UILabel = {
    let label = UILabel()
    label.text = "아이디(이메일)를 확인해주세요"
    return label
  }()
  
  let userPasswordWaringLable: UILabel = {
    let label = UILabel()
    label.text = "패스워드를 확인해주세요"
    return label
  }()
  
  let userRePasswordWaringLable: UILabel = {
    let label = UILabel()
    label.text = "패스워드를 동일하게 입력해주세요"
    return label
  }()
  
  let recommendWaringLable: UILabel = {
    let label = UILabel()
    label.text = "추천인 아이디(이메일)를 확인해주세요"
    return label
  }()
  
  let userNameWaringImage = UIImageView(frame: .zero)
  let userPasswordWaringImage = UIImageView(frame: .zero)
  let userRePasswordWaringImage = UIImageView(frame: .zero)
  let recommendWaringImage = UIImageView(frame: .zero)

  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .systemGray6

    configureScrollView()
    
    configureLayout()
    
    settingInputCompleteButton()
    
    configureWarningLabelSetting()
    
    configureWarningImageSetting()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  private func configureScrollView() {
    showsVerticalScrollIndicator = false
    isScrollEnabled = true
    
    self.frame = CGRect(x: 0, y: 0,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height)
    self.backgroundColor = .systemGray6
    
    [contentView, blurView].forEach {
      self.addSubview($0)
    }
    
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = recommnedInfoTextView.frame.size.height
    } else {
      // 큰기기의 경우 화면전체가 보임으로 스크롤될 필요 없음
      self.isScrollEnabled = false
    }
    
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding)
    
    blurView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
  
  private func configureLayout() {
    let guide = contentView.layoutMarginsGuide
    contentView.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    
    [infomationLabel, userIdLabel, userIdTextField, userPasswordLabel, userPasswordField,
     reUserPasswordLabel, reUserPasswordField, reCommendIdLabel, reCommendIdField, recommnedInfoTextView].forEach {
      contentView.addSubview($0)
    }
    
    infomationLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.safeAreaLayoutGuide).offset(padding*2)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight) // 50
    }
    
    userIdLabel.snp.makeConstraints {
      $0.top.equalTo(infomationLabel.snp.bottom).offset(padding*2)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    userIdTextField.snp.makeConstraints {
      $0.top.equalTo(userIdLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    userPasswordLabel.snp.makeConstraints {
      $0.top.equalTo(userIdTextField.snp.bottom).offset(padding*1.5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    userPasswordField.snp.makeConstraints {
      $0.top.equalTo(userPasswordLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    reUserPasswordLabel.snp.makeConstraints {
      $0.top.equalTo(userPasswordField.snp.bottom).offset(padding*1.5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    reUserPasswordField.snp.makeConstraints {
      $0.top.equalTo(reUserPasswordLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    reCommendIdLabel.snp.makeConstraints {
      $0.top.equalTo(reUserPasswordField.snp.bottom).offset(padding*3)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    reCommendIdField.snp.makeConstraints {
      $0.top.equalTo(reCommendIdLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    recommnedInfoTextView.snp.makeConstraints {
      $0.top.equalTo(reCommendIdField.snp.bottom).offset(padding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
      $0.bottom.equalTo(contentView.snp.bottom)
    }
  }
  
  private func configureWarningLabelSetting() {
    [userNameWaringLable, userPasswordWaringLable, userRePasswordWaringLable, recommendWaringLable].forEach {
      contentView.addSubview($0)
      $0.isHidden = true
      $0.font = .systemFont(ofSize: 10)
      $0.textColor = .red
    }
    
    userNameWaringLable.snp.makeConstraints {
      $0.top.equalTo(userIdTextField.snp.bottom).offset(1)
      $0.leading.equalTo(userIdTextField).offset(1)
    }
    
    userPasswordWaringLable.snp.makeConstraints {
      $0.top.equalTo(userPasswordField.snp.bottom).offset(1)
      $0.leading.equalTo(userPasswordField).offset(1)
    }
    
    userRePasswordWaringLable.snp.makeConstraints {
      $0.top.equalTo(reUserPasswordField.snp.bottom).offset(1)
      $0.leading.equalTo(reUserPasswordField).offset(1)
    }
    
    recommendWaringLable.snp.makeConstraints {
      $0.top.equalTo(reCommendIdField.snp.bottom).offset(1)
      $0.leading.equalTo(reCommendIdField).offset(1)
    }
    
  }
  
  private func configureWarningImageSetting() {
    let warningImageSize: CGFloat = 20
    let warningImageOffset: CGFloat = -8
    [userNameWaringImage, userPasswordWaringImage, userRePasswordWaringImage, recommendWaringImage].forEach {
      contentView.addSubview($0)
      
      let warningImage = UIImage(systemName: "exclamationmark.triangle")!
      $0.image = warningImage
      $0.tintColor = .red
      $0.isHidden = true
    }
    
    userNameWaringImage.snp.makeConstraints {
      $0.centerY.equalTo(userIdTextField)
      $0.trailing.equalTo(userIdTextField).offset(warningImageOffset)
      $0.width.height.equalTo(warningImageSize)
    }
    userPasswordWaringImage.snp.makeConstraints {
      $0.centerY.equalTo(userPasswordField)
      $0.trailing.equalTo(userPasswordField).offset(warningImageOffset)
      $0.width.height.equalTo(warningImageSize)
    }
    userRePasswordWaringImage.snp.makeConstraints {
      $0.centerY.equalTo(reUserPasswordField)
      $0.trailing.equalTo(reUserPasswordField).offset(warningImageOffset)
      $0.width.height.equalTo(warningImageSize)
    }
    recommendWaringImage.snp.makeConstraints {
      $0.centerY.equalTo(reCommendIdField)
      $0.trailing.equalTo(reCommendIdField).offset(warningImageOffset)
      $0.width.height.equalTo(warningImageSize)
    }
  }
  
  private func settingInputCompleteButton() {
    addSubview(inputCompleteButton)
    inputCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(safeAreaLayoutGuide)
      $0.bottom.equalTo(safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
}
