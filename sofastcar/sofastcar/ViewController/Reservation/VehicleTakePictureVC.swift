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
  
  let layout = UICollectionViewFlowLayout()
  lazy var vehicleTakePictureView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.register(VehicleTakePictureViewCell.self, forCellWithReuseIdentifier: VehicleTakePictureViewCell.identifier)
    
    return collectionView
  }()
  
  lazy var leftNavigationButton: UIBarButtonItem = {
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
    self.view.backgroundColor = .white
    setNavigation()
    setCollectionView()
    
    [vehicleTakePictureView].forEach {
      view.addSubview($0)
    }
    
    vehicleTakePictureView.snp.makeConstraints {
      $0.edges.equalToSuperview()
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
}

// MARK: - UICollectionViewDelegate

extension VehicleTakePictureVC: UICollectionViewDelegate {
}

// MARK: - UICollectionViewDelegateFlowLayout

extension VehicleTakePictureVC: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return .init(width: view.frame.width, height: 300)
  }
}
