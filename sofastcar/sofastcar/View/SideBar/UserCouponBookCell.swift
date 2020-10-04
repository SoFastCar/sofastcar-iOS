//
//  UserCouponBookCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class UserCouponBookCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "UserCouponCell"
  lazy var guide = contentView.layoutMarginsGuide
  var couponData: CouponBook?
  
  //kakao_Invite
  let mainImageView = UIImageView()
  let subImageView = UIImageView()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let discriptionLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    label.textColor = .black
    return label
  }()
  
  let usageLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 12)
    label.textColor = .black
    return label
  }()
  
  let sideButton = UIButton()
  
  let showDetailButton = TouButton(title: "상세조건보기", imageName: "chevron.right.circle", textColor: .systemGray2, fontSize: 10, style: .authStyle)
  
  // MARK: - Life cycle
  init(cellType: UserCouponCellType, couponData: CouponBook?) {
    super.init(style: .default, reuseIdentifier: "cell")
    self.couponData = couponData
    configureContentView()
    switch cellType {
    case .inviteFriendsCell:
      configureInviteFriendsUI()
    case .couponCell:
      configureCouponUI()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureContentView() {
    contentView.layer.borderWidth = 1
    contentView.layer.borderColor = UIColor.systemGray4.cgColor
    self.contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 0)
  }
  
  private func configureInviteFriendsUI() {
    [mainImageView, titleLabel, discriptionLabel, subImageView, sideButton].forEach {
      contentView.addSubview($0)
    }
    
    mainImageView.image = UIImage(systemName: "person.badge.plus")
    mainImageView.tintColor = CommonUI.mainBlue
    mainImageView.snp.makeConstraints {
      $0.centerY.leading.equalTo(guide)
      $0.width.height.equalTo(40)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(mainImageView.snp.trailing).offset(10)
      $0.height.equalTo(30)
    }
    titleLabel.text = "1만원 쿠폰x2장"
    
    subImageView.image = UIImage(named: "kakao_Invite")
    subImageView.layer.cornerRadius = 15
    subImageView.clipsToBounds = true
    subImageView.snp.makeConstraints {
      $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
      $0.centerY.equalTo(titleLabel)
      $0.width.height.equalTo(20)
    }
    
    discriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom)
      $0.leading.equalTo(titleLabel)
      $0.height.equalTo(20)
      $0.bottom.equalTo(guide)
    }
    discriptionLabel.text = "친구 초대하고 혜택받으세요!"
    
    sideButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalTo(contentView)
      $0.width.equalTo(40)
    }
    sideButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
    sideButton.imageView?.tintColor = .systemGray4
  }
  
  private func configureCouponUI() {
    guard let couponData = couponData else { return }
    let dotView = DotsLineView()
    
    [mainImageView, titleLabel, discriptionLabel, usageLabel, showDetailButton, dotView, sideButton].forEach {
      contentView.addSubview($0)
    }
    
    mainImageView.image = UIImage(named: "plug")
    mainImageView.tintColor = CommonUI.mainBlue
    mainImageView.snp.makeConstraints {
      $0.leading.equalTo(guide)
      $0.centerY.equalTo(guide)
      $0.width.height.equalTo(40)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(mainImageView.snp.trailing).offset(10)
      $0.height.equalTo(20)
    }
    titleLabel.text = couponData.name
    
    discriptionLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(3)
      $0.leading.equalTo(titleLabel)
      $0.height.equalTo(15)
    }
    discriptionLabel.text = couponData.description
    
    usageLabel.snp.makeConstraints {
      $0.top.equalTo(discriptionLabel.snp.bottom)
      $0.leading.equalTo(titleLabel)
      $0.height.equalTo(15)
    }
    usageLabel.text = couponData.usage
    
    showDetailButton.snp.makeConstraints {
      $0.top.equalTo(usageLabel.snp.bottom)
      $0.leading.equalTo(titleLabel)
      $0.height.equalTo(20)
      $0.bottom.equalTo(guide)
    }
    showDetailButton.isSelected = true
    
    sideButton.snp.makeConstraints {
      $0.top.trailing.bottom.equalTo(contentView)
      $0.width.equalTo(50)
    }
    sideButton.setImage(UIImage(systemName: "tray.and.arrow.down"), for: .normal)
    sideButton.backgroundColor = CommonUI.mainBlue
    sideButton.imageView?.tintColor = .white
    
    dotView.snp.makeConstraints {
      $0.trailing.equalTo(sideButton.snp.leading).offset(-1)
      $0.top.bottom.equalTo(contentView)
      $0.width.equalTo(10)
    }
    dotView.drawVertical(dotView.frame)
  }
}
