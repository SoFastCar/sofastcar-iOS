//
//  CheckButtonView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/23.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class CheckButtonView: UIView {
  
  var toggle: Bool? {
    didSet {
      switch toggle {
      case true:
        checkIcon.tintColor = CommonUI.mainBlue
        checkButtonLabel.textColor = CommonUI.mainBlue
      default:
        checkIcon.tintColor = UIColor.black.withAlphaComponent(0.3)
        checkButtonLabel.textColor = UIColor.black.withAlphaComponent(0.3)
      }
    }
  }
  
  var buttonTypeLabel: String? {
    didSet {
      checkButtonLabel.text = buttonTypeLabel
    }
  }
  
  fileprivate let checkIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.check.rawValue)
    
    return imageView
  }()
  
  fileprivate let checkButtonLabel: UILabel = {
    let label = UILabel()
    
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    toggle?.toggle()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    [checkIcon, checkButtonLabel].forEach {
      self.addSubview($0)
    }
    
    checkIcon.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
    }
    
    checkButtonLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalTo(checkIcon.snp.trailing).offset(10)
    }
  }
}
