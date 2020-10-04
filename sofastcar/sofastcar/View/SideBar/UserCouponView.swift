//
//  UserCouponView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserCouponView: UIView {
  // MARK: - Properties
  lazy var safeGuide = self.safeAreaLayoutGuide
  lazy var guide = self.layoutMarginsGuide
  
  let couponBookButton: UIButton = {
    let button = UIButton()
    button.setTitle("쿠폰북", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.backgroundColor = .white
    return button
  }()
  
  let myCouponButton: UIButton = {
    let button = UIButton()
    button.setTitle("내쿠폰", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.backgroundColor = .white
    return button
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    backgroundColor = .systemGray6
    configureTopButton()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureTopButton() {
    [couponBookButton, myCouponButton].forEach {
      addSubview($0)
    }
    
    couponBookButton.snp.makeConstraints {
      $0.top.leading.equalTo(safeGuide)
      $0.height.equalTo(66)
    }
    
    myCouponButton.snp.makeConstraints {
      $0.top.equalTo(safeGuide)
      $0.leading.equalTo(couponBookButton.snp.trailing)
      $0.trailing.equalTo(safeGuide.snp.trailing)
      $0.width.equalTo(couponBookButton.snp.width)
      $0.height.equalTo(66)
    }
  }
}
