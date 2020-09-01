//
//  CardEnrollVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CardEnrollVC: UIViewController {
  // MARK: - Properties
  let myView = CardEnrollView()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "개인카드 등록"
    
    configureTextFieldDelegate()
    
    configureButtonTargetAction()
    
  }
  
  override func loadView() {
    view = myView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let navi = navigationController {
      navi.navigationBar.isHidden = false
      navi.navigationBar.tintColor = .black
    }
  }
  
  private func configureTextFieldDelegate() {
    [myView.cardNumberTextField, myView.cardExpDateMonthTextField,
     myView.cardExpDateYearTextField, myView.cardPasswordTextField,
     myView.personNumberTextfield].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
  }
  
  private func configureButtonTargetAction() {
    myView.customAuthAllAgreeButton.addTarget(self, action: #selector(tabAgreeButtons), for: .touchUpInside)
    myView.customerAgreeButtonArray.forEach {
      $0.addTarget(self, action: #selector(tabAgreeButtons), for: .touchUpInside)
    }
    myView.authCompleteButton.addTarget(self, action: #selector(tabAuthCompleteButton), for: .touchUpInside)
  }
  
  private func checkAuthEnabler() {
    myView.authCompleteButton.isEnabled = false
    guard myView.customAuthAllAgreeButton.isSelected == true else { return print("a")}
    guard myView.cardNumberTextField.text?.isEmpty == false else { return print("b")}
    guard myView.cardExpDateMonthTextField.text?.isEmpty == false else { return }
    guard myView.cardExpDateYearTextField.text?.isEmpty == false else { return }
    guard myView.cardPasswordTextField.text?.isEmpty == false else { return }
    guard myView.personNumberTextfield.text?.isEmpty == false else { return }
    
    myView.authCompleteButton.isEnabled = true
  }
  
  // MARK: - Button Handler
  @objc private func tabAgreeButtons(_ sender: UIButton) {
    sender.isSelected.toggle()
    
    if sender == myView.customAuthAllAgreeButton {
      //전체 동의버튼
      myView.customerAgreeButtonArray.forEach {
        $0.isSelected = sender.isSelected
      }
    } else {
      // 하위 체크 버튼
      myView.customAuthAllAgreeButton.isSelected = true
      myView.customerAgreeButtonArray.forEach {
        if $0.isSelected == false { myView.customAuthAllAgreeButton.isSelected = false; return }
      }
    }
    checkAuthEnabler()
  }
  
  @objc private func textFieldChange(_ sender: UITextField) {
    if sender == myView.cardNumberTextField {
      if let text = sender.text {
        if text.components(separatedBy: " ").joined().count % 4 == 0 && text.count != 0 {
          sender.text = "\(text) "
        }
      }
      if sender.text?.count ?? 0 == 20 {
        myView.cardExpDateMonthTextField.becomeFirstResponder()
      }
    } else if sender == myView.cardExpDateMonthTextField {
      if sender.text?.count ?? 0 == 2 {
        myView.cardExpDateYearTextField.becomeFirstResponder()
      }
    } else if sender == myView.cardExpDateYearTextField {
      if sender.text?.count ?? 0 == 2 {
        myView.cardPasswordTextField.becomeFirstResponder()
      }
    } else if sender == myView.cardPasswordTextField {
      if sender.text?.count ?? 0 == 2 {
        myView.personNumberTextfield.becomeFirstResponder()
      }
    } else if sender == myView.personNumberTextfield {
      if sender.text?.count ?? 0 == 6 {
        myView.endEditing(true)
      }
    }
  }
  
  @objc private func tabAuthCompleteButton() {
    let driverLicenseEnrollinitVC = DriverLicenseEnrollinitVC()
    navigationController?.pushViewController(driverLicenseEnrollinitVC, animated: true)
  }
}

extension CardEnrollVC: UITextFieldDelegate {
//  [myView.cardNumberTextField, myView.cardExpDateMonthTextField,
//  myView.cardExpDateYearTextField, myView.cardPasswordTextField,
//  myView.personNumberTextfield]
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    // 재 입력시 정상으로 표기
//    checkUserInputIsValid(textField: textField, isValied: true)
    return true
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    switch textField {
    case myView.cardNumberTextField:
      myView.cardExpDateMonthTextField.becomeFirstResponder()
    case myView.cardExpDateMonthTextField:
      myView.cardExpDateYearTextField.becomeFirstResponder()
    case myView.cardExpDateYearTextField:
      myView.cardPasswordTextField.becomeFirstResponder()
    case myView.cardPasswordTextField:
      myView.personNumberTextfield.becomeFirstResponder()
    default:
      myView.endEditing(true)
    }
    
    checkAuthEnabler()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    // 텍스트 필드색 변경
    textField.layer.borderColor = UIColor.black.cgColor
    if textField == myView.cardExpDateYearTextField {
      myView.cardExpDateMonthTextField.layer.borderColor = UIColor.black.cgColor
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
    var validResult: Bool = true
    textField.layer.borderColor = UIColor.systemGray4.cgColor
    if textField == myView.cardExpDateYearTextField {
      myView.cardExpDateMonthTextField.layer.borderColor = UIColor.systemGray4.cgColor
    }
    
    checkAuthEnabler()
  }
}
