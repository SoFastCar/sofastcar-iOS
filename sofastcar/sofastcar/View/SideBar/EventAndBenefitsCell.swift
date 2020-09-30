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
  let imageString = ["Event1", "Event2", "Event3"]

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
  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, cellType: EventAndBenefitsCellType) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 10)
    configuerLayout(cellType: cellType)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure Layout
  private func configuerLayout(cellType: EventAndBenefitsCellType) {
    switch cellType {
    case .title:
      configureTitleLabel()
    case .nomal:
      configureNomalCellType()
      configureContentViewBottomLayer(guide: guide)
    case .expendButton:
      configureExpendButton()
      configureContentViewTopBottomLayer()
    case .blank:
      self.backgroundColor = .systemGray6
    }
  }
  
  private func configureTitleLabel() {
    let sectionitleLabel = UILabel()
    sectionitleLabel.text = "이벤트"
    sectionitleLabel.font = .boldSystemFont(ofSize: 25)

    contentView.addSubview(sectionitleLabel)
    sectionitleLabel.snp.makeConstraints {
      $0.centerY.equalTo(contentView.snp.centerY)
      $0.leading.equalTo(guide)
    }
  }
  
  private func configureNomalCellType() {
    [myImageView, titleLabel, durationLabel, infoLabel].forEach {
      contentView.addSubview($0)
    }
    
    myImageView.snp.makeConstraints {
      $0.centerY.equalTo(guide.snp.centerY)
      $0.leading.equalTo(guide)
      $0.width.height.equalTo(80)
    }
    if let imageName = imageString.randomElement() {
      myImageView.image = UIImage(named: imageName)
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
  
  private func configureExpendButton() {
    let label = UILabel()
    label.text = "진행중 이벤트 더보기"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .gray
    
    contentView.addSubview(label)
    label.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
    }
  }
  
  func configureCellContent(eventAndBenefit: EventBenifits) {
    titleLabel.text = eventAndBenefit.title
    durationLabel.text = eventAndBenefit.duration
    infoLabel.text = eventAndBenefit.info
  }
}
