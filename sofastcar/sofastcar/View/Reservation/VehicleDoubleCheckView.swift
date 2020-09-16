//
//  VehicleDoubleCheckView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleDoubleCheckView: UIView {
  
  fileprivate let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 확인 중에\n혹시 아래와 같은\n파손 흔적을 발견했나요? "
    label.font = UIFont.preferredFont(forTextStyle: .title1).bold()
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    let attrString = NSMutableAttributedString(string: label.text!)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 10
    attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
    label.attributedText = attrString
    
    return label
  }()
  
  fileprivate let layout = UICollectionViewFlowLayout()
  fileprivate lazy var vehicleCheckCollectionView: UICollectionView = {
    let collectionView = UICollectionView(
      frame: .zero,
      collectionViewLayout: layout
    )
    collectionView.register(
      VehicleCheckCell.self,
      forCellWithReuseIdentifier: VehicleCheckCell.identifier
    )
    collectionView.backgroundColor = .magenta
    
    return collectionView
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
    self.backgroundColor = .white
    setCollectionView()
    
    [titleLabel, vehicleCheckCollectionView].forEach {
      self.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(80)
      $0.leading.equalToSuperview().offset(20)
    }
    
    vehicleCheckCollectionView.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
      $0.trailing.equalToSuperview().offset(-20)
      $0.height.equalTo(370)
    }
  }
  
  fileprivate func setCollectionView() {
    vehicleCheckCollectionView.dataSource = self
    
    layout.scrollDirection = .vertical
    layout.itemSize = CGSize(
      width: UIScreen.main.bounds.width / 2.31,
      height: UIScreen.main.bounds.width / 2.31
    )
    layout.sectionInset = UIEdgeInsets(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0
    )
  }
}

// MARK: - UICollectionViewDataSource

extension VehicleDoubleCheckView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleCheckCell.identifier, for: indexPath)
    
    return cell
  }
}
