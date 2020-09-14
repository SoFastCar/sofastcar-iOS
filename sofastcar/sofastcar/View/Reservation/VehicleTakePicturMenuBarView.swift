//
//  vehicleTakePicturTableViewCell.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class VehicleTakePicturTableHeaderView: UITableViewHeaderFooterView {
  
  static let identifier = "VehicleTakePicturTableViewHeaderFooterView"
  
  // MARK: - LifeCycle
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Layout
  
  private func setUI() {
    
  }
}
