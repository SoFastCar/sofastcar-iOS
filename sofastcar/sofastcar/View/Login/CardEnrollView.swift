//
//  CardEnrollView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CardEnrollView: UIScrollView {
  // MARK: - Properties
  let sectionPadding: CGFloat = 25
  let labelPadding: CGFloat = 3
  let labelHeight: CGFloat = 25
  let userInputTextFieldHeight: CGFloat = 50
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    return view
  }()
  
  let stackViewContinerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.systemGray4.cgColor
    view.layoutMargins = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
    return view
  }()
  
  var customerAgreeButtonArray: [UIButton] = []  // StackView buttonAction 연결을 위한 배열
  
  lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: customerAgreeButtonArray)
    view.backgroundColor = .white
    view.distribution = .equalSpacing
    view.alignment = .leading
    view.axis = .vertical
    return view
  }()
  
  let customAuthAllAgreeButton: TouButton = {
    let button = TouButton(title: " (필수) 결제 서비스 이용약관 모두 동의",
                           imageName: "checkmark.circle.fill", textColor: .black, fontSize: 15, style: .touStyle)
    button.addImportantMark()
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/2
      button.titleEdgeInsets = .init(top: 0, left: leftInset+60, bottom: 0, right: 0)
    }
    button.backgroundColor = .white
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isSelected = false
    return button
  }()
  // topWarning Label
  let topWarningLabel: UILabel = {
    let label = UILabel()
    label.text = "본인 소유의 카드만 등록할 수 있습니다."
    label.backgroundColor = .systemGray5
    label.textColor = .darkGray
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 15)
    return label
  }()
  
  // 카드번호
  let cardNumberLable: UILabel = {
    let label = UILabel()
    label.text = " 카드 번호"
    return label
  }()
  
  let cardNumberTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.placeholder = "카드번호 입력"
    textfield.keyboardType = .numberPad
    textfield.clearButtonMode = .whileEditing
    return textfield
  }()
  
  let cardExpDateLabel: UILabel = {
    let label = UILabel()
    label.text = " 유효 기간"
    return label
  }()
  
  let cardExpDateMonthTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.placeholder = "MM"
    textfield.keyboardType = .numberPad
    return textfield
  }()
  
  let cardExpDatePrefixLable: UILabel = {
    let label = UILabel()
    label.text = "/"
    label.textColor = .systemGray5
    label.textAlignment = .right
    return label
  }()
  
  let cardExpDateYearTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.placeholder = "YY"
    textfield.layer.borderWidth = 0
    textfield.textAlignment = .left
    textfield.keyboardType = .numberPad
    return textfield
  }()
  //  password
  let cardPasswordLable: UILabel = {
    let label = UILabel()
    label.text = " 비밀번호 앞 2자리"
    return label
  }()
  
  let cardPasswordTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.attributedPlaceholder = NSAttributedString(
      string: "• •",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    textfield.keyboardType = .numberPad
    textfield.isSecureTextEntry = true
    return textfield
  }()
  
  let cardPasswordPrefixLable: UILabel = {
    let label = UILabel()
    label.text = " * * "
    label.font = .systemFont(ofSize: 30)
    label.textColor = .systemGray4
    return label
  }()
  // personNumber
  let personNumberLable: UILabel = {
    let label = UILabel()
    label.text = " 주민등록번호 앞 6자리"
    return label
  }()
  
  let personNumberTextfield: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.attributedPlaceholder = NSAttributedString(
      string: "• • • • • • ",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    textfield.keyboardType = .numberPad
    return textfield
  }()
  
  let personNumberMiddlePrefixLabel: UILabel = {
    let label = UILabel()
    label.attributedText = NSAttributedString(
      string: "-",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    label.font = .systemFont(ofSize: 20)
    label.textColor = .systemGray4
    return label
  }()
  
  let personNumberPrefixLabel: UILabel = {
    let label = UILabel()
    label.attributedText = NSAttributedString(
      string: " *  *  *  *  *  *  *",
      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    )
    label.font = .systemFont(ofSize: 20)
    label.textColor = .systemGray4
    return label
  }()
  
  let bottomInfoLabel: UITextView = {
    let textView = UITextView()
    textView.text = """
    ⋅ 결제카드 정보는 쏘카에서 위탁 운영하고 있는 수탁사를
      통해 안전하게 등록되며, 쏘카 시스템에는 저장되지 않습
      니다
    """
    textView.font = .systemFont(ofSize: 14)
    textView.textColor = .darkGray
    textView.backgroundColor = .none
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  let authCompleteButton = CompleteButton(frame: .zero, title: "인증 완료")
  
  lazy var guide = contentView.layoutMarginsGuide
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureScrollView()
    let string = [
      "(필수) 전자금융거래 이용약관",
      "(필수) 신용정보조회 제공",
      "(필수) 개인정보 수집 및 이용 동의"
    ]
    configureAgreeButtonStackView(buttonStrings: string)
    
    configureTopWarningLabelLayout()
    
    configureCardLabelLayout()
    
    configurePersonNumberLabelLayout()
    
    configureUserAuthAgreeSquareLayout()
    
    configureAuthCompleteButtonLayout()
    
    configureBottomInfoLabelSetting()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureScrollView() {
    showsVerticalScrollIndicator = false
    isScrollEnabled = true
    
    frame = CGRect(x: 0, y: 0,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height)
    backgroundColor = .systemGray6
    
    addSubview(contentView)
    
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding-44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding-144)
    contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
  }
  
  private func configureTopWarningLabelLayout() {
    contentView.addSubview(topWarningLabel)
    topWarningLabel.snp.makeConstraints {
      $0.top.equalTo(contentView.snp.top)
      $0.leading.trailing.equalTo(contentView)
      $0.height.equalTo(40)
    }
  }
  
  private func configureCardLabelLayout() {
    [cardNumberLable, cardNumberTextField, cardExpDateLabel, cardPasswordLable,
     cardExpDateLabel, cardPasswordTextField, cardPasswordPrefixLable,
     cardExpDateMonthTextField, cardExpDateYearTextField, cardExpDatePrefixLable].forEach {
      addSubview($0)
    }
    
    cardNumberLable.snp.makeConstraints {
      $0.top.equalTo(topWarningLabel.snp.bottom).offset(sectionPadding)
      $0.leading.trailing.equalTo(guide).offset(labelPadding)
      $0.height.equalTo(labelHeight)
    }
    
    cardNumberTextField.snp.makeConstraints {
      $0.top.equalTo(cardNumberLable.snp.bottom).offset(labelPadding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputTextFieldHeight)
    }
    
    cardExpDateLabel.snp.makeConstraints {
      $0.top.equalTo(cardNumberTextField.snp.bottom).offset(sectionPadding)
      $0.leading.equalTo(guide).offset(labelPadding)
      $0.height.equalTo(labelHeight)
    }
    
    cardPasswordLable.snp.makeConstraints {
      $0.top.equalTo(cardNumberTextField.snp.bottom).offset(sectionPadding)
      $0.leading.equalTo(contentView.snp.centerX).offset(labelPadding)
      $0.centerY.equalTo(cardExpDateLabel.snp.centerY)
      $0.height.equalTo(labelHeight)
    }
    
    cardExpDateMonthTextField.snp.makeConstraints {
      $0.top.equalTo(cardPasswordLable.snp.bottom).offset(labelPadding)
      $0.leading.equalTo(guide)
      $0.trailing.equalTo(contentView.snp.centerX).offset(-labelPadding) // 가운데 -5
      $0.height.equalTo(userInputTextFieldHeight)
    }
    
    cardExpDatePrefixLable.snp.makeConstraints {
      $0.centerY.equalTo(cardExpDateMonthTextField.snp.centerY)
      $0.leading.equalTo(cardExpDateMonthTextField.snp.leading).offset(60)
      $0.width.equalTo(20)
    }
    
    cardExpDateYearTextField.snp.makeConstraints {
      $0.centerY.equalTo(cardExpDateMonthTextField.snp.centerY)
      $0.leading.equalTo(cardExpDatePrefixLable.snp.trailing)
    }
    
    cardPasswordTextField.snp.makeConstraints {
      $0.centerY.equalTo(cardExpDateMonthTextField.snp.centerY)
      $0.leading.equalTo(contentView.snp.centerX).offset(labelPadding)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(userInputTextFieldHeight)
    }
    
    cardPasswordPrefixLable.snp.makeConstraints {
      $0.centerY.equalTo(cardExpDateMonthTextField.snp.centerY).offset(7)
      $0.leading.equalTo(cardPasswordTextField.snp.leading).offset(60)
    }
  }
  
  private func configurePersonNumberLabelLayout() {
    [personNumberLable, personNumberTextfield, personNumberMiddlePrefixLabel,
     personNumberPrefixLabel].forEach {
      addSubview($0)
    }
    
    personNumberLable.snp.makeConstraints {
      $0.top.equalTo(cardExpDateMonthTextField.snp.bottom).offset(sectionPadding)
      $0.leading.trailing.equalTo(guide)
    }
    
    personNumberTextfield.snp.makeConstraints {
      $0.top.equalTo(personNumberLable.snp.bottom).offset(labelPadding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(userInputTextFieldHeight)
    }
    
    personNumberPrefixLabel.snp.makeConstraints {
      $0.centerY.equalTo(personNumberTextfield.snp.centerY).offset(5)
      $0.trailing.equalTo(personNumberTextfield).offset(-20)
    }
    
    personNumberMiddlePrefixLabel.snp.makeConstraints {
      $0.centerY.equalTo(personNumberTextfield.snp.centerY)
      $0.centerX.equalTo(personNumberTextfield.snp.centerX)
    }
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
  
  private func configureUserAuthAgreeSquareLayout() {
    [customAuthAllAgreeButton, stackViewContinerView].forEach {
      contentView.addSubview($0)
    }
    contentView.addSubview(stackView)
    
    customAuthAllAgreeButton.snp.makeConstraints {
      $0.top.equalTo(personNumberTextfield.snp.bottom).offset(sectionPadding*1.5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(50)
    }
    
    stackViewContinerView.snp.makeConstraints {
      $0.top.equalTo(customAuthAllAgreeButton.snp.bottom).offset(-1)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(141)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.leading.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.bottom.equalTo(stackViewContinerView.layoutMarginsGuide)
    }
  }
  
  private func configureBottomInfoLabelSetting() {
    contentView.addSubview(bottomInfoLabel)
    bottomInfoLabel.snp.makeConstraints {
      $0.top.equalTo(stackViewContinerView.snp.bottom).offset(sectionPadding)
      $0.leading.trailing.equalTo(guide)
//      $0.height.equalTo(60)
      $0.bottom.equalTo(guide)
    }
  }
  
  private func configureAuthCompleteButtonLayout() {
    addSubview(authCompleteButton)
    authCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
}
