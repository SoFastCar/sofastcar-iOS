//
//  DefualtUserInfoVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import CryptoKit
import Alamofire

enum ValidationCheck: String {
  case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  case passwd = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
}

class DefualtUserInfoVC: UIViewController {
  // MARK: - Properties
  var username: String = ""
  var phoneNumber: String = ""
  var viewUpAmount: CGFloat = 0
  
  let myView = DefaultUserInfoView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationSetting()
    textFieldDelegateSetting()
    configureButtonAction()
  }

  override func loadView() {
    view = myView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false
    viewUpAmount = 0
  }
  
  private func navigationSetting() {
    title = "기본정보"
    self.navigationController?.navigationBar.topItem?.title = ""
  }
  
  private func textFieldDelegateSetting() {
    [myView.userIdTextField, myView.userPasswordField,
     myView.reUserPasswordField, myView.reCommendIdField].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(inputCompleteVaild), for: .editingChanged)
    }
  }
  
  private func configureButtonAction() {
    myView.inputCompleteButton.addTarget(self, action: #selector(tabInputCompletButton), for: .touchUpInside)
  }
  
  // MARK: - Handler
  private func moveupViewAmount(amount: CGFloat) {
    UIView.animate(withDuration: 0.2) {
      self.myView.center.y += amount //self.myView.center.y +
    }
    viewUpAmount += amount
  }
  
  private func checkUserInput(kind: ValidationCheck, checkStr: String) -> Bool {
    let testMethod = NSPredicate(format: "SELF MATCHES %@", kind.rawValue)
    return testMethod.evaluate(with: checkStr)
  }
  
  private func checkAuthButtonEnable() {
    myView.inputCompleteButton.isEnabled = false
    
    guard myView.userIdTextField.text?.isEmpty == false else { return }
    guard myView.userPasswordField.text?.isEmpty == false else { return }
    guard myView.reUserPasswordField.text?.isEmpty == false else { return }
    
    guard myView.recommendWaringLable.isHidden == true else { return }
    guard myView.userRePasswordWaringLable.isHidden == true else { return }
    guard myView.userPasswordWaringLable.isHidden == true else { return }
    guard myView.recommendWaringLable.isHidden == true else { return }
    
    myView.inputCompleteButton.isEnabled = true
  }
  
  private func checkUserInputIsValid(textField: UITextField, isValied: Bool) {
    // warning Label Appear
    switch textField {
    case myView.userIdTextField:
      myView.userNameWaringLable.isHidden = isValied
      myView.userNameWaringImage.isHidden = isValied
    case myView.userPasswordField:
      myView.userPasswordWaringLable.isHidden = isValied
      myView.userPasswordWaringImage.isHidden = isValied
    case myView.reUserPasswordField:
      myView.userRePasswordWaringLable.isHidden = isValied
      myView.userRePasswordWaringImage.isHidden = isValied
    case myView.reCommendIdField:
      if myView.reCommendIdField.text?.isEmpty != nil {
        myView.recommendWaringLable.isHidden = isValied
        myView.recommendWaringImage.isHidden = isValied
      }
    default:
      break
    }
    
    if isValied == false {
      textField.layer.borderColor = UIColor.red.cgColor
    }
  }
  
  @objc private func tabInputCompletButton() {
    guard let userEmail = myView.userIdTextField.text else { return print("aa") }
    guard let userPassword = myView.userPasswordField.text else { return print("bb") }
    
    let sendUSerSignUpData = [
      "name": username,
      "email": userEmail,
      "password": userPassword,
      "phone": phoneNumber
    ]
    
    print(sendUSerSignUpData)
    
    let url = URL(string: "https://sofastcar.moorekwon.xyz/members")!
    
    AF.request(url, method: .post,
               parameters: sendUSerSignUpData)
      .responseJSON { response in
        print(response)
        if response.response?.statusCode == 201 {
          self.presentSignUpCompleteVC()
        } else {
          let alertCtroller = UIAlertController(title: "오류", message: "다른 이메일 주소를 입력해주세요", preferredStyle: .alert)
          alertCtroller.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
          DispatchQueue.main.async {
            self.present(alertCtroller, animated: true, completion: nil)
          }
        }
    }
  }
  
  private func presentSignUpCompleteVC() {
    DispatchQueue.main.async {
      let singUpCompleteVC = SingUpCompleteVC()
      singUpCompleteVC.passBlurView = self.myView.blurView
      singUpCompleteVC.modalPresentationStyle = .overFullScreen
      singUpCompleteVC.passPushViewFunc = self.presentCreditCardInputVC
      self.present(singUpCompleteVC, animated: true)
      
      UIView.animate(withDuration: 0.5) {
        self.myView.blurView.alpha = 0.4
      }
    }
  }
  
  @objc private func inputCompleteVaild() {
    checkAuthButtonEnable()
  }
}

// MARK: - UITextFieldDelegate
extension DefualtUserInfoVC: UITextFieldDelegate {
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    // 재 입력시 정상으로 표기
    checkUserInputIsValid(textField: textField, isValied: true)
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case myView.userIdTextField:
      myView.userPasswordField.becomeFirstResponder()
      moveupViewAmount(amount: -UIScreen.main.bounds.height*0.1)
    case myView.userPasswordField:
      myView.reUserPasswordField.becomeFirstResponder()
      moveupViewAmount(amount: -UIScreen.main.bounds.height*0.1)
    default:
      myView.endEditing(true)
      moveupViewAmount(amount: -viewUpAmount)
      viewUpAmount = 0
    }
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.layer.borderColor = UIColor.black.cgColor
    
    switch textField {
    case myView.userIdTextField:
      moveupViewAmount(amount: 0)
    case myView.userPasswordField:
      moveupViewAmount(amount: -UIScreen.main.bounds.height*0.1)
    case myView.reUserPasswordField: // 패스워드 입력 만료시 뷰 원상복귀
      moveupViewAmount(amount: -UIScreen.main.bounds.height*0.1)
    case myView.reCommendIdField:
      moveupViewAmount(amount: -UIScreen.main.bounds.height*0.23)
    default:
      myView.endEditing(true)
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    var validResult: Bool = true
    textField.layer.borderColor = UIColor.systemGray4.cgColor //UIColor.black.cgColor
    if textField == myView.userIdTextField || textField == myView.reCommendIdField {
      validResult = checkUserInput(kind: .email, checkStr: textField.text ?? "")
    } else if textField == myView.userPasswordField {
      validResult = checkUserInput(kind: .passwd, checkStr: textField.text ?? "")
    } else if textField == myView.reUserPasswordField {
      validResult = checkUserInput(kind: .passwd, checkStr: textField.text ?? "")
      if myView.userPasswordField.text != myView.reUserPasswordField.text {
        validResult = false
      }
    }
    
    // 검증값 오류시 warning 메시지 이미지 표기
    checkUserInputIsValid(textField: textField, isValied: validResult)
    // 입력 종료시 화면 원위치
    moveupViewAmount(amount: -viewUpAmount)
    // 검증값 조합을 통하 입력 완료 버튼 활성화 여부 체크
    checkAuthButtonEnable() // 체크
  }
  
  func presentCreditCardInputVC() {
    let cardEnrollinitVC = CardEnrollinitVC()
    navigationController?.pushViewController(cardEnrollinitVC, animated: true)
  }
}
