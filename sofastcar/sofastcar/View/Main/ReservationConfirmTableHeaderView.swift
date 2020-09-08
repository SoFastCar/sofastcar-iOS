//
//  ReservationConfirmTableHeaderView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationConfirmTableHeaderView: UIView {

  // MARK: - Properties
  enum ReservationType: Int {
    case normal = 0
    case socarSave = 1
    case burum
  }
  
  var padding: CGFloat = 10
  var isSocarSaveCar = false
  
  var collectionViewTestArray = ["경유", "에어백", "후방감지센서", "블랙박스", "강한썬텐", "컨디션최고", "∙∙∙"]
  
  let carName: UILabel = {
    let label = UILabel()
    label.text = "아반떼AD"
    label.textColor = .darkGray
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let burumLabel: UILabel = {
    let label = UILabel()
    label.text = "부름"
    label.textColor = CommonUI.mainBlue
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let collectionView: UICollectionView = {
    let layout = LeftAlignedCollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    return UICollectionView(frame: .zero, collectionViewLayout: layout)
  }()
  
  let socarSaveInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "실속형 서비스 쏘카세이브 차량입니다."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let socarSaveInfoButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let carOptionLabel: UILabel = {
    let label = UILabel()
    label.text = "휘발류"
    label.backgroundColor = .systemGray6
    label.font = .systemFont(ofSize: 11, weight: .ultraLight)
    label.textColor = .gray
    label.textAlignment = .center
    label.layoutMargins = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//    label.contentMode =
    return label
  }()
  
  let carImageContainerView = UIView()
  
  let carImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "testCar")
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let electronicCarUsingTitle: UILabel = {
    let label = UILabel()
    label.text = "전기자 이용 안내"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let showElectronicCostWebViewButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let electorinicCarDrivingCostInfoTextView: UITextView = {
    let textView = UITextView()
    let text = """
    다음 이용자를 위해 배터리 잔량을 50% 이상으로 충전하여 반납해주세요. 50% 미만이면 충전제반비용이 결제되고, 50% 이상이면 조건에 따라 보너스 크레딧이 지급됩니다.
    """
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize)
    let attributedString = NSAttributedString.attributedStringWithLienSpacing(text: text, font: font)
    textView.attributedText = attributedString
    textView.textColor = .systemGray
    textView.isSelectable = false
    textView.allowsEditingTextAttributes = false
    textView.isScrollEnabled = false
    return textView
  }()
  
  let carDrivingCostTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "주행요금 130 ~ 160원 /Km"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let showNormalCostInfoButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let carDrivingCostInfoLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    let text = "주행요금은 반납 후 등록하신 결제카드로 자동 결제됩니다.\n주행요금은 거리에 따라 구간별 차등 적용하여 계산됩니다."
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize)
    let attrText = NSAttributedString.attributedStringWithLienSpacing(text: text, font: font)
    label.attributedText = attrText
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let showCarDrivingCostWebViewButton: UIButton = {
    let button = UIButton()
    button.setTitle("주행거리 별 상세 요금 보기", for: .normal)
    button.setTitleColor(.systemGray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 13)
    return button
  }()
  
  let carDrivingCostInfoTextView: UITextView = {
    let textView = UITextView()
    let text = """
    - 주행거리 30km 이하: (km 당 주행요금) 170원
    - 주행거리 30 초과 ~ 100km 이하: (km 당 주행요금)
    - 주행거리 100km 초과: (km 당 주행요금) 130원
    """
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextFontSize)
    let attrText = NSAttributedString.attributedStringWithLienSpacing(text: text, font: font)
    textView.attributedText = attrText
    textView.textColor = .systemGray
    return textView
  }()
  
  let sectionSubtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "라이트"
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  
  let contentsLabel: UILabel = {
    let label = UILabel()
    label.text = "자기 부담금 최대 60 만원"
    label.font = .boldSystemFont(ofSize: 13)
    return label
  }()

  // MARK: - Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = .white
    
    self.layoutMargins = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    let guide = self.layoutMarginsGuide
    configureCollectionView()
    
    configureCarDetailInfoUI(guide)
    configureBurumLabel(guide)
    configureCarImageUI(guide)
    configureElectronucUsingInfoUI(guide)
    configureDrivingCostUI(guide)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = .white
    collectionView.register(ReservationConfirmCVCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  private func configureCarDetailInfoUI(_ guide: UILayoutGuide) {
    [carName, socarSaveInfoLabel, socarSaveInfoButton, collectionView].forEach {
      addSubview($0)
    }
    
    carName.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    socarSaveInfoLabel.snp.makeConstraints {
      $0.top.equalTo(carName.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(carName)
    }
    
    socarSaveInfoButton.snp.makeConstraints {
      $0.centerY.equalTo(socarSaveInfoLabel.snp.centerY)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(carName).multipliedBy(5)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.equalTo(socarSaveInfoLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.trailing.equalTo(guide).offset(-40)
      $0.height.equalTo(50)
    }
  }
  
  private func configureBurumLabel(_ guide: UILayoutGuide) {
    addSubview(burumLabel)
    burumLabel.snp.makeConstraints {
      $0.leading.equalTo(carName.snp.trailing).offset(10)
      $0.centerY.equalTo(carName.snp.centerY)
    }
  }
  
  private func configureCarImageUI(_ guide: UILayoutGuide) {
    addSubview(carImageContainerView)
    carImageContainerView.snp.makeConstraints {
      $0.top.equalTo(collectionView.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(200)
    }
    
    carImageContainerView.addSubview(carImage)
    carImage.snp.makeConstraints {
      $0.centerX.equalTo(carImageContainerView.snp.centerX)
      $0.centerY.equalTo(carImageContainerView.snp.centerY)
      $0.width.equalTo(UIScreen.main.bounds.width*2/3)
    }
  }
  
  private func configureElectronucUsingInfoUI(_ guide: UILayoutGuide) {
    [electronicCarUsingTitle, electorinicCarDrivingCostInfoTextView, showElectronicCostWebViewButton].forEach {
      addSubview($0)
    }
    
    electronicCarUsingTitle.snp.makeConstraints {
      $0.top.equalTo(carImageContainerView.snp.bottom).offset(30)
      $0.leading.equalTo(guide)
      $0.height.equalTo(30)
    }
    
    showElectronicCostWebViewButton.snp.makeConstraints {
      $0.centerY.equalTo(electronicCarUsingTitle.snp.centerY)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(30)
    }
    
    electorinicCarDrivingCostInfoTextView.snp.makeConstraints {
      $0.top.equalTo(electronicCarUsingTitle.snp.bottom).offset(5)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(80)
    }
  }
  
  private func configureDrivingCostUI(_ guide: UILayoutGuide) {
    [carDrivingCostTitleLabel, carDrivingCostInfoLabel, showCarDrivingCostWebViewButton, showNormalCostInfoButton].forEach {
      addSubview($0)
    }
    
    carDrivingCostTitleLabel.snp.makeConstraints {
      $0.top.equalTo(electorinicCarDrivingCostInfoTextView.snp.bottom).offset(30)
      $0.leading.equalTo(guide)
    }
    
    showNormalCostInfoButton.snp.makeConstraints {
      $0.trailing.equalTo(guide)
      $0.centerY.equalTo(carDrivingCostTitleLabel.snp.centerY)
    }
    
    carDrivingCostInfoLabel.snp.makeConstraints {
      $0.top.equalTo(carDrivingCostTitleLabel.snp.bottom).offset(10)
      $0.leading.equalTo(guide)
    }
    
    showCarDrivingCostWebViewButton.snp.makeConstraints {
      $0.top.equalTo(carDrivingCostInfoLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(guide)
    }
  }
}

// MARK: - CollectionView DataSource / DelegateFlowLayout
extension ReservationConfirmTableHeaderView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print("aaa")
    return collectionViewTestArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      as? ReservationConfirmCVCell else { fatalError() }
    cell.textLabel.text = collectionViewTestArray[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let charCount = collectionViewTestArray[indexPath.item].count
    return CGSize(width: charCount*10+20, height: 25)
  }
}
