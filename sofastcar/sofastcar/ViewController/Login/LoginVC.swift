//
//  LoginVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire

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
    myView.loginButton.addTarget(self, action: #selector(tabLoginButton), for: .touchUpInside)
  }
  
  private func configureTextFieldDelegate() {
    [myView.emailTextField, myView.passwordTextField].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(chekcLoginButtonEnable), for: .editingChanged)
    }
  }
  
  // MARK: - Button Handler
  @objc private func tabBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func chekcLoginButtonEnable() {
    myView.loginButton.isEnabled = false
    myView.loginButton.backgroundColor = .systemGray4
    guard myView.emailTextField.text?.isEmpty == false else { return }
    guard myView.passwordTextField.text?.isEmpty == false else { return }
    myView.loginButton.isEnabled = true
    myView.loginButton.backgroundColor = CommonUI.mainBlue
  }
  
  @objc private func tabLoginButton() {
    guard let userid = myView.emailTextField.text else { return }
    guard let userPassword = myView.passwordTextField.text else { return }
    
    let url = URL(string: "https://sofastcar.moorekwon.xyz/api-jwt-auth/")!
    
    let userLoginAuthPatameters = [
      "email": userid,
      "password": userPassword
    ]
    
    AF.request(url, method: .post, parameters: userLoginAuthPatameters)
      .responseJSON { response in
        if response.response?.statusCode == 200 {
          guard let data = response.data else { return print("Data Erro") }
          if let jsonObjcet = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            if let userTocken = jsonObjcet["token"] as? String {
              UserDefaults.saveUserAuthTocken(authToken: userTocken)
              let mainVC = MainVC()
              mainVC.socarZoneProvider = SocarZoneProvider()   
              let navigationController = UINavigationController(rootViewController: mainVC)
              navigationController.modalPresentationStyle = .overFullScreen
              self.present(navigationController, animated: true, completion: nil)
            }
          }
        } else {
          let alertCtroller = UIAlertController(title: "오류", message: "아이디&패스워드를 확인해주세요", preferredStyle: .alert)
          alertCtroller.addAction(UIAlertAction(title: "확인", style: .cancel, handler: nil))
          DispatchQueue.main.async {
            self.present(alertCtroller, animated: true, completion: nil)
          }
        }
    }
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
