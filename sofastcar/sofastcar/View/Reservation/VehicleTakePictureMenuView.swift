//
//  VehicleTakePictureViewHeader.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleTakePictureMenuView: UIView {
  
  static let identifier = "VehicleTakePictureViewHeader"
  
  fileprivate let vehicleOption = [
    "전면",
    "보조석앞면",
    "보조석뒷면",
    "후면",
    "운전석뒷면",
    "운전석앞면"
  ]
  
  fileprivate lazy var menuCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    
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
  
  // MARK: - Layout
  
  private func setUI() {
    self.backgroundColor = .white
    
    [menuCollectionView].forEach {
      self.addSubview($0)
    }
    
    menuCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension VehicleTakePictureMenuView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCollectionViewCell.identifier, for: indexPath) as? MenuCollectionViewCell else { fatalError() }
    
    cell.vehicleImageView.image = UIImage(named: vehicleOption[indexPath.item])
    
    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VehicleTakePictureMenuView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: self.frame.width / 6.0, height: self.frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
