//
//  PaymentConfirmCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class PaymentConfirmCell: UITableViewCell {
  static let identifier = "paymentCell"
  weak var delegate: PaymentConfirmCellDelegate?
  lazy var guide = contentView.layoutMarginsGuide
  enum MyPaymentCellType: String {
    case detailCostCell = "상세요금"
    case paymentCardCell = "결제카드"
    case warningBeforeReservationCell = "예약 전 주의사항"
    case agreeAllTerms = "약관동의"
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
  // MARK: - detailCellUI
  let rentalCostTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "대여요금"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize, weight: .light)
    label.textColor = .darkGray
    return label
  }()
  
  let rentalCostLabel: UILabel = {
    let label = UILabel()
    label.text = "34,470원"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let insuranceCostTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "면책상품 요금"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize, weight: .light)
    label.textColor = .darkGray
    return label
  }()
  
  let insuranceCostLabel: UILabel = {
    let label = UILabel()
    label.text = "7,600원"
    label.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let spView1: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    view.alpha = 0.5
    return view
  }()
  
  let discountTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "할인 수단"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let spView2: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray4
    view.alpha = 0.5
    return view
  }()
  
  let creditTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "크래딧"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let creditDetailInfoButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let creditAmoutLabel: UILabel = {
    let label = UILabel()
    label.text = "크래딧이 없습니다."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray4
    return label
  }()
  
  // MARK: - CardCell
  let cardInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중...."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize, weight: .light)
    label.textColor = .darkGray
    return label
  }()
    
  let waringBeforeConfirmInfoLabel: UITextView = {
    let textView = UITextView()
    let infoText = """
    쏘카 예약 후 취소 시점에 따라 수수료가 부과될 수 있습니다. 예약 전 취소 수수료 및 패널티(최대 10만원 및 실비) 제도를 반드시 확인해주세요. 또한 반납후 결제되지 않은 요금에 대해서는 등록된 결제카드로 또는 일부 금액이 결제될 수 있습니다.
    """
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    textView.attributedText = .attributedStringWithLienSpacing(text: infoText, font: font)
    textView.isEditable = false
    textView.isScrollEnabled = false
    textView.isSelectable = false
    textView.textColor = .systemGray
    return textView
  }()
  // MARK: - AgreeCellUI
  var customerAgreeButtonArray: [UIButton] = []  // StackView buttonAction 연결을 위한 배열
  let essensialAgreeList: [String] = [
    "(필수) 쏘카 자동차대여 약관", "(필수) 쏘카 차량손해면책제도 이용약관", "(필수) 개인정보 수집 및 이용 동의",
    "(필수) 개인저옵 제3자 제공 동의"
  ]
  
  let stackViewContinerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.systemGray4.cgColor
    view.layoutMargins = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
    return view
  }()
  
  lazy var stackView: UIStackView = {
    let view = UIStackView(arrangedSubviews: customerAgreeButtonArray)
    view.backgroundColor = .white
    view.distribution = .equalSpacing
    view.alignment = .leading
    view.axis = .vertical
    return view
  }()
  
  lazy var customAuthAllAgreeButton: TouButton = {
    let button = TouButton(title: " 예약 정보 확인 및 모든 약관에 동의합니다.",
                           imageName: "checkmark.circle.fill", textColor: .black, fontSize: 13, style: .touStyle)
    button.addImportantMark()
    if let stringWidth = button.currentAttributedTitle?.size().width {
      let leftInset = (button.frame.width - stringWidth)/2
      button.titleEdgeInsets = .init(top: 0, left: leftInset+65, bottom: 0, right: 0)
    }
    button.backgroundColor = .white
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isSelected = false
    button.addTarget(self, action: #selector(tabAgreeButton(_:)), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
  func configureCellByType(cellType: String) {
    sectionTitleLabel.text = cellType
    switch cellType {
    case MyPaymentCellType.detailCostCell.rawValue:
      configureDeatilCostCellUI()
      configureDetailCostConent()
      configureContentViewBottomLayer()
    case MyPaymentCellType.paymentCardCell.rawValue:
      configureContentViewTopLayer()
      configurePaymentCardCellUI()
      configurePaymentCardCellContent()
      configureContentViewBottomLayer()
    case MyPaymentCellType.warningBeforeReservationCell.rawValue:
      configureContentViewTopLayer()
      configureWaringLabelUI()
      configureWaringContent()
      configureContentViewBottomLayer()
    case MyPaymentCellType.agreeAllTerms.rawValue:
      configureAllAgreeCell()
    default:
      break
    }
  }
  // MARK: - SetUI
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
  
  private func configureDeatilCostCellUI() {
    [sectionTitleLabel, rentalCostTitleLabel, rentalCostTitleLabel, rentalCostLabel,
     insuranceCostTitleLabel, insuranceCostLabel, spView1, discountTitleLabel, changeOptionButton,
     spView2, creditTitleLabel, creditDetailInfoButton, creditAmoutLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide).offset(20)
      $0.leading.equalTo(guide)
    }
    
    rentalCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(15)
      $0.leading.equalTo(guide)
    }
    
    rentalCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(rentalCostTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    insuranceCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(rentalCostTitleLabel.snp.bottom).offset(15)
      $0.leading.equalTo(guide)
    }
    
    insuranceCostLabel.snp.makeConstraints {
      $0.centerY.equalTo(insuranceCostTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    spView1.snp.makeConstraints {
      $0.top.equalTo(insuranceCostTitleLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    discountTitleLabel.snp.makeConstraints {
      $0.top.equalTo(spView1.snp.bottom).offset(30)
      $0.leading.equalTo(guide)
    }
    
    changeOptionButton.snp.makeConstraints {
      $0.centerY.equalTo(discountTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    spView2.snp.makeConstraints {
      $0.top.equalTo(changeOptionButton.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
    
    creditTitleLabel.snp.makeConstraints {
      $0.top.equalTo(spView2.snp.bottom).offset(30)
      $0.leading.equalTo(guide)
      $0.bottom.equalTo(guide).offset(-10)
    }
    
    creditDetailInfoButton.snp.makeConstraints {
      $0.centerY.equalTo(creditTitleLabel.snp.centerY)
      $0.leading.equalTo(creditTitleLabel.snp.trailing).offset(10)
    }
    
    creditAmoutLabel.snp.makeConstraints {
      $0.centerY.equalTo(creditTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
  }
  
  private func configureDetailCostConent() {
  }
  
  private func configurePaymentCardCellUI() {
    [sectionTitleLabel, changeOptionButton, cardInfoLabel].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    changeOptionButton.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    cardInfoLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(10)
      $0.leading.bottom.equalTo(guide)
      $0.height.equalTo(sectionTitleLabel)
    }
  }
  
  private func configurePaymentCardCellContent() {
    cardInfoLabel.text = "국민 / 개인 (등록일 2019/07/13)"
  }
  
  private func configureWaringLabelUI() {
    [sectionTitleLabel, waringBeforeConfirmInfoLabel, changeOptionButton].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    changeOptionButton.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    waringBeforeConfirmInfoLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(10)
      $0.leading.trailing.bottom.equalTo(guide)
      $0.height.equalTo(sectionTitleLabel.snp.height).multipliedBy(4)
    }
  }

  private func configureWaringContent() {
    changeOptionButton.setTitle("자세히", for: .normal)
  }
  
  // MARK: - Handler
  private func configureAllAgreeCell() {
    contentView.backgroundColor = .systemGray6
    self.layer.borderWidth = 0
    contentView.tintColor = .none
    configureAgreeButtonStackView(buttonStrings: essensialAgreeList)
    configureUserAuthAgreeSquareLayout()
    customerAgreeButtonArray.forEach {
      $0.addTarget(self, action: #selector(tabAgreeButton(_:)), for: .touchUpInside)
    }
  }
  
  private func configureAgreeButtonStackView(buttonStrings: [String]) {
    for index in buttonStrings.indices {
      let button = TouButton(title: buttonStrings[index], imageName: "checkmark",
                             textColor: .darkGray, fontSize: 13, style: .touStyle)
      
      button.isSelected = false
      customerAgreeButtonArray.append(button)
      stackView.addArrangedSubview(button)
    }
  }
  
  private func configureUserAuthAgreeSquareLayout() {
    [customAuthAllAgreeButton, stackViewContinerView].forEach {
      contentView.addSubview($0)
    }
    contentView.addSubview(stackView)
    
    customAuthAllAgreeButton.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(50)
    }
    
    stackViewContinerView.snp.makeConstraints {
      $0.top.equalTo(customAuthAllAgreeButton.snp.bottom).offset(-1)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(131)
      $0.bottom.equalTo(guide).offset(-80)
    }
    
    stackView.snp.makeConstraints {
      $0.top.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.leading.equalTo(stackViewContinerView.layoutMarginsGuide)
      $0.bottom.equalTo(stackViewContinerView.layoutMarginsGuide)
    }
  }
  
  // MARK: - Button Action
  @objc func tapChangeOptionButton() {
    guard let cellType = sectionTitleLabel.text else { return }
    switch cellType {
    case MyPaymentCellType.detailCostCell.rawValue:
      delegate?.tabChangeCouponButton(forCell: self)
    case MyPaymentCellType.paymentCardCell.rawValue:
      delegate?.tabChangePaymentCardButton(forCell: self)
    case MyPaymentCellType.warningBeforeReservationCell.rawValue:
      delegate?.tabWarningBeforeConfirmButton(forCell: self)
    default:
      break
    }
  }
  
  @objc func tabAgreeButton(_ sender: TouButton) {
    delegate?.tabAgreeButton(forCell: self, tapedButton: sender)
  }
}
