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
  
  fileprivate let vehicleTakePictureView = VehicleTakePictureView()
  
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
  
  let vehicleCheckStartButton: UIButton = {
    let button = UIButton()
    button.setTitle("총 n장 전송하기", for: .normal)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
    
    return button
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
    
    [vehicleTakePictureView].forEach {
      view.addSubview($0)
    }
  
    vehicleTakePictureView.snp.makeConstraints {
      $0.top.trailing.bottom.leading.equalTo(guid)
    }
    
    [vehicleCheckStartButton].forEach {
      self.view.addSubview($0)
    }
    
    vehicleCheckStartButton.frame = CGRect(
      x: 0,
      y: UIScreen.main.bounds.maxY - 80,
      width: UIScreen.main.bounds.width,
      height: 60
    )
  }
  
  fileprivate func setNavigation() {
    let navBar = self.navigationController?.navigationBar
    navBar?.prefersLargeTitles = true
    navBar?.backgroundColor = .white
    navBar?.barTintColor = UIColor.white
    
    self.navigationItem.leftBarButtonItem = self.leftNavigationButton
    self.title = "외관 촬영"
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
  
  @objc func buttonAction(_ sender: UIButton) {
    print("\(sender) button press")
  }
}
