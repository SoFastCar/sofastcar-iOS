//
//  UserStatusAfterReturnView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

protocol UserStatusAfterReturnViewDelegate: class {
    func didTapButton(_ sender: UIButton)
}

class UserStatusAfterReturnView: UIView {
  
  weak var delegate: UserStatusAfterReturnViewDelegate?
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    self.backgroundColor = .cyan
  }
  
  // MARK: - Action
  
  @objc fileprivate func didTapButton(_ sender: UIButton) {
    delegate?.didTapButton(sender)
  }
}
