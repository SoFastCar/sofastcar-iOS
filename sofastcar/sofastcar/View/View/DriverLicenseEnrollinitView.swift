//
//  DriverLicenseEnrollinitView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class DriverLicenseEnrollinitView: UIView {

  // MARK: - Properties
  let backButton: UIButton = {
    let button = UIButton()
    let attributeImage = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
    let leftChevronImage = UIImage(systemName: "xmark", withConfiguration: attributeImage)
    button.setImage(leftChevronImage, for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let mainTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "운전면허를 등록해주세요"
    label.font = .boldSystemFont(ofSize: 25)
    label.textColor = CommonUI.mainDark
    return label
  }()
  
  let driverExampleImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "DriverLicenseExample")
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "이렇게 찍어주세요"
    label.font = .boldSystemFont(ofSize: 18)
    label.textColor = CommonUI.mainDark
    return label
  }()
  
  let subTitleTextView: UITextView = {
    let textView = UITextView()
    textView.text = """
    •  파란색 영역에 맞춰주세요.
    •  카메라 초점을 잘 맞춰주세요.
    •  어두운 배경에서 빛반사 없이 찍어주세요
    """
    textView.font = .systemFont(ofSize: 18)
    textView.textColor = .systemGray2
    return textView
  }()
  
  let driverAuthCompleteButton: LoginCompleteButton = {
    let button = LoginCompleteButton(frame: .zero, title: "입력 완료")
    button.isEnabled = true
    return button
  }()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    configureLayout()
    
    settingAuthCompleteButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    [backButton, mainTitleLabel, driverExampleImage, titleLabel, subTitleTextView].forEach {
      addSubview($0)
    }
    
    let safe = safeAreaLayoutGuide
    layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let guide = layoutMarginsGuide
    backButton.snp.makeConstraints {
      $0.leading.top.equalTo(safe).offset(10)
    }
    
    mainTitleLabel.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
    }
    
    driverExampleImage.snp.makeConstraints {
      $0.top.equalTo(mainTitleLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(230)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(driverExampleImage.snp.bottom).offset(50)
      $0.leading.trailing.equalTo(guide)
    }
    
    subTitleTextView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(15)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(100)
    }
  }
  
  private func settingAuthCompleteButton() {
    addSubview(driverAuthCompleteButton)
    driverAuthCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
      $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
}
