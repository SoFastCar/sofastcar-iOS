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
  var socarSaveUIList: [UIView] = []
  var electronicUIList: [UIView] = []
  
  var safetyOptions: [String] = []
  
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
  
  let carImage: CustomImageView = {
    let imageView = CustomImageView()
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
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextViewFontSize)
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
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextViewFontSize)
    let attrText = NSAttributedString.attributedStringWithLienSpacing(text: text, font: font)
    label.attributedText = attrText
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
    let font = UIFont.systemFont(ofSize: CommonUI.contentsTextViewFontSize)
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
  init(frame: CGRect, isElecticCar: Bool, isBurom: Bool, isSocarSaveCar: Bool) {
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
    checkIsElectronicCar(isElecticCar)
    checkIsburumService(isBurom)
    checkIsSocarSave(isSocarSaveCar)
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
    [carName, collectionView].forEach {
      addSubview($0)
    }
    
    [socarSaveInfoLabel, socarSaveInfoButton].forEach {
      addSubview($0)
      socarSaveUIList.append($0)
    }
    
    carName.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
      $0.height.equalTo(15)
    }
    print(carName.snp.height)
    
    socarSaveInfoLabel.snp.makeConstraints {
      $0.top.equalTo(carName.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(15)
    }
    
    socarSaveInfoButton.snp.makeConstraints {
      $0.centerY.equalTo(socarSaveInfoLabel.snp.centerY)
      $0.trailing.equalTo(guide)
      $0.height.equalTo(15)
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
      electronicUIList.append($0)
    }
    
    electronicCarUsingTitle.snp.makeConstraints {
      $0.top.equalTo(carImageContainerView.snp.bottom).offset(30)
      $0.leading.equalTo(guide).offset(3)
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
      $0.height.equalTo(90)
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
    return safetyOptions.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
      as? ReservationConfirmCVCell else { fatalError() }
    cell.textLabel.text = safetyOptions[indexPath.item]
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let charCount = safetyOptions[indexPath.item].count
    return CGSize(width: charCount*10+20, height: 25)
  }
  
  private func checkIsSocarSave(_ isSocarSaveCar: Bool) {
    guard !isSocarSaveCar else { return }
    socarSaveUIList.forEach {
      $0.isHidden = true
      $0.snp.updateConstraints {
        $0.height.equalTo(0)
      }
    }
  }
  
  private func checkIsElectronicCar(_ isElecticCar: Bool) {
    guard !isElecticCar else { return }
    electronicUIList.forEach {
      $0.isHidden = true
      $0.snp.updateConstraints {
        $0.height.equalTo(0)
      }
    }
  }
  
  private func checkIsburumService(_ isBurum: Bool) {
    guard !isBurum else { return }
    burumLabel.isHidden = true
  }
}
