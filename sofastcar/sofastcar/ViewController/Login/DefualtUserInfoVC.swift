//
//  DefualtUserInfoVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum ValidationCheck: String {
  case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
  case passwd = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
}

class DefualtUserInfoVC: UIViewController {
  // MARK: - Properties
  var user: User?
  var viewUpAmount: CGFloat = 0
  
  let myView = DefaultUserInfoView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "기본정보"
    
    [myView.userIdTextField, myView.userPasswordField,
     myView.reUserPasswordField, myView.reCommendIdField].forEach {
      $0.delegate = self
    }
    
  }

  override func loadView() {
    view = myView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewUpAmount = 0
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
    
    guard myView.userIdTextField.text?.isEmpty == false else { return }
    guard myView.userPasswordField.text?.isEmpty == false else { return }
    guard myView.reUserPasswordField.text?.isEmpty == false else { return }
    
    guard myView.recommendWaringLable.isHidden == true else { return }
    guard myView.userRePasswordWaringLable.isHidden == true else { return }
    guard myView.userPasswordWaringLable.isHidden == true else { return }
    guard myView.recommendWaringLable.isHidden == true else { return }
    
    myView.inputCompleteButton.isEnabled = true
  }
}

// MARK: - UITextFieldDelegate
extension DefualtUserInfoVC: UITextFieldDelegate {
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
    } else if textField == myView.userPasswordField || textField == myView.reUserPasswordField {
      validResult = checkUserInput(kind: .passwd, checkStr: textField.text ?? "")
      print(validResult)
    }
    
    // warning Label Appear
    switch textField {
    case myView.userIdTextField:
      myView.userNameWaringLable.isHidden = validResult
      myView.userNameWaringImage.isHidden = validResult
    case myView.userPasswordField:
      myView.userPasswordWaringLable.isHidden = validResult
      myView.userPasswordWaringImage.isHidden = validResult
    case myView.reUserPasswordField:
      myView.userRePasswordWaringLable.isHidden = validResult
      myView.userRePasswordWaringImage.isHidden = validResult
    case myView.reCommendIdField:
      myView.recommendWaringLable.isHidden = validResult
      myView.recommendWaringImage.isHidden = validResult
    default:
      break
    }
    
    if validResult == false {
      textField.layer.borderColor = UIColor.red.cgColor
    }
    
    moveupViewAmount(amount: -viewUpAmount)
    checkAuthButtonEnable() // 체크
  }
}
