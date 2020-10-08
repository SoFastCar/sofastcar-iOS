//
//  ReservationConfirmCustomCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationConfirmCustomCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  
  var startDate: Date? {
    didSet {
      configureUsingTiemCellContent()
    }
  }
  var endDate: Date? {
    didSet {
      configureUsingTiemCellContent()
    }
  }
  var insuranceInfo: Insurance? {
    didSet {
      configureinsuranceCellContent()
    }
  }
  var socarZone: SocarZoneData? {
    didSet {
      configureSocarZoneInfoCellContent()
    }
  }
  weak var delegate: ResrvationConfirmCellDelegate?
  
  lazy var guide = contentView.layoutMarginsGuide
  let padding: CGFloat = 10
  
  enum MyTalbleViewCellType: String {
    case insuranceCell = "차량손해면책 상품"
    case usingTiemCell = "이용시간"
    case usingSocarZone = "이용장소"
    case business = "비지니스 예약"
  }
    
  let sectionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "차량손해면책 상품"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  lazy var changeOptionButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("변경하기", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.addTarget(self, action: #selector(tapChangeOptionButton), for: .touchUpInside)
    return button
  }()
  
  let contentTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "라이트"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let contentLabel: UILabel = {
    let label = UILabel()
    label.text = "자기부담금 최대 70만원"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .gray
    return label
  }()
  // MARK: - Using Socar Zone UI
  let useingSocarZoneImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "mSNormalBlue")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let usingSocarZoneLabel: UILabel = {
    let label = UILabel()
    label.text = "잠실여고 후문 주차장"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()

  let rentLabel: UILabel = {
    let label = UILabel()
    label.text = "대여"
    label.textColor = .white
    label.font = .systemFont(ofSize: 11)
    label.textAlignment = .center
    label.backgroundColor = CommonUI.mainBlue
    return label
  }()
  
  let returnLabel: UILabel = {
    let label = UILabel()
    label.text = "반납"
    label.textColor = .white
    label.backgroundColor = .blue
    label.textAlignment = .center
    label.font = .systemFont(ofSize: 11)
    return label
  }()

  lazy var detailButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("자세히", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.addTarget(self, action: #selector(tabShowSocarZoneWebViewButton), for: .touchUpInside)
    return button
  }()
  
  let businessSwitch = UISwitch()
  
  // MARK: - Lify Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func confiure(cellType: TalbleViewCellType) {
    sectionTitleLabel.text = cellType.rawValue
    
    switch cellType {
    case .insuranceCell:
      twoLineWithChangeButton()
      configureinsuranceCellContent()
    case .usingTiemCell:
      twoLineWithChangeButton()
      configureUsingTiemCellContent()
    case .usingSocarZone:
      usingSocarZoneCellUI()
    case .business:
      businessCellUI()
      configureUsingBusinessCellContent()
    case .blank:
      break
    }
  }
  
  // MARK: - Cell UI configure=
  private func twoLineWithChangeButton() {
    [sectionTitleLabel, changeOptionButton, contentTitleLabel, contentLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    changeOptionButton.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(20)
      $0.width.equalTo(60)
    }
    
    contentTitleLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(15)
      $0.leading.equalTo(guide)
    }
    
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(contentTitleLabel.snp.bottom).offset(5)
      $0.leading.bottom.equalTo(guide)
    }
  }
  
  private func usingSocarZoneCellUI() {
    [sectionTitleLabel, useingSocarZoneImageView, usingSocarZoneLabel, rentLabel, returnLabel, detailButton].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    useingSocarZoneImageView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(15)
      $0.leading.equalTo(guide)
      $0.width.height.equalTo(18)
      $0.bottom.equalTo(guide)
    }
    
    usingSocarZoneLabel.snp.makeConstraints {
      $0.centerY.equalTo(useingSocarZoneImageView.snp.centerY)
      $0.leading.equalTo(useingSocarZoneImageView.snp.trailing).offset(5)
    }
    
    rentLabel.snp.makeConstraints {
      $0.centerY.equalTo(usingSocarZoneLabel.snp.centerY)
      $0.leading.equalTo(usingSocarZoneLabel.snp.trailing).offset(5)
      $0.height.equalTo(useingSocarZoneImageView.snp.height)
      $0.width.equalTo(rentLabel.snp.height).multipliedBy(1.5)
    }
    
    returnLabel.snp.makeConstraints {
      $0.centerY.equalTo(rentLabel.snp.centerY)
      $0.leading.equalTo(rentLabel.snp.trailing).offset(5)
      $0.height.equalTo(useingSocarZoneImageView.snp.height)
      $0.width.equalTo(returnLabel.snp.height).multipliedBy(1.5)
    }
    
    detailButton.snp.makeConstraints {
      $0.centerY.equalTo(returnLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
  }
  
  private func businessCellUI() {
    [sectionTitleLabel, contentTitleLabel, contentLabel, businessSwitch].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    businessSwitch.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
    }
    
    contentTitleLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(contentTitleLabel.snp.bottom).offset(3)
      $0.leading.equalTo(guide)
      $0.bottom.equalTo(guide).offset(-100)
    }
  }
  
  // MARK: - ContentView Handler
  private func configureinsuranceCellContent() {
    guard let name = insuranceInfo?.name,
          let guarantee = insuranceInfo?.guarantee else { return }
    contentTitleLabel.text = name
    contentLabel.text = "자기부담금 최대 \(guarantee)만원"
  }
  
  private func configureUsingTiemCellContent() {
    guard let startDate = startDate,
          let endDate = endDate else { return }
    contentTitleLabel.text = Time.getDiffTwoDateValueReturnString(start: startDate, end: endDate)
    contentLabel.text = Time.getStartEndTimeShowLabel(start: startDate, end: endDate)

  }
  
  private func configureSocarZoneInfoCellContent() {
    guard let socarZone = socarZone else { return }
    usingSocarZoneLabel.text = socarZone.name
  }
  
  private func configureUsingBusinessCellContent() {
    contentTitleLabel.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    contentTitleLabel.textColor = .gray
    contentTitleLabel.text = "예약을 비지니스로 기록해두세요."
    contentLabel.text = "이용내역에서 비지니스 예약을 쉽게 확인 할 수 있습니다."
  }
  
  // MARK: - Button Action
  @objc func tapChangeOptionButton() {
    guard let menuTitle = sectionTitleLabel.text else { return }
    if menuTitle == MyTalbleViewCellType.insuranceCell.rawValue {
      delegate?.tapChangeInsuranceButton(forCell: self)
    } else {
      delegate?.tapChangeUsingTime(forCell: self)
    }
  }
  
  @objc func tabShowSocarZoneWebViewButton() {
    delegate?.tapSocarZoneDetailButton(forCell: self)
  }
}
