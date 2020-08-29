//
//  UserAuthScrollView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class UserAuthScrollView: UIScrollView {
  
  // MARK: - Properties
  let smallPadding: CGFloat = 10
  let padding: CGFloat = 15
  let sectionLabelHeight: CGFloat = 25
  let userInputMenusHeight: CGFloat = 50
  var barHeight: CGFloat?
  
  lazy var blurView: UIVisualEffectView = {
    let blurEffet = UIBlurEffect(style: .systemMaterialDark)
    let view = UIVisualEffectView(effect: blurEffet)
    view.alpha = 0
    return view
  }()
  
  var customerAgreeButtonArray: [UIButton] = []  // StackView buttonAction 연결을 위한 배열
  
  let essensialAgreeList: [String] = [
    "(필수) 개인정보 수집 및 이용 동의",
    "(필수) 고유식별정보 처리",
    "(필수) 서비스 이용약관",
    "(필수) 통신사 이용약관",
    "(필수) 개인정보 제3자 제공 동의"
  ]
  
  let sectionLabelText: [String] = ["이름", "주민등록번호 앞 7자리", "휴대폰 정보"]
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    view.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 0, right: 15)
    return view
  }()
  
  let stackViewContinerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    return view
  }()
  
  let customAuthAllAgreeButton: TouButton = {
    let button = TouButton(title: " 본인 확인 서비스 이용약관 전체 동의",
                           imageName: "checkmark.circle.fill", textColor: .black, fontSize: 15, style: .touStyle)
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/2
      button.titleEdgeInsets = .init(top: 0, left: leftInset+20, bottom: 0, right: 0)
    }
    button.isSelected = false
    return button
  }()
  
  let seperateLine: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray5
    return view
  }()
  
  lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: customerAgreeButtonArray)
    view.backgroundColor = .white
    view.distribution = .equalSpacing
    view.alignment = .leading
    view.axis = .vertical
    return view
  }()
  // ====== 이름 정보 =======
  let usernameLable = UILabel()
  
  let selectConturyButton: TouButton = {
    let button = TouButton(title: "내국인", imageName: "chevron.down", textColor: .black, fontSize: 16, style: .authStyle)
    button.isSelected = false
    return button
  }()
  
  let usernameTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "본인 실명 (통신사 가입 이름)"
    textField.keyboardType = .default
    textField.clearButtonMode = .whileEditing
    return textField
  }()
  
  // ====== 주민등록정보 정보 =======
  let userBirthLabel = UILabel()

  let userBirthTextField: UITextField = {
    let textField = UITextField()
    textField.attributedPlaceholder = NSAttributedString(
      string: "• • • • • •",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    textField.textColor = .black
    textField.keyboardType = .numberPad
    return textField
  }()
  
  let hiphenLabel: UILabel = {
    let label = UILabel()
    label.attributedText = NSAttributedString(
      string: " - ",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    label.textColor = .systemGray4
    return label
  }()
  
  let userSexTextField: UITextField = {
    let textField = UITextField()
    textField.attributedPlaceholder = NSAttributedString(
      string: "•",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    textField.textColor = .black
    textField.keyboardType = .numberPad
    return textField
  }()
  
  let userBithPrefixLabel: UILabel = {
    let label = UILabel()
    label.text = "*  *  *  *  *  *"
    label.font = .systemFont(ofSize: 20)
    label.textColor = .systemGray4
    return label
  }()
  
  // ====== 휴대폰 정보 =======
  let userPhoneNumberLabel = UILabel()
  
  let selectMobileCompany: TouButton = {
    let button = TouButton(title: "선택", imageName: "chevron.down", textColor: .systemGray4, fontSize: 16, style: .authStyle)
    button.isSelected = true
    return button
  }()
  
  let userPhoneNumberTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "01012341234"
    textField.keyboardType = .numberPad
    return textField
  }()
  
  let sendAuthenticationSMSButton: UIButton = {
    let button = UIButton()
    button.setTitle("인증번호 발송", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.007875645533, green: 0.7243045568, blue: 0.9998746514, alpha: 1), for: .normal)
    button.setTitle("인증번호 발송", for: .disabled)
    button.setTitleColor(.darkGray, for: .disabled)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.backgroundColor = .systemGray4
    return button
  }()
  
  let bottomInfoLabel: UITextView = {
    let textView = UITextView()
    textView.text = """
    ⋅ 본인 명의 휴대폰 번호만 인증이 가능힙니다.
    ⋅ 휴대폰 본인인증은 나이스평가정보(주)에서 제공하는
      서비스 입니다.
    """
    textView.font = .systemFont(ofSize: 15)
    textView.textColor = .darkGray
    textView.backgroundColor = .none
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  let authCompleteButton: UIButton = {
    let button = UIButton()
    button.setTitle("인증 완료", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 18)
    button.setTitleColor(.systemGray3, for: .disabled)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.007875645533, green: 0.7243045568, blue: 0.9998746514, alpha: 1) // .systemGray5
    button.isEnabled = true
    button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    button.contentVerticalAlignment = .top
    return button
  }()
  
  lazy var guide = contentView.layoutMarginsGuide
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureAgreeButtonStackView(buttonStrings: essensialAgreeList)
    
    configureDefaultUISetting()
    
    userAuthAgreeSquareUISetting()
    
    configureUserNameInputUI()
    
    configureUserBirthInputUI()
    
    configureUserPhoneInputUI()
    
    configureBottomLabelUISetting()
    
    settingAuthCompleteButton()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  // 본인 확인 서비스 이용약관 동의 버튼 자동 생성을 위한 함수
  private func configureAgreeButtonStackView(buttonStrings: [String]) {
    for index in buttonStrings.indices {
      let button = TouButton(title: buttonStrings[index], imageName: "checkmark",
                             textColor: .darkGray, fontSize: 15, style: .touStyle)
      
      button.isSelected = false
      customerAgreeButtonArray.append(button)
      stackView.addArrangedSubview(button)
    }
  }
  
  private func configureDefaultUISetting() {
    
    self.frame = CGRect(x: 0, y: 0,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height)
    self.backgroundColor = .systemGray6
    self.isScrollEnabled = true
    
    [contentView, blurView].forEach {
    self.addSubview($0)
    }
    
    blurView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    } else {
      heightPadding = 0
    }
    
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding)
    
    let sectionArray = [usernameLable, userBirthLabel, userPhoneNumberLabel]
    for index in sectionArray.indices {
      sectionArray[index].text = sectionLabelText[index]
      sectionArray[index].font = .systemFont(ofSize: 16)
      sectionArray[index].textColor = .black
    }
    
    [customAuthAllAgreeButton, stackViewContinerView, selectConturyButton, usernameTextField, userBirthTextField,
    selectMobileCompany, userPhoneNumberTextField, sendAuthenticationSMSButton].forEach {
      $0.layer.borderColor = UIColor.systemGray4.cgColor
      $0.layer.borderWidth = 1
      $0.backgroundColor = .white
    }
    
    [usernameTextField, userBirthTextField, userSexTextField, userPhoneNumberTextField].forEach {
      $0.autocorrectionType = .no
      $0.autocapitalizationType = .none
      $0.returnKeyType = .next
      $0.addLeftPadding()
    }
  }
  
  private func userAuthAgreeSquareUISetting() {
    [customAuthAllAgreeButton, stackViewContinerView].forEach {
      contentView.addSubview($0)
    }
    contentView.addSubview(stackView)
    
    customAuthAllAgreeButton.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(50)
    }
    
    stackViewContinerView.snp.makeConstraints {
      $0.top.equalTo(customAuthAllAgreeButton.snp.bottom).offset(-1)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(191)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.leading.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.bottom.equalTo(stackViewContinerView.layoutMarginsGuide)
    }
  }
  
  private func configureUserNameInputUI() {
    [usernameLable, selectConturyButton, usernameTextField].forEach {
      contentView.addSubview($0)
    }
    
    usernameLable.snp.makeConstraints {
      $0.top.equalTo(stackViewContinerView.snp.bottom).offset(padding*1.5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    selectConturyButton.snp.makeConstraints {
      $0.top.equalTo(usernameLable.snp.bottom).offset(smallPadding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    usernameTextField.snp.makeConstraints {
      $0.top.equalTo(usernameLable.snp.bottom).offset(smallPadding)
      $0.leading.equalTo(selectConturyButton.snp.trailing).offset(-1)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
      $0.width.equalTo(selectConturyButton.snp.width).multipliedBy(2.5)
    }
  }
  
  private func configureUserBirthInputUI() {
    [userBirthLabel, userBirthTextField, userSexTextField].forEach {
      contentView.addSubview($0)
    }
    
    userBirthLabel.snp.makeConstraints {
      $0.top.equalTo(usernameTextField.snp.bottom).offset(padding*1.5)
      $0.leading.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    userBirthTextField.snp.makeConstraints {
      $0.top.equalTo(userBirthLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    // user Birth TextField
    [hiphenLabel, userSexTextField, userBithPrefixLabel].forEach {
      userBirthTextField.addSubview($0)
    }
    
    userBithPrefixLabel.snp.makeConstraints {
      $0.centerY.equalTo(userBirthTextField.snp.centerY).offset(5)
      $0.trailing.equalTo(userBirthTextField.snp.trailing).offset(-padding)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    userSexTextField.snp.makeConstraints {
      $0.centerY.equalTo(userBirthTextField.snp.centerY)
      $0.trailing.equalTo(userBithPrefixLabel.snp.leading).offset(-padding)
    }
    
    hiphenLabel.snp.makeConstraints {
      $0.centerY.equalTo(userBirthTextField.snp.centerY)
      $0.trailing.equalTo(userSexTextField.snp.leading).offset(-padding/2)
    }
  }
  
  private func configureUserPhoneInputUI() {
    [userPhoneNumberLabel, selectMobileCompany, userPhoneNumberTextField, sendAuthenticationSMSButton].forEach {
      contentView.addSubview($0)
    }
    
    userPhoneNumberLabel.snp.makeConstraints {
      $0.top.equalTo(userBirthTextField.snp.bottom).offset(padding*1.5)
      $0.leading.equalTo(guide)
      $0.height.equalTo(sectionLabelHeight)
    }
    
    selectMobileCompany.snp.makeConstraints {
      $0.top.equalTo(userPhoneNumberLabel.snp.bottom).offset(5)
      $0.leading.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
    
    userPhoneNumberTextField.snp.makeConstraints {
      $0.top.equalTo(userPhoneNumberLabel.snp.bottom).offset(5)
      $0.leading.equalTo(selectMobileCompany.snp.trailing).offset(-1)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
      $0.width.equalTo(selectMobileCompany.snp.width).multipliedBy(2.5)
    }
    
    sendAuthenticationSMSButton.snp.makeConstraints {
      $0.top.equalTo(selectMobileCompany.snp.bottom).offset(-1)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputMenusHeight)
    }
  }
  
  private func configureBottomLabelUISetting() {
    [bottomInfoLabel].forEach {
      contentView.addSubview($0)
    }
    
    bottomInfoLabel.snp.makeConstraints {
      $0.top.equalTo(sendAuthenticationSMSButton.snp.bottom).offset(padding*2)
      $0.leading.trailing.equalTo(guide)
      $0.bottom.equalTo(contentView.snp.bottom).offset(20)
    }
  }
  
  private func settingAuthCompleteButton() {
    contentView.addSubview(authCompleteButton)
    authCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
