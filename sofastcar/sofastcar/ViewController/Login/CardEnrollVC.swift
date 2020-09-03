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
  
  // 텍스트 필드 리스폰스 체인 용
  var responseChainIndex: Int?
  lazy var textFieldResponseArray = [myView.cardNumberTextField, myView.cardExpDateMonthTextField,
  myView.cardExpDateYearTextField, myView.cardPasswordTextField, myView.personNumberTextfield]
  let textCountRestrictArray = [19, 2, 2, 2, 6]
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationSetting()
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
  
  private func navigationSetting() {
    title = "개인카드 등록"
    self.navigationController?.navigationBar.topItem?.title = ""
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
    guard myView.customAuthAllAgreeButton.isSelected == true else { return }
    guard myView.cardNumberTextField.text?.isEmpty == false else { return }
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
    if let sender = sender as? LoginUserInputTextField {
      // 최초 선택인 경우 확인 or 텍스트 필드 변경된 경우
      if responseChainIndex == nil || sender != textFieldResponseArray[responseChainIndex ?? 0] {
        responseChainIndex = fetchNowEdittingTextFieldIndex(sender)
      } else {
        guard let index = responseChainIndex else { return }
        if sender.text?.count ?? 0 == textCountRestrictArray[index] {
          if index+1 == textFieldResponseArray.count {
            // 마지막 텍스트 필드인 경우 입력 종료
            print("dd")
            myView.endEditing(true)
            responseChainIndex = nil
            return
          }
          print("ff")
          textFieldResponseArray[index+1].becomeFirstResponder()
        }
      }
      
      if sender == myView.cardNumberTextField {
        changeCardNumberWithSpace(sender)
      }
    }
  }
  
  private func fetchNowEdittingTextFieldIndex(_ sender: LoginUserInputTextField) -> Int {
    return textFieldResponseArray.firstIndex(of: sender) ?? 0
  }
  
  private func changeCardNumberWithSpace(_ sender: UITextField) {
    if let text = sender.text {
      if text.components(separatedBy: " ").joined().count % 4 == 0 && text.count != 0 {
        sender.text = "\(text) "
      }
    }
  }
  
  @objc private func tabAuthCompleteButton() {
    let driverLicenseEnrollinitVC = DriverLicenseEnrollinitVC()
    navigationController?.pushViewController(driverLicenseEnrollinitVC, animated: true)
  }
}

extension CardEnrollVC: UITextFieldDelegate {
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
    textField.layer.borderColor = UIColor.systemGray4.cgColor
    if textField == myView.cardExpDateYearTextField {
      myView.cardExpDateMonthTextField.layer.borderColor = UIColor.systemGray4.cgColor
    }
    checkAuthEnabler()
  }
}
