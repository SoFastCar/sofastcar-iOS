//
//  VehicleCheckView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleCheckView: UIScrollView {
  fileprivate let contentView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
 
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  fileprivate func setUI() {
    
    setScrollView()
    setConstraints()
  }
  
  fileprivate func setScrollView() {
    
    self.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
    )
    self.addSubview(contentView)
    
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 {
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    
    self.contentSize = .init(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 44
    )
    contentView.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 144
    )
  }
  
  fileprivate func setConstraints() {
    
    [].forEach {
      contentView.addSubview($0)
    }
  }
}
