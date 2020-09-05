//
//  CarKeyView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class CarKeyView: UIView {
  
  // MARK: - Attribute
  fileprivate let handleArea: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  
  fileprivate let handler: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.layer.cornerRadius = 2
    view.alpha = 0.1
    
    return view
  }()
  
  fileprivate let smartKeyLabel: UILabel = {
    let label = UILabel()
    label.text = "스마트키"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let onLabel: UILabel = {
    let label = UILabel()
    label.text = "ON"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate let boltIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.bolt.rawValue)
    imageView.tintColor = .black
    imageView.snp.makeConstraints {
      $0.width.equalTo(10)
      $0.height.equalTo(10)
    }
    imageView.alpha = 0.3
    
    return imageView
  }()
  
  fileprivate let openOneSecondLabel: UILabel = {
    let label = UILabel()
    label.text = "1초만에 문 열기"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let rightChevronIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue)
    imageView.tintColor = CommonUI.mainDark
    imageView.snp.makeConstraints {
      $0.width.equalTo(7)
      $0.height.equalTo(15)
    }
    
    return imageView
  }()
  
  fileprivate let returnButton: UIButton = {
    let button = UIButton()
    button.setTitle("반납하기", for: .normal)
    button.setTitleColor(CommonUI.mainDark, for: .normal)
    button.layer.cornerRadius = 10
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.1).cgColor
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  fileprivate let lockView: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 10
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.1).cgColor
    
    return view
  }()
  
  fileprivate let lockButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.lock.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate let milestoneLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .black
    label.alpha = 0.3
    
    return label
  }()
  
  fileprivate let unlockButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.unlock.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  fileprivate lazy var lockStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        lockButton,
        milestoneLabel,
        unlockButton
      ]
    )
    stackView.axis = .horizontal
    stackView.spacing = 50
    
    return stackView
  }()
  
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
    self.backgroundColor = .white
    self.clipsToBounds = true
    self.layer.cornerRadius = 10
    self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    
    [handleArea, smartKeyLabel, onLabel, boltIcon, openOneSecondLabel, rightChevronIcon, returnButton, lockView].forEach {
      self.addSubview($0)
    }
    handleArea.addSubview(handler)
    lockView.addSubview(lockStackView)
    
    handleArea.snp.makeConstraints {
      $0.top.equalTo(self)
      $0.leading.trailing.equalTo(self)
      $0.height.equalTo(25)
    }
    
    handler.snp.makeConstraints {
      $0.centerX.centerY.equalTo(handleArea)
      $0.width.equalTo(40)
      $0.height.equalTo(5)
    }
    
    smartKeyLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.leading.equalTo(self).offset(40)
    }
    
    onLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.leading.equalTo(smartKeyLabel.snp.trailing).offset(10)
    }
    
    boltIcon.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.trailing.equalTo(openOneSecondLabel.snp.leading).offset(-10)
      $0.centerY.equalTo(openOneSecondLabel)
    }
    
    openOneSecondLabel.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom)
      $0.trailing.equalTo(rightChevronIcon.snp.leading).offset(-5)
    }
    
    rightChevronIcon.snp.makeConstraints {
      $0.top.equalTo(handleArea.snp.bottom).offset(-3)
      $0.trailing.equalTo(self).offset(-40)
    }
    
    returnButton.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(20)
      $0.leading.equalTo(self).offset(20)
      $0.height.equalTo(60)
      $0.width.equalTo(100)
    }
    
    lockView.snp.makeConstraints {
      $0.top.equalTo(smartKeyLabel.snp.bottom).offset(20)
      $0.leading.equalTo(returnButton.snp.trailing).offset(20)
      $0.trailing.equalTo(self).offset(-40)
      $0.height.equalTo(60)
      $0.width.equalTo(200)
    }
    
    lockStackView.snp.makeConstraints {
      $0.centerY.equalTo(lockView)
      $0.centerX.equalTo(lockView)
      //      $0.leading.equalTo(lockView).offset(30)
    }
  }
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case returnButton:
      print("returnButton button press")
    case lockButton:
      print("lockButton button press")
    case unlockButton:
      print("unlockButton button press")
    default:
      print("error")
    }
  }
}
