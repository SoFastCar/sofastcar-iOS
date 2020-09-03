//
//  LoginVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
  
  let myView = LoginView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButtonTargetAction()
    
    configureTextFieldDelegate()
  }
  
  override func loadView() {
    view = myView
  }
  
  private func configureButtonTargetAction() {
    myView.backButton.addTarget(self, action: #selector(tabBackButton), for: .touchUpInside)
  }
  
  private func configureTextFieldDelegate() {
    [myView.emailTextField, myView.passwordTextField].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(chekcLoginButtonEnable), for: .editingChanged)
    }
  }
  
  // MARK: - Button Handler
  @objc private func tabBackButton() {
    print("tab Button")
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func chekcLoginButtonEnable() {
    myView.loginButton.isEnabled = false
    myView.loginButton.backgroundColor = .systemGray4
    guard myView.emailTextField.text?.isEmpty == false else { return print("a")}
    guard myView.passwordTextField.text?.isEmpty == false else { return print("b")}
    myView.loginButton.isEnabled = true
    myView.loginButton.backgroundColor = CommonUI.mainBlue
  }
}

extension LoginVC: UITextFieldDelegate {
    
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == myView.emailTextField {
      myView.passwordTextField.becomeFirstResponder()
    } else if textField == myView.passwordTextField {
      myView.endEditing(true)
    }
    changeTextFieldborderColor(textField, color: UIColor.systemGray4.cgColor)
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    changeTextFieldborderColor(textField, color: UIColor.systemGray4.cgColor)
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    changeTextFieldborderColor(textField, color: UIColor.black.cgColor)
  }
  
  fileprivate func changeTextFieldborderColor(_ textField: UITextField, color: CGColor) {
    textField.layer.borderColor = color
  }
}
