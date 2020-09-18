//
//  LoginCompleteButton.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/30.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import UIKit

class CompleteButton: UIButton {
  override var isEnabled: Bool {
    didSet {
      self.backgroundColor = isEnabled == true ? #colorLiteral(red: 0.007875645533, green: 0.7243045568, blue: 0.9998746514, alpha: 1) : #colorLiteral(red: 0.9178397655, green: 0.9184700847, blue: 0.9351041913, alpha: 1)
    }
  }
  
  init(frame: CGRect, title: String) {
    super.init(frame: frame)
    self.titleLabel?.font = .systemFont(ofSize: 18)
    
    self.setTitle(title, for: .normal)
    self.setTitleColor(.white, for: .normal)

    self.setTitle(title, for: .disabled)
    self.setTitleColor(.systemGray3, for: .disabled)
    
    self.contentEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    self.contentVerticalAlignment = .top
    
    self.isEnabled = false
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
