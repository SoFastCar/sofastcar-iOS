//
//  LoginUserInputTextField.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/30.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import UIKit

class LoginUserInputTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layer.borderColor = UIColor.systemGray4.cgColor
    self.layer.borderWidth = 1
    self.backgroundColor = .white
    self.autocorrectionType = .no
    self.autocapitalizationType = .none
    self.clearsOnBeginEditing = true
    self.addLeftPadding()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
