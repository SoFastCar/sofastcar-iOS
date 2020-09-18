//
//  CheckDriverLicenseView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CheckDriverLicenseView: UIScrollView {
  // MARK: - Properties
  let smallPadding: CGFloat = 10
  let padding: CGFloat = 15
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 0, right: 15)
    return view
  }()
  
  let driverLicenseGradeLabel: UILabel = {
    let label = UILabel()
    label.text = "면허종류"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  let selectDriverLicenseGradeButton: TouButton = {
    let button = TouButton(title: "1종 보통", imageName: "chevron.down", textColor: .black, fontSize: 16, style: .authStyle)
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/3*2
      button.titleEdgeInsets = .init(top: 0, left: leftInset-20, bottom: 0, right: 0)
    }
    button.isSelected = true
    button.titleLabel?.textAlignment = .left
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    return button
  }()
  
  // ====== 면허 정보 =======
  let driverLicenseNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "면허 번호"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  let selectDriverLicenseNumber: TouButton = {
    let button = TouButton(title: "11", imageName: "chevron.down", textColor: .black, fontSize: 16, style: .authStyle)
    button.isSelected = true
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    return button
  }()
  
  let driverLicenseNumberTextField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    textField.text = " 12 - 636572 - 56"
    textField.keyboardType = .numberPad
    return textField
  }()
  
  // ====== 주민등록정보 정보 =======
  let userBirthLabel: UILabel = {
    let label = UILabel()
    label.text = "주민등록번호 앞 7자리"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    return label
  }()
  
  let userBirthTextField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    //    textField.attributedPlaceholder = NSAttributedString(
    //      string: "• • • • • •",
    //      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    //    )
    textField.text = "921030"
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
  
  let userSexTextField: LoginUserInputTextField = {
    let textField = LoginUserInputTextField()
    //    textField.attributedPlaceholder = NSAttributedString(
    //      string: "1",
    //      attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
    //    )
    textField.text = "1"
    textField.textColor = .black
    textField.layer.borderWidth = 0
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
  
  // == 적성 검사 만료인
  let cardExpDateLabel: UILabel = {
    let label = UILabel()
    label.text = "적성검사 만료일"
    return label
  }()
  
  let cardExpDateMonthTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.text = "2029 / 10 / 7"
    textfield.keyboardType = .numberPad
    return textfield
  }()
  
  //  password
  let cardPasswordLable: UILabel = {
    let label = UILabel()
    label.text = "발급일"
    return label
  }()
  
  let cardPasswordTextField: LoginUserInputTextField = {
    let textfield = LoginUserInputTextField()
    textfield.text = "2019 / 10 / 7"
    textfield.keyboardType = .numberPad
    return textfield
  }()
  
  let customAuthAllAgreeButton: TouButton = {
    let button = TouButton(title: " 본인 확인 서비스 이용약관 전체 동의",
                           imageName: "checkmark.circle.fill", textColor: .black, fontSize: 15, style: .touStyle)
    button.addImportantMark()
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/2
      button.titleEdgeInsets = .init(top: 0, left: leftInset+40, bottom: 0, right: 0)
    }
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isSelected = false
    return button
  }()
  
  let bottomInfoLabel: UITextView = {
    let textView = UITextView()
    textView.text = """
    ⋅ 운전면허 취득 후 만 1년 이상 경과하여야 승인이 가능합니다.
    ⋅ 입력된 운전면허증 정보 외 주소 부분을 별도 수집합니다.
    """
    textView.font = .systemFont(ofSize: 14)
    textView.textColor = .darkGray
    textView.backgroundColor = .none
    textView.isUserInteractionEnabled = false
    return textView
  }()
  
  let driverAuthCompleteButton: CompleteButton = {
    let button = CompleteButton(frame: .zero, title: "운전면허 등록 완료")
    button.isEnabled = true
    return button
  }()
  
  lazy var guide = contentView.layoutMarginsGuide
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureDefaultUISetting()
    
    configureDriverGradSelectUI()
    
    confgireDriverLicenseNumberUI()
    
    configureUserBirthInputUI()
    
    configureCardLabelUI()
    
    configurePersonalImfomationAgreeUI()
    
    configureBottomInfoUI()
    
    settingAuthCompleteButtonUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.endEditing(true)
  }
  
  private func configureDefaultUISetting() {
    showsVerticalScrollIndicator = false
    isScrollEnabled = true
    
    self.frame = CGRect(x: 0, y: 0,
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height)
    self.backgroundColor = .systemGray6
    self.addSubview(contentView)
    
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = bottomInfoLabel.frame.size.height
    } else {
      // 큰기기의 경우 화면전체가 보임으로 스크롤될 필요 없음
      self.isScrollEnabled = false
    }
    
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 30, right: 20)
  }
  
  private func configureDriverGradSelectUI() {
    [driverLicenseGradeLabel, selectDriverLicenseGradeButton].forEach {
      contentView.addSubview($0)
    }
    
    driverLicenseGradeLabel.snp.makeConstraints {
      $0.top.equalTo(guide).offset(CommonUI.sectionLabelPadding)
      $0.leading.equalTo(guide).offset(10)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    selectDriverLicenseGradeButton.snp.makeConstraints {
      $0.top.equalTo(driverLicenseGradeLabel.snp.bottom).offset(CommonUI.sectionMiddlePadding)
      $0.leading.equalTo(guide)
      $0.trailing.equalTo(contentView.snp.centerX)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
  }
  
  private func confgireDriverLicenseNumberUI() {
    [driverLicenseNumberLabel, selectDriverLicenseNumber, driverLicenseNumberTextField].forEach {
      contentView.addSubview($0)
    }
    
    driverLicenseNumberLabel.snp.makeConstraints {
      $0.top.equalTo(selectDriverLicenseGradeButton.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.trailing.equalTo(guide).offset(10)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    selectDriverLicenseNumber.snp.makeConstraints {
      $0.top.equalTo(driverLicenseNumberLabel.snp.bottom).offset(CommonUI.sectionMiddlePadding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
    
    driverLicenseNumberTextField.snp.makeConstraints {
      $0.top.equalTo(driverLicenseNumberLabel.snp.bottom).offset(CommonUI.sectionMiddlePadding)
      $0.leading.equalTo(selectDriverLicenseNumber.snp.trailing).offset(-1)
      $0.trailing.equalTo(guide)
      $0.width.equalTo(selectDriverLicenseNumber.snp.width).multipliedBy(2)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
  }
  
  private func configureUserBirthInputUI() {
    [userBirthLabel, userBirthTextField, userSexTextField].forEach {
      contentView.addSubview($0)
    }
    
    userBirthLabel.snp.makeConstraints {
      $0.top.equalTo(driverLicenseNumberTextField.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.equalTo(guide).offset(10)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    userBirthTextField.snp.makeConstraints {
      $0.top.equalTo(userBirthLabel.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
    // user Birth TextField
    [hiphenLabel, userSexTextField, userBithPrefixLabel].forEach {
      userBirthTextField.addSubview($0)
    }
    
    userBithPrefixLabel.snp.makeConstraints {
      $0.centerY.equalTo(userBirthTextField.snp.centerY).offset(5)
      $0.trailing.equalTo(userBirthTextField.snp.trailing).offset(-padding)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
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
  
  private func configureCardLabelUI() {
    [cardExpDateLabel, cardPasswordLable, cardExpDateLabel, cardPasswordTextField,
     cardExpDateMonthTextField].forEach {
      contentView.addSubview($0)
    }
    
    cardExpDateLabel.snp.makeConstraints {
      $0.top.equalTo(userBirthTextField.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.equalTo(guide).offset(5)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    cardPasswordLable.snp.makeConstraints {
      $0.top.equalTo(userBirthTextField.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.equalTo(contentView.snp.centerX).offset(5)
      $0.centerY.equalTo(cardExpDateLabel.snp.centerY)
      $0.height.equalTo(CommonUI.sectionLabelHeight)
    }
    
    cardExpDateMonthTextField.snp.makeConstraints {
      $0.top.equalTo(cardPasswordLable.snp.bottom).offset(5)
      $0.leading.equalTo(guide)
      $0.trailing.equalTo(contentView.snp.centerX).offset(-5) // 가운데 -5
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
    
    cardPasswordTextField.snp.makeConstraints {
      $0.centerY.equalTo(cardExpDateMonthTextField.snp.centerY)
      $0.leading.equalTo(contentView.snp.centerX).offset(5)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
  }
  
  private func configurePersonalImfomationAgreeUI() {
    contentView.addSubview(customAuthAllAgreeButton)
    customAuthAllAgreeButton.snp.makeConstraints {
      $0.top.equalTo(cardPasswordTextField.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(CommonUI.userInputMenusHeight)
    }
  }
  
  private func configureBottomInfoUI() {
    contentView.addSubview(bottomInfoLabel)
    bottomInfoLabel.snp.makeConstraints {
      $0.top.equalTo(customAuthAllAgreeButton.snp.bottom).offset(CommonUI.sectionLabelPadding)
      $0.leading.trailing.equalTo(guide)
      $0.bottom.equalTo(guide)
    }
  }
  
  private func settingAuthCompleteButtonUI() {
    addSubview(driverAuthCompleteButton)
    driverAuthCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
  
}
