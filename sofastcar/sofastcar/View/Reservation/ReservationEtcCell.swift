//
//  ReservationEtcCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/12.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationEtcCell: UITableViewCell {
  static let identifier = "EtcCell"
  weak var delegate: ReservationEtcCellDelegate?
  lazy var guide = contentView.layoutMarginsGuide
  
  lazy var etcCellButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .white
    button.layer.borderColor = UIColor.systemGray5.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(tapEtcCellButton), for: .touchUpInside)
    return button
  }()
  
  let buttonNameLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중..."
    label.textColor = .darkGray
    return label
  }()
  
  let rightSideImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = .darkGray
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  
    contentView.backgroundColor = .systemGray6
    layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    [etcCellButton, buttonNameLabel, rightSideImage].forEach {
      contentView.addSubview($0)
    }
    
    etcCellButton.snp.makeConstraints {
      $0.top.bottom.equalTo(self)
      $0.leading.equalTo(guide).offset(-10)
      $0.trailing.equalTo(guide).offset(10)
    }
    
    buttonNameLabel.snp.makeConstraints {
      $0.centerY.equalTo(etcCellButton.snp.centerY)
      $0.leading.equalTo(etcCellButton).offset(20)
    }
    
    rightSideImage.snp.makeConstraints {
      $0.centerY.equalTo(etcCellButton.snp.centerY)
      $0.trailing.equalTo(etcCellButton).offset(-20)
    }
  }
  
  @objc private func tapEtcCellButton() {
    guard let cellType = buttonNameLabel.text else { return }
    if cellType == EtcCellType.usingPdfDownLoad.rawValue {
      delegate?.tapDownLoadReceipforPDF(forCell: self)
    } else if cellType == EtcCellType.washingCarHistory.rawValue {
      delegate?.tapShowWashingHistory(forCell: self)
    } else if cellType == EtcCellType.contectCustomerCenter.rawValue {
      delegate?.tapContectCustomerCenter(forCell: self)
    }
  }
}
