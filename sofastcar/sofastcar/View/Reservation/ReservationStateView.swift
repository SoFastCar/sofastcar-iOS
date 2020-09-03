//
//  reservationStateView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationStateView: UIScrollView {
  // MARK: - Attribute
  
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
    self.backgroundColor = CommonUI.mainBlue
    self.layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    self.layer.cornerRadius = 5
    
    setConstraints()
  }
  
  fileprivate func setConstraints() {}
  
  // MARK: - Action
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("did tap reservationStateView")
  }
  
}
