//
//  SideBarCustomCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SideBarCustomCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  lazy var guide = contentView.layoutMarginsGuide
  
  let sectionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중입니다.."
    label.textColor = .black
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let subtextLabel: UILabel = {
    let label = UILabel()
    label.text = "미구독중"
    label.textColor = .systemGray4
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.isHidden = true
    return label
  }()
  
  let separateLineView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func cellConfigure(cellType: SideBarMenuType) {
    sectionTitleLabel.text = cellType.rawValue
    switch cellType {
    case .eventBannerCell:
      contentView.backgroundColor = .systemGray4
    case .socarPassCell:
      subtextLabel.isHidden = false
    case .customerCenterCell:
      addSeparateViewAtTop()
      changeFontSizeAndColor()
    case .mainBoardCell:
      changeFontSizeAndColor()
    case .usingHistocyCell, .couponCell, .evnetWithBenigitCell, .socarPlusCell, .inviteFriendCell:
      break
    }
  }
  
  private func configureLayout() {
    [sectionTitleLabel, subtextLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.leading.equalTo(guide)
      $0.centerY.equalTo(guide.snp.centerY)
    }
    
    subtextLabel.snp.makeConstraints {
      $0.leading.equalTo(sectionTitleLabel.snp.trailing).offset(10)
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
    }
  }
  
  private func changeFontSizeAndColor() {
    sectionTitleLabel.textColor = .systemGray
    sectionTitleLabel.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
  }
  
  private func addSeparateViewAtTop() {
    contentView.addSubview(separateLineView)
    separateLineView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(1)
    }
  }
}
