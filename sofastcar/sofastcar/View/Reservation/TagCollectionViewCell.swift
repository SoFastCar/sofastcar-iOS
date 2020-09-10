//
//  TagCollectionViewCell.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class TagCollectionViewCell: UICollectionViewCell {
  static let identifier = "TagCollectionViewCell"
  
  var tagString: String? {
    didSet {
      tagLabel.text = tagString
    }
  }
  
  fileprivate let tagLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = CommonUI.mainDark
    label.textColor = UIColor.black.withAlphaComponent(0.6)
    
    return label
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  // MARK: - Layout
  
  fileprivate func setUI() {
    self.layer.borderWidth = 1
    self.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    
    [tagLabel].forEach {
      self.addSubview($0)
    }
    
    tagLabel.snp.makeConstraints {
      $0.centerX.centerY.equalTo(self)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
