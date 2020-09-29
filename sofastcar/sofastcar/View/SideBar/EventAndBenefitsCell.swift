//
//  EventAndBenefitsCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class EventAndBenefitsCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "EventAndBenefitsCell"
  lazy var guide = contentView.layoutMarginsGuide
  
  let myImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.backgroundColor = .white
    return imageView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let durationLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    label.textColor = .gray
    return label
  }()
  
  let infoLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    label.textColor = .gray
    return label
  }()
  
  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    configuerLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure Layout
  private func configuerLayout() {
    [myImageView, titleLabel, durationLabel, infoLabel].forEach {
      addSubview($0)
    }
    
    myImageView.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(guide)
      $0.width.height.equalTo(80)
    }
    
    durationLabel.snp.makeConstraints {
      $0.centerY.equalTo(myImageView.snp.centerY)
      $0.leading.equalTo(myImageView.snp.trailing).offset(10)
    }
    
    titleLabel.snp.makeConstraints {
      $0.bottom.equalTo(durationLabel.snp.top).offset(-3)
      $0.leading.equalTo(durationLabel.snp.leading)
    }
    
    infoLabel.snp.makeConstraints {
      $0.top.equalTo(durationLabel.snp.bottom).offset(3)
      $0.leading.equalTo(durationLabel.snp.leading)
    }
  }
  
  func configureCellContent(eventAndBenefit: EventBenifits) {
    titleLabel.text = eventAndBenefit.title
    durationLabel.text = eventAndBenefit.duration
    infoLabel.text = eventAndBenefit.info
  }
}
