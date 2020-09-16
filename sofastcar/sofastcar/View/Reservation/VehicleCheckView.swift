//
//  VehicleCheckView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

protocol VehicleCheckViewDelegate: class {
    func buttonAction(_ sender: UIButton)
}

class VehicleCheckView: UIScrollView {
  
  weak var customDelegate: VehicleCheckViewDelegate?
  
  var tagArray = [
    "동물털",
    "음식물",
    "흙,먼지,모래",
    "담배 냄새",
    "악취, 쓰레기",
    "끈적임,오염",
    "타인 물품",
    "창문 얼룩"
  ]
  
  fileprivate let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.grayColor
    
    return view
  }()
  
  fileprivate let vehicleCheckStartView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let vehicleCheckStartDescriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "운행 전 외관 촬영"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleCheckStartDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 외관에서 흠집이나 사고 흔적을 발견했다면 반드시 촬영해주세요. 운행이 불가능한 손상이 있다면 고객센터로 문의해주세요."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let vehicleCheckStartSubDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "꼭 해야 하나요"
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let vehicleCheckStartSubDescriptionButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.questionMark.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    button.tintColor = CommonUI.mainDark
    
    return button
  }()
  
  let vehicleCheckStartButton: UIButton = {
    let button = UIButton()
    if UserDefaults.getVehicleBoubleCheck() == true {
      button.setTitle("완료되었습니다.", for: .normal)
      button.setTitleColor(.gray, for: .normal)
      button.backgroundColor = .systemGray6
      button.isEnabled = false
    } else {
      button.setTitle("외관 촬영 시작하기", for: .normal)
      button.backgroundColor = CommonUI.mainBlue
      button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    }
    
    return button
  }()
  
  fileprivate let vehicleCheckTagView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let vehicleCheckTagDescriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "운행 전 추가 확인"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let vehicleCheckTagDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 내부 상태와 관련된 테그를 선택하거나 메모를 남겨주세요. 차량 게시판에 경고등이 들어와있다면 고객센터로 문의해주세요."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let layout = LeftAlignedTagCollectionViewFlowLayout()
  fileprivate lazy var tagCollectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .infinite, collectionViewLayout: layout)
    collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
    collectionView.backgroundColor = .clear
    
    return collectionView
  }()
  
  fileprivate let uncomfortableTextView: UITextView = {
    let textView = UITextView()
    textView.layer.borderWidth = 1
    textView.layer.borderColor = UIColor.black.withAlphaComponent(0.1).cgColor
    textView.text = "불편사항이 태그에 없나요? 메모로 남겨주세요."
    textView.font = UIFont.preferredFont(forTextStyle: .title3)
    textView.textColor = CommonUI.mainDark.withAlphaComponent(0.6)
    textView.textContainerInset = UIEdgeInsets(
      top: 15,
      left: 15,
      bottom: 15,
      right: 15
    )
    
    return textView
  }()
  
  let vehicleCheckTagSubmitButton: UIButton = {
    let button = UIButton()
    button.setTitle("문제가 없습니다", for: .normal)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    
    return button
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    tagCollectionView.dataSource = self
    tagCollectionView.delegate = self
    tagCollectionView.allowsMultipleSelection = true
    layout.minimumLineSpacing = 8
    layout.scrollDirection = .vertical
    uncomfortableTextView.delegate = self
    
    setScrollView()
    setConstraints()
  }
  
  fileprivate func setScrollView() {
    
    self.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
    )
    self.addSubview(contentView)
    
    var heightPadding: CGFloat = 80
    if UIScreen.main.bounds.height < 670 {
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    
    self.contentSize = .init(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 44
    )
    contentView.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 144
    )
  }
  
  fileprivate func setConstraints() {
    let guid = contentView.safeAreaLayoutGuide
    
    [vehicleCheckStartView, vehicleCheckTagView].forEach {
      contentView.addSubview($0)
    }
    
    // vehicleCheckStartView
    vehicleCheckStartView.snp.makeConstraints {
      $0.top.equalTo(guid)
      $0.leading.trailing.equalTo(guid)
      $0.height.equalTo(270)
    }
    vehicleCheckStartConstraints()
    
    // vehicleCheckTagView
    vehicleCheckTagView.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartView.snp.bottom).offset(10)
      $0.leading.trailing.equalTo(guid)
      $0.height.equalTo(1000)
    }
    vehicleCheckTagConstraints()
  }
  
  fileprivate func vehicleCheckStartConstraints() {
    let guid = vehicleCheckStartView.safeAreaLayoutGuide
    
    [
      vehicleCheckStartDescriptionTitleLabel,
      vehicleCheckStartDescriptionLabel,
      vehicleCheckStartSubDescriptionLabel,
      vehicleCheckStartSubDescriptionButton,
      vehicleCheckStartButton
      ].forEach {
        vehicleCheckStartView.addSubview($0)
    }
    
    vehicleCheckStartDescriptionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guid).offset(10)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleCheckStartDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionTitleLabel.snp.bottom).offset(40)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
    
    vehicleCheckStartSubDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(vehicleCheckStartSubDescriptionButton.snp.leading).offset(-5)
      $0.centerY.equalTo(vehicleCheckStartSubDescriptionButton)
    }
    
    vehicleCheckStartSubDescriptionButton.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartDescriptionLabel.snp.bottom).offset(10)
      $0.trailing.equalTo(guid).offset(-20)
    }
    
    vehicleCheckStartButton.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckStartSubDescriptionLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(60)
    }
  }
  
  fileprivate func vehicleCheckTagConstraints() {
    let guid = vehicleCheckTagView.safeAreaLayoutGuide
    
    [
      vehicleCheckTagDescriptionTitleLabel,
      vehicleCheckTagDescriptionLabel,
      tagCollectionView,
      uncomfortableTextView,
      vehicleCheckTagSubmitButton
      ].forEach {
        vehicleCheckTagView.addSubview($0)
    }
    
    vehicleCheckTagDescriptionTitleLabel.snp.makeConstraints {
      $0.top.equalTo(guid).offset(20)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleCheckTagDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckTagDescriptionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
    
    tagCollectionView.snp.makeConstraints {
      $0.top.equalTo(vehicleCheckTagDescriptionLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(150)
    }
    
    uncomfortableTextView.snp.makeConstraints {
      $0.top.equalTo(tagCollectionView.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(100)
    }
    
    vehicleCheckTagSubmitButton.snp.makeConstraints {
      $0.top.equalTo(uncomfortableTextView.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(60)
    }
  }
  
  // MARK: - Action
  
  @objc func buttonAction(_ sender: UIButton) {
    customDelegate?.buttonAction(sender)
  }
}

// MARK: - UICollectionViewDataSource

extension VehicleCheckView: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    tagArray.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { fatalError() }
    
    cell.tagString = tagArray[indexPath.row]
    
    return cell
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VehicleCheckView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let charCount = tagArray[indexPath.item].count
    return CGSize(width: charCount * 10 + 30, height: 35)
  }
  
  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
    guard let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell else { return }
    if cell.backgroundColor == .clear {
      cell.backgroundColor = CommonUI.mainBlue
      cell.tagLabel.textColor = .white
    } else {
      cell.backgroundColor = .clear
      cell.tagLabel.textColor = CommonUI.mainDark
    }
  }
}

// MARK: - UITextViewDelegate

extension VehicleCheckView: UITextViewDelegate {
  // 편집이 시작될때
  func textViewDidBeginEditing(_ textView: UITextView) {
    textViewSetupView()
    self.setContentOffset(
      CGPoint(
        x: 0.0,
        y: 370.0
      ), animated: true
    )
  }
  
  // 편집이 종료될때
  func textViewDidEndEditing(_ textView: UITextView) {
    if textView.text == "" {
      textViewSetupView()
      self.setContentOffset(
        CGPoint(
          x: 0.0,
          y: 0.0
        ), animated: true
      )
    }
  }
  
  // 텍스트가 입력될때
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    // 개행시 최초 응답자 제거
    if text == "\n" {
      textView.resignFirstResponder()
    }
    return true
  }
  
  fileprivate func textViewSetupView() {
    if uncomfortableTextView.text == "불편사항이 태그에 없나요? 메모로 남겨주세요." {
      uncomfortableTextView.text = ""
      uncomfortableTextView.textColor = UIColor.black
      
    } else if uncomfortableTextView.text == "" {
      uncomfortableTextView.text = "불편사항이 태그에 없나요? 메모로 남겨주세요."
      uncomfortableTextView.textColor = UIColor.lightGray
    }
  }
}
