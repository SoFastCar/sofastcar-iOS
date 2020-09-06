//
//  UserAuthVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire

class UserAuthVC: UIViewController {
  
  // MARK: - Properties
  var user: SignUpUserData?
  let scrollView = UserAuthScrollView()
  var isKeyboardUp: Bool = false
  var isUserAgreeWithAlltou: Bool = false
  
  var phoneAuthResponse: PhoneAuthResponse?
  
  enum AuthError: String {
    case bithDayInputError = "생년월일을 확인해주세요"
    case smsAuthCodeError = "입력된 인증번호 6자리를 확인해주세요"
    case serverSideError = "잠시 후 다시 요청해주시기 바랍니다"
    case phoneNumberInputError = "휴대전화 번호를 확인해주세요"
  }
  
  enum ValidtionType: String {
    case bithDay = "([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))"
    case phoneNumber = "^01(?:0|1|[6-9])[.-]?(\\d{3}|\\d{4})[.-]?(\\d{4})$"
  }

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    scrollView.delegate = self
    configureNavigationBar()
    configureButtonAction()
  }
  
  override func loadView() {
    view = scrollView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    //keyboard 입력에 따른 화면 올리는 Notification 설정
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    
    //keyboard 입력에 따른 화면 올리는 Notification 설정 해제
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func configureNavigationBar() {
    title = "휴대폰 인증"
    self.navigationController?.navigationBar.topItem?.title = ""
    self.navigationController?.navigationBar.addSubview(self.scrollView.blurView)
    self.navigationController?.navigationBar.sendSubviewToBack(self.scrollView.blurView)
  }
  
  private func configureButtonAction() {
    // textField 변경 사항 체크
    [scrollView.userSexTextField, scrollView.userBirthTextField, scrollView.userSexTextField, scrollView.userPhoneNumberTextField, scrollView.usernameTextField, scrollView.phoneAuthNumberInputTextField].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
    
    // StackView내 동의 버튼 action 및 초기값
    scrollView.customerAgreeButtonArray.forEach {
      $0.addTarget(self, action: #selector(tabUserAgreeButton(_:)), for: .touchUpInside)
      $0.isSelected = false
    }
    scrollView.customAuthAllAgreeButton.addTarget(self, action: #selector(tabUserAgreeButton(_:)), for: .touchUpInside)
    scrollView.customAuthAllAgreeButton.isSelected = false
    
    scrollView.selectConturyButton.addTarget(self, action: #selector(tabSelectPopupMenuButtons(_:)), for: .touchUpInside)
    scrollView.selectMobileCompany.addTarget(self, action: #selector(tabSelectPopupMenuButtons(_:)), for: .touchUpInside)
    scrollView.sendAuthenticationSMSButton.addTarget(self, action: #selector(tapSendAuthSMSButton(_:)), for: .touchUpInside)
    scrollView.authCompleteButton.addTarget(self, action: #selector(tapAuthCompleteButton), for: .touchUpInside)
  }
  
  // MARK: - Button Handler
  @objc private func textFieldChange(_ sender: UITextField) {
    if sender == scrollView.userBirthTextField {
      if sender.text?.count ?? 0 == 6 {
        scrollView.userSexTextField.becomeFirstResponder()
      }
    } else if sender == scrollView.userSexTextField {
      if sender.text?.count ?? 0 == 1 {
        tabSelectPopupMenuButtons(scrollView.selectMobileCompany)
      }
    } else if sender == scrollView.userPhoneNumberTextField {
      if sender.text?.count ?? 0 == 11 {
        scrollView.endEditing(true)
      }
    } else if sender == scrollView.phoneAuthNumberInputTextField {
      if sender.text?.count ?? 0 == 6 {
        scrollView.endEditing(true)
      }
    }
  }
  
  @objc private func tabUserAgreeButton(_ sender: UIButton) {
    let allAgreebutton = scrollView.customAuthAllAgreeButton
    sender.isSelected.toggle()
    // 버튼 체크 통제
    if sender == allAgreebutton {
      // 전체 동의 버튼
      scrollView.customerAgreeButtonArray.forEach {
        $0.isSelected = sender.isSelected // 전체 동의시 하위 버튼 동일하게 변경
      }
    } else {
      // 기타 버튼
      allAgreebutton.isSelected = true
      scrollView.customerAgreeButtonArray.forEach {
        if $0.isSelected == false {
          allAgreebutton.isSelected = allAgreebutton.isSelected && $0.isSelected
        }
      }
    }
    
    let sView = self.scrollView //
    if allAgreebutton.isSelected == true {
      UIView.animate(withDuration: 0.1) {
        sView.stackView.transform = .init(scaleX: 0, y: 0)
        sView.stackViewContinerView.snp.updateConstraints {
          $0.height.equalTo(0)
        }
        self.loadViewIfNeeded()
      }
    } else {
      UIView.animate(withDuration: 0.1) {
        sView.stackView.transform = .identity
        sView.stackViewContinerView.snp.updateConstraints {
          $0.height.equalTo(191)
        }
        self.loadViewIfNeeded()
      }
    }
    isUserAgreeWithAlltou = allAgreebutton.isSelected
  }
  
  @objc private func tabSelectPopupMenuButtons(_ sender: UIButton) {
    
    let selectPopupVC = SelectPopupVC()
    if sender == scrollView.selectConturyButton {
      selectPopupVC.sectionTitle = "  국적 선택"
      selectPopupVC.selectionMenus = ["내국인", "외국인"]
      selectPopupVC.passTextField = scrollView.usernameTextField
    } else if sender == scrollView.selectMobileCompany {
      selectPopupVC.sectionTitle = "  통신사 선택"
      selectPopupVC.selectionMenus = ["SKT", "KT", "LGU+", "알뜰폰"]
      selectPopupVC.passTextField = scrollView.userPhoneNumberTextField
    }
    
    selectPopupVC.passBlurView = scrollView.blurView
    selectPopupVC.tableView.reloadData()
    selectPopupVC.modalPresentationStyle = .overFullScreen
    
    // 블러효과
    UIView.animate(withDuration: 0.5) {
      self.scrollView.blurView.alpha = 0.4
    }
    
    selectPopupVC.passUserSelectDataClosure = { [weak self] userInput in
      self?.navigationController?.navigationBar.isTranslucent = false
      
      let imageConf = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
      let buttonImage = NSTextAttachment( image: UIImage(systemName: "chevron.down",
                                                         withConfiguration: imageConf)!.withTintColor(.black))
      let attrubutedString = NSAttributedString.authStyle(imageAttach: buttonImage, setText: userInput)
      if sender == self?.scrollView.selectConturyButton {
        self?.scrollView.selectConturyButton.setAttributedTitle(attrubutedString, for: .selected)
      } else {
        self?.scrollView.selectMobileCompany.setAttributedTitle(attrubutedString, for: .selected)
        self?.scrollView.selectMobileCompany.titleLabel?.textColor = .black
      }
    }
    present(selectPopupVC, animated: true)
  }
  
  @objc private func tapAuthCompleteButton() {

    guard let inputAuthCode = scrollView.phoneAuthNumberInputTextField.text else {
      errorAlertControllerPresent(.phoneNumberInputError)
      return
    }
    
    guard let responseKey = phoneAuthResponse?.responseKey else { return print("기존 저장된 registration 코드가 없습니다.")}
    
    // 인증 데이터 생성
    let jsonValue: [String: Any] = [
      "check_auth_number": "\(inputAuthCode)"
    ]
    
    let url = URL(string: "https://sofastcar.moorekwon.xyz/phone_auth/\(responseKey)/check_auth_number/")!
    var request = URLRequest(url: url)
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: jsonValue, options: .prettyPrinted)
      request.httpBody = jsonData
    } catch let err {
      print(err)
    }
    
    request.httpMethod = HTTPMethod.put.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    scrollView.activityIndicator.startAnimating()
    
    let getAuthResponse = URLSession.shared.dataTask(with: request) { (_, response, error) in
      if let error = error {
        print("Error", error.localizedDescription)
        return
      }
      
      if let header = response as? HTTPURLResponse {
        if header.statusCode == 200 {
          self.successPhoneAuth()
        } else {
          self.errorAlertControllerPresent(.smsAuthCodeError)
        }
      }
      DispatchQueue.main.async {
        self.scrollView.activityIndicator.stopAnimating()
      }
    }
    getAuthResponse.resume()
  }
  
  @objc private func tapSendAuthSMSButton(_ sender: UIButton) {
    guard let userBirthDay = scrollView.userBirthTextField.text else { return }
    guard let userGender = scrollView.userSexTextField.text else { return }
    guard let userPhoneNumber = scrollView.userPhoneNumberTextField.text else { return }
    
    guard userInputValueValidCheck(checkStr: userBirthDay, checkType: ValidtionType.bithDay) == true else {
      errorAlertControllerPresent(.bithDayInputError); return }
    
    guard userInputValueValidCheck(checkStr: userPhoneNumber, checkType: ValidtionType.phoneNumber) == true else {
      errorAlertControllerPresent(.phoneNumberInputError); return }
    
    scrollView.activityIndicator.startAnimating()
    
    // 인증 데이터 생성
    let jsonValue: [String: Any] = [
      "phone_number": "\(userPhoneNumber)",
      "registration_id": "\(userBirthDay)\(userGender)"
    ]
  
    let url = URL(string: "https://sofastcar.moorekwon.xyz/phone_auth/")!
    var request = URLRequest(url: url)
    
    do {
      let jsonData = try JSONSerialization.data(withJSONObject: jsonValue, options: .prettyPrinted)
      request.httpBody = jsonData
    } catch let err {
      print(err)
    }

    request.httpMethod = HTTPMethod.post.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        print("Error", error.localizedDescription)
        self.errorAlertControllerPresent(.serverSideError)
        return
      }
      // 오류 처리
      guard let header = response as? HTTPURLResponse,
        (200..<300) ~= header.statusCode,
        let responseData = data else {
          self.errorAlertControllerPresent(.serverSideError)
          return
      }
      
      // 인증번호 입력 UI 변경
      self.showUserAuthcodeInputView()
      self.phoneAuthResponse = try? JSONDecoder().decode(PhoneAuthResponse.self, from: responseData)
      print("Sucess to get phoneAuthResponse", self.phoneAuthResponse?.registrationId ?? "")
      
    }
    task.resume()
  }
  
  private func userInputValueValidCheck(checkStr: String, checkType: ValidtionType) -> Bool {
    let testMethod = NSPredicate(format: "SELF MATCHES %@", checkType.rawValue)
    return testMethod.evaluate(with: checkStr)
  }
  
  private func errorAlertControllerPresent(_ errorKind: AuthError) {
    let alertCtroller = UIAlertController(title: "오류", message: errorKind.rawValue, preferredStyle: .alert)
    alertCtroller.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
    DispatchQueue.main.async {
      self.present(alertCtroller, animated: true, completion: nil)
    }
  }
  
  private func successPhoneAuth() {
    DispatchQueue.main.async {
      let view = self.scrollView
      guard let userName = view.usernameTextField.text else { return }
      guard let userBirthDay = view.userBirthTextField.text else { return }
      guard let userGender = view.userSexTextField.text else { return }
      guard let userPhoneNumber = Int(view.userPhoneNumberTextField.text ?? "") else { return print("Errir0")}
      //    guard let userContury = scrollView.selectConturyButton.attributedTitle(for: .selected)?.string.split(separator: " ").first else { return print("Errir1")}
      //    guard let mobileCompany = scrollView.selectMobileCompany.attributedTitle(for: .selected)?.string.split(separator: " ").first else { return print("Errir2")}
      
      self.user?.useranme = userName
      self.user?.userBirthDay = "\(userBirthDay)\(userGender)"
      self.user?.userPhoneNumber = userPhoneNumber
      //    user?.userGender = userGender
      //    user?.mobileCompany = String(mobileCompany)
      //    user?.userContury = String(userContury)
      
      let defualtUserInfoVC = DefualtUserInfoVC()
      defualtUserInfoVC.user = self.user
      self.navigationController?.pushViewController(defualtUserInfoVC, animated: true)
    }
  }
  
  // MARK: - Keyboard Handler
  @objc func keyboardWillAppear( noti: NSNotification ) {
    if isKeyboardUp == false && isUserAgreeWithAlltou == false || scrollView.phoneAuthNumberInputTextField.isFirstResponder {
      if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y -= keyboardHeight
      }
      isKeyboardUp = true
    }
  }
  
  @objc func keyboardWillDisappear( noti: NSNotification ) {
    if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      if isKeyboardUp == true {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y += keyboardHeight
        isKeyboardUp = false
      }
    }
  }
  
  private func showUserAuthcodeInputView() {
    DispatchQueue.main.async {
      self.scrollView.phoneAuthNumberInputTextField.snp.updateConstraints {
        $0.height.equalTo(CommonUI.userInputMenusHeight)
      }
      self.scrollView.authLimitCountTimerLabel.snp.updateConstraints {
        $0.height.equalTo(CommonUI.sectionLabelHeight)
      }
      self.scrollView.authCompleteButton.isEnabled = true
      self.scrollView.sendAuthenticationSMSButton.setTitle("재발송", for: .normal)
      self.scrollView.activityIndicator.stopAnimating()
    }
  }
}

// MARK: - UITextFieldDelegate
extension UserAuthVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == scrollView.usernameTextField {
      scrollView.userBirthTextField.becomeFirstResponder()
    }
    return true
  }
  
  // 각 텍스트 필드 입력 완료시 다은 TextField 로 Response 넘겨줌
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newLength = (textField.text?.count)! + string.count - range.length
    if textField == scrollView.usernameTextField || textField == scrollView.userBirthTextField || textField == scrollView.phoneAuthNumberInputTextField {
      return !(newLength > 6)
    } else if textField == scrollView.userSexTextField {
      return !(newLength > 1)
    }
    return !(newLength > 11)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.black.cgColor
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    textField.layer.borderColor = UIColor.systemGray4.cgColor
  }
}

// MARK: - UIScrollViewDelegate
extension UserAuthVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // 모든 약관에 동의한 경우 stackview가 줄어듬으로써 스크롤 차단
    if isUserAgreeWithAlltou == true {
      if scrollView.contentOffset.y > -999 {
        scrollView.contentOffset.y = -scrollView.safeAreaInsets.top
      }
    }
  }
}
