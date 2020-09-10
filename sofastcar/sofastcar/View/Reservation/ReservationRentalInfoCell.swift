//
//  ReservationRentalInfoCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationRentalInfoCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  lazy var guide = contentView.layoutMarginsGuide
  let padding: CGFloat = 10
  let carFeatureTagArray = ["휘발류", "에어백", "후방감지센서", "블랙박스", "네비게이션"]
  
  weak var delegate: ReservationRentalInfoCellDelegate?
  
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
  
  lazy var detailButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("자세히", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.addTarget(self, action: #selector(tabShowDetailViewButton), for: .touchUpInside)
    return button
  }()
  
  let contentTextView: UITextView = {
    let textView = UITextView()
    let infoText = " 로딩중입니다... "
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    textView.attributedText = .attributedStringWithLienSpacing(text: infoText, font: font)
    textView.isEditable = false
    textView.isScrollEnabled = false
    textView.isSelectable = false
    textView.textColor = .systemGray
    return textView
  }()
  
  lazy var questionImageButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    button.addTarget(self, action: #selector(tabShowDetailViewButton), for: .touchUpInside)
    return button
  }()
  // MARK: - CarInfo CollectionView
  let carFeatureTagColletionView: UICollectionView = {
    let layout = LeftAlignedCollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  // MARK: - usingSocarZone UI
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
  // MARK: - Cancel Button UI
  lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle("예약 취소하기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    button.backgroundColor = .white
    button.setTitleColor(.gray, for: .normal)
    button.addTarget(self, action: #selector(tapReservationCancelButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - configure
  func configureCell(cellType: RentalCellType) {
    sectionTitleLabel.text = cellType.rawValue
    switch cellType {
    case .usingTime:
      usingTimeCellUI()
      configureUsingTimeCellContent()
      configureContentViewTopBottomLayer()
    case .rentCarInfo:
      configureTagCollectionViewInRentCar()
      rentCarInfoCellUI()
      configureRentCarInfoCellContent()
      configureContentViewTopBottomLayer()
    case .socarZone:
      usingSocarZoneCellUI()
    case .otherDriver:
      otherDriverCellUI()
      configureOtherDriverCellContent()
      configureContentViewTopBottomLayer()
    case .insurance:
      insuranceCellUI()
      configureInsuranceCellContent()
      configureContentViewTopBottomLayer()
    case .cancelWarning:
      cancelWarningCellUI()
      configureCancelWarningCellContent()
      configureContentViewBottomLayer()
    case .cancel:
      cancellCellUI()
    case .blank:
      configureContentViewTopBottomLayer()
    }
  }
  
  // MARK: - Setting UI
  private func usingTimeCellUI() {
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
  
  private func configureUsingTimeCellContent() {
    contentTitleLabel.text = "총 1일 10분 이용"
    contentLabel.text = "08/14 (금) 14:00 - 08/15 (토) 14:10"
  }
  
  private func configureTagCollectionViewInRentCar() {
    carFeatureTagColletionView.dataSource = self
    carFeatureTagColletionView.delegate = self
    carFeatureTagColletionView.backgroundColor = .white
    carFeatureTagColletionView.register(ReservationConfirmCVCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  private func rentCarInfoCellUI() {
    [sectionTitleLabel, contentLabel, detailButton, carFeatureTagColletionView].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    detailButton.snp.makeConstraints {
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    contentLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    let collectionViewLine = carFeatureTagArray.count/4 + 1
    carFeatureTagColletionView.snp.makeConstraints {
      $0.top.equalTo(contentLabel.snp.bottom).offset(padding)
      $0.height.equalTo(30*collectionViewLine)
      $0.leading.bottom.trailing.equalTo(guide)
    }
  }
  
  private func configureRentCarInfoCellContent() {
    contentLabel.text = "57하4455 | 더뉴레이 180 ~ 160원/km"
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
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding*1.5)
      $0.leading.equalTo(guide)
      $0.width.height.equalTo(18)
      $0.bottom.equalTo(guide)
    }
    
    usingSocarZoneLabel.snp.makeConstraints {
      $0.centerY.equalTo(useingSocarZoneImageView.snp.centerY)
      $0.leading.equalTo(useingSocarZoneImageView.snp.trailing).offset(padding/2)
    }
    
    rentLabel.snp.makeConstraints {
      $0.centerY.equalTo(usingSocarZoneLabel.snp.centerY)
      $0.leading.equalTo(usingSocarZoneLabel.snp.trailing).offset(padding/2)
      $0.height.equalTo(useingSocarZoneImageView.snp.height)
      $0.width.equalTo(rentLabel.snp.height).multipliedBy(1.5)
    }
    
    returnLabel.snp.makeConstraints {
      $0.centerY.equalTo(rentLabel.snp.centerY)
      $0.leading.equalTo(rentLabel.snp.trailing).offset(padding/2)
      $0.height.equalTo(useingSocarZoneImageView.snp.height)
      $0.width.equalTo(returnLabel.snp.height).multipliedBy(1.5)
    }
    
    detailButton.snp.makeConstraints {
      $0.centerY.equalTo(returnLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
  }
  
  private func otherDriverCellUI() {
    [sectionTitleLabel, contentTextView].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding/2)
      $0.height.equalTo(30)
      $0.leading.equalTo(guide).offset(-padding/2)
      $0.trailing.bottom.equalTo(guide)
    }
  }
  
  private func configureOtherDriverCellContent() {
    let infoText = "운행 시작 10분 전까지만 동승운전자를 등록할 수 있습니다."
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize-2)
    contentTextView.attributedText = .attributedStringWithLienSpacing(text: infoText, font: font)
    contentTextView.textColor = .gray
  }
  
  private func insuranceCellUI() {
    [sectionTitleLabel, questionImageButton, contentTitleLabel, contentTextView].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    questionImageButton.snp.makeConstraints {
      $0.leading.equalTo(sectionTitleLabel.snp.trailing).offset(padding)
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
      $0.height.width.equalTo(25)
    }
    
    contentTitleLabel.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(contentTitleLabel.snp.bottom).offset(padding/2)
      $0.height.equalTo(75)
      $0.leading.equalTo(guide).offset(-padding/2)
      $0.trailing.bottom.equalTo(guide)
    }
  }
  
  private func configureInsuranceCellContent() {
    let infoText = "쏘카 사고 시, 차량 손해 금액과 관계없이 자기부담금 70만원을 지불하는 상품입니다. 차량 손해 금액 외 발생하는 다른 비용은 별도 청구됩니다."
    let font = UIFont.boldSystemFont(ofSize: CommonUI.contentsTextFontSize-2)
    contentTextView.attributedText = .attributedStringWithLienSpacing(text: infoText, font: font)
    contentTextView.textColor = .gray
  }
  
  private func cancelWarningCellUI() {
    [sectionTitleLabel, detailButton, contentTextView].forEach {
      contentView.addSubview($0)
    }
    
    sectionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guide)
      $0.leading.equalTo(guide)
    }
    
    detailButton.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
    }
    
    contentTextView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding)
      $0.height.equalTo(90)
      $0.leading.equalTo(guide).offset(-padding/2)
      $0.trailing.bottom.equalTo(guide)
    }
  }
  
  private func configureCancelWarningCellContent() {
    let infoText = "쏘카 예약 후 취소 시점에 따라 수수료가 부과될 수 있습니다. 건전한 카쉐어링 문화 조성을 위해 페널티 제도를 운영하고 있습니다. 예약 전 취소수수료 및 페널티(최대 10만원 및 실비) 제도를 반드시 확인해주세요."
    let font = UIFont.boldSystemFont(ofSize: CommonUI.contentsTextFontSize-2)
    contentTextView.attributedText = .attributedStringWithLienSpacing(text: infoText, font: font)
    contentTextView.textColor = .gray
  }
  
  private func cancellCellUI() {
    contentView.backgroundColor = .systemGray6
    contentView.addSubview(cancelButton)
    cancelButton.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(guide)
      $0.height.equalTo(60)
    }
  }
  
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
}

// MARK: - CollectionView DataSource / DelegateFlowLayout
extension ReservationRentalInfoCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return carFeatureTagArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      as? ReservationConfirmCVCell else { fatalError() }
    cell.textLabel.text = carFeatureTagArray[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let charCount = carFeatureTagArray[indexPath.item].count
    return CGSize(width: charCount*10+20, height: 25)
  }
}

// MARK: - Button Action
extension ReservationRentalInfoCell {
  @objc func tapReservationCancelButton() {
    delegate?.tapReservationCancelButton(forCell: self)
  }
  
  @objc func tapChangeOptionButton() {
    delegate?.tapChangeUsingTimeButton(forCell: self)
  }
  
  @objc func tabShowDetailViewButton() {
    guard let currnetSectionTitle = sectionTitleLabel.text else { return }
    delegate?.tapDetailButton(forCell: self, sectionTitle: currnetSectionTitle)
  }
}
