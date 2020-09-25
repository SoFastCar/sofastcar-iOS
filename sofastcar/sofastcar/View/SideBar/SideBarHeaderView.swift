//
//  SideBarHeaderView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SideBarHeaderView: UIView {
  // MARK: - Properties
  lazy var guide = self.layoutMarginsGuide
  var isMain: Bool = false
  let userNameLable: UILabel = {
    let label = UILabel()
    label.text = "사용자 이름"
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 25)
    label.sizeToFit()
    return label
  }()
  
  let userIdLable: UILabel = {
    let label = UILabel()
    label.text = "test@gmail.com"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let userPhoneNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "010-0000-0000"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let userlevelButton: UIButton = {
    let button = UIButton()
    let attributedString = NSMutableAttributedString()
    attributedString.append(NSAttributedString(string: "쏘카클럽 Level 1 >", attributes:
      [NSAttributedString.Key.foregroundColor: CommonUI.mainBlue,
       NSAttributedString.Key.font: UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize-1)]))
    button.setAttributedTitle(attributedString, for: .normal)
    button.backgroundColor = .white
    button.layer.borderColor = CommonUI.mainBlue.cgColor
    button.layer.borderWidth = 1
    return button
  }()
  
  let settingButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "option"), for: .normal)
    button.imageView?.tintColor = .black
    button.imageView?.contentMode = .scaleAspectFit
    return button
  }()

  let notiButton: UIButton = {
    let button = UIButton()
    let imageConfg = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20), scale: .medium)
    button.setImage(UIImage(systemName: "bell", withConfiguration: imageConfg), for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  init(frame: CGRect, isMain: Bool) {
    super.init(frame: frame)
    self.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    configureLayout(isMain)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout(_ isMain: Bool) {
    
    if isMain {
      [userNameLable, userIdLable, userlevelButton, settingButton, notiButton].forEach {
        addSubview($0)
      }
    } else {
      [userNameLable, userIdLable, userPhoneNumberLabel].forEach {
        addSubview($0)
      }
    }
   
    userNameLable.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
      $0.height.equalTo(50)
    }
    
    userIdLable.snp.makeConstraints {
      $0.top.equalTo(userNameLable.snp.bottom).offset(-10)
      $0.leading.equalTo(guide)
    }
    
    if isMain {
      userlevelButton.snp.makeConstraints {
        $0.top.equalTo(userIdLable.snp.bottom).offset(5)
        $0.leading.equalTo(guide)
        $0.bottom.equalTo(guide)
        $0.width.equalTo(140)
        $0.height.equalTo(20)
      }
      
      notiButton.snp.makeConstraints {
        $0.top.equalTo(guide)
        $0.trailing.equalTo(guide)
        $0.width.height.equalTo(30)
      }
      
      settingButton.snp.makeConstraints {
        $0.centerY.equalTo(notiButton.snp.centerY)
        $0.trailing.equalTo(notiButton.snp.leading).offset(-10)
        $0.width.height.equalTo(23)
      }
    } else {
      userPhoneNumberLabel.snp.makeConstraints {
        $0.top.equalTo(userIdLable.snp.bottom).offset(5)
        $0.leading.equalTo(guide)
      }
    }
  }
  
}
