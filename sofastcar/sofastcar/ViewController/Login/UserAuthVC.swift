//
//  UserAuthVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserAuthVC: UIViewController {
  
  // MARK: - Properties
  var user: User?
  
  let scrollView = UserAuthScrollView()
  
  var isUserEdtting: Bool = false
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "휴대폰 인증"
    
    configureButtonAction()
  }
  
  override func loadView() {
    view = scrollView
  }
  
  override func viewWillAppear(_ animated: Bool) {
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
  
  private func configureButtonAction() {
    // textField 변경 사항 체크
    [scrollView.userSexTextField, scrollView.userBirthTextField, scrollView.userSexTextField, scrollView.userPhoneNumberTextField, scrollView.usernameTextField].forEach {
      $0.delegate = self
      $0.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
    
    scrollView.customerAgreeButtonArray.forEach {
      $0.addTarget(self, action: #selector(tabUserAgreeButton(_:)), for: .touchUpInside)
      $0.isSelected = false
    }
    scrollView.customAuthAllAgreeButton.addTarget(self, action: #selector(tabUserAgreeButton(_:)), for: .touchUpInside)
    scrollView.customAuthAllAgreeButton.isSelected = false
  }
  
  // MARK: - Handler

  
  // MARK: - Button Handler
  
  @objc private func textFieldChange(_ sender: UITextField) {
    if sender == scrollView.userBirthTextField {
      if sender.text?.count ?? 0 == 6 {
        scrollView.userSexTextField.becomeFirstResponder()
      }
    } else if sender == scrollView.userSexTextField {
      if sender.text?.count ?? 0 == 1 {
        scrollView.selectMobileCompany.becomeFirstResponder()
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
    
    let view = self.scrollView
    
    if allAgreebutton.isSelected == true {
      print("animation in")
      UIView.animate(withDuration: 0.1) {
        view.stackView.transform = .init(scaleX: 0, y: 0)
        view.continerView.snp.updateConstraints {
          $0.height.equalTo(0)
        }
        self.loadViewIfNeeded()
      }
    } else {
      print("animation in")
      UIView.animate(withDuration: 0.1) {
        view.stackView.transform = .identity
        view.continerView.snp.updateConstraints {
          $0.height.equalTo(191)
        }
        self.loadViewIfNeeded()
      }
    }
  }
  
  // MARK: - Keyboard Handler
  @objc func keyboardWillAppear( noti: NSNotification ) {
    if isUserEdtting == false {
      if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y -= keyboardHeight
      }
      isUserEdtting = true
    }
  }
  
  @objc func keyboardWillDisappear( noti: NSNotification ) {
    
    if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      if isUserEdtting == true {
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y += keyboardHeight
        isUserEdtting = false
      }
    }
  }
}

extension UserAuthVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == scrollView.usernameTextField {
      scrollView.userBirthTextField.becomeFirstResponder()
    }
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newLength = (textField.text?.count)! + string.count - range.length
    if textField == scrollView.usernameTextField || textField == scrollView.userBirthTextField {
      return !(newLength > 6)
    } else if textField == scrollView.userSexTextField {
      return !(newLength > 1)
    }
    return !(newLength > 11)
  }
}
