//
//  ReservationConfirmCVCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationConfirmCVCell: UICollectionViewCell {
 
  let textLabel: UILabel = {
    let label = UILabel()
    label.textColor = .darkGray
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 12)
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .systemGray5
    contentView.layer.cornerRadius = 30
    addSubview(textLabel)
    textLabel.translatesAutoresizingMaskIntoConstraints = false
    textLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    textLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
