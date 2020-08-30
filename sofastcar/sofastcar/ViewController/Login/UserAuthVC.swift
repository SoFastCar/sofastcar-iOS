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
  var isKeyboardUp: Bool = false
  var isUserAgreeWithAlltou: Bool = false

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
    self.navigationController?.navigationBar.addSubview(self.scrollView.blurView)
    self.navigationController?.navigationBar.sendSubviewToBack(self.scrollView.blurView)
  }
  
  private func configureButtonAction() {
    // textField 변경 사항 체크
    [scrollView.userSexTextField, scrollView.userBirthTextField, scrollView.userSexTextField, scrollView.userPhoneNumberTextField, scrollView.usernameTextField].forEach {
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
    scrollView.authCompleteButton.addTarget(self, action: #selector(tapAuthCompleteButton), for: .touchUpInside)
  }
  // MARK: - Check AuthComplete button Enabler
  private func checkAuthButtonEnable() {
    scrollView.authCompleteButton.isEnabled = isUserAgreeWithAlltou
//      isUserAgreeWithAlltou && scrollView.selectConturyButton.isSelected &&
//      scrollView.selectMobileCompany.isSelected && ((scrollView.usernameTextField.text?.isEmpty) != nil) &&
//      ((scrollView.userBirthTextField.text?.isEmpty) != nil) && ((scrollView.userSexTextField.text?.isEmpty) != nil) &&
//      (scrollView.userPhoneNumberTextField.text?.isEmpty != nil)

    print(scrollView.authCompleteButton.isEnabled)
    let authButtonBGColor = scrollView.authCompleteButton.isEnabled == true ?  #colorLiteral(red: 0.007875645533, green: 0.7243045568, blue: 0.9998746514, alpha: 1) : .systemGray4
    scrollView.authCompleteButton.backgroundColor = authButtonBGColor
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
    }
    checkAuthButtonEnable()
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
    checkAuthButtonEnable()
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
    checkAuthButtonEnable()
  }
  
  @objc private func tapAuthCompleteButton() {
    let defualtUserInfoVC = DefualtUserInfoVC()
    defualtUserInfoVC.user = self.user
    navigationController?.pushViewController(defualtUserInfoVC, animated: true)
  }
  
  // MARK: - Keyboard Handler
  @objc func keyboardWillAppear( noti: NSNotification ) {
    if isKeyboardUp == false && isUserAgreeWithAlltou == false {
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
}

// MARK: - UITextFieldDelegate
extension UserAuthVC: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == scrollView.usernameTextField {
      scrollView.userBirthTextField.becomeFirstResponder()
    }
    checkAuthButtonEnable()
    return true
  }
  
  // 각 텍스트 필드 입력 완료시 다은 TextField 로 Response 넘겨줌
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    checkAuthButtonEnable()
    let newLength = (textField.text?.count)! + string.count - range.length
    if textField == scrollView.usernameTextField || textField == scrollView.userBirthTextField {
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
    textField.layer.borderColor = UIColor.systemGray4.cgColor //UIColor.black.cgColor
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
