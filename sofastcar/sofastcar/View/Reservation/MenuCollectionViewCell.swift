//
//  MenuCollectionViewCell.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class MenuCollectionViewCell: UICollectionViewCell {
  
  static let identifier = "MenuCollectionViewCell"
  
  let vehicleImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "전면")
    imageView.contentMode = .scaleAspectFit
    imageView.alpha = 0.5
    
    return imageView
  }()
  
  // MARK: - LifeCycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Layout
  
  private func setUI() {
    [vehicleImageView].forEach {
      self.addSubview($0)
    }
    
    vehicleImageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}
