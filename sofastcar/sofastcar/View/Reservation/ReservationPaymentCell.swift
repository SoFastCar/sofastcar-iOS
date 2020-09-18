//
//  ReservationPaymentCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationPaymentCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  let padding: CGFloat = 10
  lazy var guide = contentView.layoutMargins
  var notPaidCostShowLabelArray: [UIView] = []
  var isReservationEnd: Bool?
  
  weak var delegate: ReservationPaymentCellDelegte?
  
  let containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.systemGray5.cgColor
    return view
  }()
  
  let sectionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중입니다.."
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let paidCostLabel: UILabel = {
    let label = UILabel()
    label.text = "결제 금액"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray3
    return label
  }()
  
  let paidCost: UILabel = {
    let label = UILabel()
    label.text = "61,110"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize+3)
    label.textColor = .darkGray
    return label
  }()
  
  let paidCostUnitLabel: UILabel = {
    let label = UILabel()
    label.text = "원"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray3
    return label
  }()
  
  let notPaidCostLabel: UILabel = {
    let label = UILabel()
    label.text = "미납 금액"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemPink
    return label
  }()
  
  let plusLabel: UILabel = {
    let label = UILabel()
    label.text = "+"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray3
    return label
  }()
  
  let notPaidCost: UILabel = {
    let label = UILabel()
    label.text = "2,950"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize+3)
    label.textColor = .systemPink
    return label
  }()
  
  let notPaidCostUnitLabel: UILabel = {
    let label = UILabel()
    label.text = "원"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemPink
    return label
  }()
  
  lazy var abountCostButton: UIButton = {
    let button = UIButton()
    button.setTitle("로딩중입니다...", for: .normal)
    button.setTitleColor(.systemGray, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    button.backgroundColor = .white
    button.layer.borderColor = UIColor.systemGray3.cgColor
    button.layer.borderWidth = 1
    button.addTarget(self, action: #selector(tapAbountCostButton), for: .touchUpInside)
    return button
  }()
  
  lazy var showReceiptButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("영수증 보기", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.addTarget(self, action: #selector(tapShowReceiptButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: - before Driving Cost UI
  let totalCostLabel: UILabel = {
    let label = UILabel()
    label.text = "58,270 원"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let spView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    view.alpha = 0.5
    return view
  }()
  
  let mainCostTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "대여요금"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let mainCostLabel: UILabel = {
    let label = UILabel()
    label.text = "34,470 원"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let insuranceCostTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "면책상품 요금"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let subInfoLabelLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중입니다.."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize-1)
    label.textColor = .systemGray
    return label
  }()
  
  let insuranceCostLabel: UILabel = {
    let label = UILabel()
    label.text = "7,600 원"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let couponLabel: UILabel = {
    let label = UILabel()
    label.text = "쿠폰적용"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let couponCostLabel: UILabel = {
    let label = UILabel()
    label.text = "-20,600 원"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = CommonUI.mainBlue
    return label
  }()

  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .white
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - configure
  func configureCell(cellType: PaymentCellType) {
    sectionTitleLabel.text = cellType.rawValue
    switch cellType {
    case .blank:
      break
    case .serviceTotalCost:
      serviceTotalCostCellUI()
      serviceTotalCostCellContent()
    case .beforeCost:
      beforeCostCellUI()
      beforeCostContent()
    case .afterCost:
      afterCostCellUI()
      afterCostCellContent()
    }
  }
  
  // MARK: - configure Cell UI
  
  private func serviceTotalCostCellUI() {
    contentView.backgroundColor = .systemGray6
    contentView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    containerView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    let containerGuide = containerView.layoutMarginsGuide
    
    contentView.addSubview(containerView)
    containerView.snp.makeConstraints {
      $0.top.bottom.equalTo(contentView)
      $0.leading.trailing.equalTo(guide)
    }
    
    [sectionTitleLabel, showReceiptButton, paidCostLabel, paidCost, paidCostUnitLabel, abountCostButton].forEach {
      containerView.addSubview($0)
    }
    
    [plusLabel, notPaidCostLabel, notPaidCost, notPaidCostUnitLabel].forEach {
      containerView.addSubview($0)
      notPaidCostShowLabelArray.append($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(containerGuide)
    }
    
    showReceiptButton.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(containerGuide)
    }
    
    paidCostLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(containerGuide)
    }
    
    paidCostUnitLabel.snp.makeConstraints {
      $0.bottom.equalTo(paidCostLabel)
      $0.trailing.equalTo(containerGuide)
    }
    
    paidCost.snp.makeConstraints {
      $0.bottom.equalTo(paidCostLabel)
      $0.trailing.equalTo(paidCostUnitLabel.snp.leading).offset(-5)
    }
    
    notPaidCostLabel.snp.makeConstraints {
      $0.top.equalTo(paidCostLabel.snp.bottom).offset(15)
      $0.leading.equalTo(containerGuide)
    }
    
    notPaidCostUnitLabel.snp.makeConstraints {
      $0.bottom.equalTo(notPaidCostLabel)
      $0.trailing.equalTo(containerGuide)
    }
    
    notPaidCost.snp.makeConstraints {
      $0.bottom.equalTo(notPaidCostLabel)
      $0.trailing.equalTo(notPaidCostUnitLabel.snp.leading).offset(-5)
    }
    
    plusLabel.snp.makeConstraints {
      $0.centerY.equalTo(notPaidCost.snp.centerY)
      $0.trailing.equalTo(notPaidCost.snp.leading).offset(-5)
    }
    
    abountCostButton.snp.makeConstraints {
      $0.top.equalTo(notPaidCostLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(containerGuide)
      $0.height.equalTo(50)
      $0.bottom.equalTo(containerGuide)
    }
  }
  
  private func serviceTotalCostCellContent() {
    guard let isReservationEnd = isReservationEnd else { return }
    let titleTest = isReservationEnd ? "이용내역서 메일 보내기" : "미납금액 결제하기"
    abountCostButton.setTitle(titleTest, for: .normal)
    if isReservationEnd {
      notPaidCostShowLabelArray.forEach {
        $0.snp.makeConstraints {
          $0.height.equalTo(0)
        }
      }
    }
  }
  
  private func beforeCostCellUI() {
    [sectionTitleLabel, totalCostLabel, spView, mainCostTitleLabel, mainCostLabel,
     insuranceCostTitleLabel, insuranceCostLabel, subInfoLabelLabel, couponLabel, couponCostLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    totalCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    spView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding*2)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    mainCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(spView.snp.bottom).offset(padding*2)
      $0.leading.equalTo(guide)
    }
    
    mainCostLabel.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(mainCostTitleLabel.snp.centerY)
    }
    
    insuranceCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(mainCostTitleLabel.snp.bottom).offset(padding*2)
      $0.leading.equalTo(guide)
    }
    
    insuranceCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(insuranceCostTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    subInfoLabelLabel.snp.makeConstraints {
      $0.top.equalTo(insuranceCostTitleLabel.snp.bottom).offset(padding/2)
      $0.leading.equalTo(guide)
    }
    
    couponLabel.snp.makeConstraints {
      $0.top.equalTo(subInfoLabelLabel.snp.bottom).offset(padding*2)
      $0.leading.equalTo(guide)
      $0.bottom.equalTo(guide)
    }
    
    couponCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(couponLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    configureContentViewTopBottomLayer()
  }
  
  private func beforeCostContent() {
    subInfoLabelLabel.text = "자기부담금 70만원"
  }
  
  private func afterCostCellUI() {
    [sectionTitleLabel, totalCostLabel, spView, mainCostTitleLabel, mainCostLabel,
    subInfoLabelLabel, couponLabel, couponCostLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    totalCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    spView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding*2)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    mainCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(spView.snp.bottom).offset(padding*2)
      $0.leading.equalTo(guide)
    }
    
    mainCostLabel.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(mainCostTitleLabel.snp.centerY)
    }
    
    subInfoLabelLabel.snp.makeConstraints {
      $0.top.equalTo(mainCostLabel.snp.bottom).offset(padding/2)
      $0.leading.equalTo(guide)
      $0.bottom.equalTo(guide)
    }
    configureContentViewTopLayer()
  }
  
  private func afterCostCellContent() {
    mainCostTitleLabel.text = "주행요금"
    totalCostLabel.text = "35,220 원"
    subInfoLabelLabel.text = "총 주행거리 300km"
  }
  // MARK: - For Cell Line
  private func configureContentViewTopBottomLayer() {
    configureContentViewTopLayer()
    configureContentViewBottomLayer()
  }
  
  private func configureContentViewTopLayer() {
    let view = UIView()
    view.backgroundColor = .systemGray4
    contentView.addSubview(view)
    view.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(contentView)
      $0.height.equalTo(0.7)
    }
  }

  private func configureContentViewBottomLayer() {
    let view = UIView()
    view.backgroundColor = .systemGray4
    contentView.addSubview(view)
    view.snp.makeConstraints {
      $0.bottom.leading.trailing.equalTo(contentView)
      $0.height.equalTo(0.7)
    }
  }
  
  // MARK: - Button Action
  @objc private func tapAbountCostButton() {
    guard let isReservationEnd = isReservationEnd else { return }
    if isReservationEnd {
      delegate?.tapSendEmailButton(forCell: self)
    } else {
      delegate?.tapCompleteNotPaidCostButton(forCell: self)
    }
  }
  
  @objc private func tapShowReceiptButton() {
    delegate?.tapShowReceiptButton(forCell: self)
  }
}
