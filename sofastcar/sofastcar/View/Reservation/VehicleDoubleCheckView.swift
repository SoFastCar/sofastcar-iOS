//
//  VehicleDoubleCheckView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleDoubleCheckView: UIView {
  
  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 확인 중에\n혹시 아래와 같은\n파손 흔적을 발견했나요? "
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
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
    
    [titleLabel].forEach {
      self.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(40)
      $0.leading.equalToSuperview()
    }
  }
}
