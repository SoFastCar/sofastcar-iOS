//
//  UserDefaultCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserDetailCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "UserDetailCell"
  lazy var guide = contentView.layoutMarginsGuide
  weak var delegate: UserDetailCellDelegate?

  let menuLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let detailButtomImage: UIImageView = {
    let imageView = UIImageView()
    let sfimageconfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: CommonUI.contentsTextFontSize), scale: .medium)
    imageView.image = UIImage(systemName: "chevron.right", withConfiguration: sfimageconfig)
    imageView.tintColor = .black
    return imageView
  }()
  
  let logoutButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그아웃", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray5.cgColor
    button.backgroundColor = .white
    return button
  }()
  
  // MARK: - Life cycle
  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, cellType: String) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    menuLabel.text = cellType
    if cellType == "로그아웃" {
      backgroundColor = .systemGray6
      configureButtonCell()
      logoutButton.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
    } else if cellType == "" {
      
    } else if cellType == "앱 버전" {
      configureLayout()
      configureContentViewBottomLayer()
    } else {
      configureLayout()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureButtonCell() {
    addSubview(logoutButton)
    logoutButton.snp.makeConstraints {
      $0.top.bottom.equalTo(safeAreaLayoutGuide)
      $0.leading.equalTo(safeAreaLayoutGuide).offset(20)
      $0.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
    }
  }
  
  private func configureLayout() {
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
  
  // MARK: - Button Action
  @objc private func tapLogoutButton() {
    delegate?.tapLogoutButton(forCell: self)
  }
}
