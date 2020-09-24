//
//  UserDefaultCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserDefaultCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "UserDetaultCell"
  lazy var guide = contentView.layoutMarginsGuide

  let menuLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let detailButtomImage: UIImageView = {
    let imageView = UIImageView()
    let sfimageconfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: CommonUI.contentsTextFontSize), scale: .medium)
    imageView.image = UIImage(systemName: "chevron.right", withConfiguration: sfimageconfig)
    return imageView
  }()
  
  // MARK: - Life cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    configuerLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configuerLayout() {
    [menuLabel, detailButtomImage].forEach {
      contentView.addSubview($0)
    }
    
    menuLabel.snp.makeConstraints {
      $0.leading.equalTo(guide)
      $0.centerY.equalTo(contentView.snp.centerY)
    }
    
    detailButtomImage.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(menuLabel.snp.centerY)
    }
  }
}
