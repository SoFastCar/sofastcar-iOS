//
//  VehicleTakePictureViewController.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleTakePictureVC: UIViewController {
  
    fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량의 여섯 면을 가이드에 맞춰 촬영해주세요.\n사진 전송 후에는 수정할 수 없습니다."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let layout = UICollectionViewFlowLayout()
  fileprivate lazy var vehicleTakePictureView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .clear
    collectionView.register(VehicleTakePictureViewCell.self, forCellWithReuseIdentifier: VehicleTakePictureViewCell.identifier)
    collectionView.register(VehicleTakePictureViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: VehicleTakePictureViewHeader.identifier)
    collectionView.register(VehicleTakePictureViewFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: VehicleTakePictureViewFooter.identifier)
    
    return collectionView
  }()
  
  fileprivate lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.leftArrow.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = CommonUI.mainDark
    
    return barButtonItem
  }()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  // MARK: - UI
  
  fileprivate func setUI() {
    let guid = view.safeAreaLayoutGuide
    
    self.view.backgroundColor = .white
    setNavigation()
    setCollectionView()
    
    [descriptionLabel, vehicleTakePictureView].forEach {
      view.addSubview($0)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalTo(guid).offset(10)
      $0.leading.equalTo(guid).offset(20)
    }
    
    vehicleTakePictureView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
      $0.trailing.bottom.leading.equalTo(guid)
    }
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    navBar?.prefersLargeTitles = true
    navBar?.backgroundColor = .white
    navBar?.barTintColor = UIColor.white
    
    self.navigationItem.leftBarButtonItem = self.leftNavigationButton
    self.title = "외관 촬영"
  }
  
  fileprivate func setCollectionView() {
    vehicleTakePictureView.dataSource = self
    vehicleTakePictureView.delegate = self
    setFlowLayout()
  }
  
  fileprivate func setFlowLayout() {
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    layout.sectionHeadersPinToVisibleBounds = true
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      dismiss(animated: false, completion: nil)
    default:
      break
    }
  }
}

// MARK: - UICollectionViewDataSource

extension VehicleTakePictureVC: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 6
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleTakePictureViewCell.identifier, for: indexPath) as? VehicleTakePictureViewCell else { fatalError() }
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionFooter {
      let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: VehicleTakePictureViewFooter.identifier, for: indexPath)
      
      return footer
    }
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: VehicleTakePictureViewHeader.identifier, for: indexPath)
    
    return header
  }
}

// MARK: - UICollectionViewDelegate

extension VehicleTakePictureVC: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VehicleTakePictureVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 150)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return .init(width: view.frame.width, height: 150)
  }
}
