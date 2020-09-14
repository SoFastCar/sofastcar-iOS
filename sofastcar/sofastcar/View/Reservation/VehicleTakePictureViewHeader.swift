//
//  VehicleTakePictureViewHeader.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleTakePictureViewHeader: UICollectionReusableView {
  
  static let identifier = "VehicleTakePictureViewHeader"
  fileprivate let cellIdentifier = "menuBar"
  
  fileprivate lazy var menuBar: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
    
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
    self.backgroundColor = .cyan
    
    [menuBar].forEach {
      self.addSubview($0)
    }
    
    menuBar.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension VehicleTakePictureViewHeader: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
 
    cell.backgroundColor = .magenta
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension VehicleTakePictureViewHeader: UICollectionViewDelegate {
  
}
