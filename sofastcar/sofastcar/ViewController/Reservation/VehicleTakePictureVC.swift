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
  fileprivate let picker = UIImagePickerController()
  
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
    button.setTitle("외관에 이상이 없습니다", for: .normal)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(startButtonAction(_:)), for: .touchUpInside)
    button.contentHorizontalAlignment = .center
    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    
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
    vehicleTakePictureView.customDelegate = self
    
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
      height: 80
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
  
  @objc func startButtonAction(_ sender: UIButton) {
    print("\(sender) button press")
    switch sender {
    case vehicleCheckStartButton:
      let alert = UIAlertController(title: "확인해주세요.", message: "외관을 모두 확인하셨나요?\n사진 전송 후에는 추가하거나 수정할 수 없습니다.", preferredStyle: UIAlertController.Style.alert)
      alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.default, handler: nil))
      alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: { _ in
        let vehicleTakePictureVC = VehicleDoubleCheckVC()
        vehicleTakePictureVC.modalPresentationStyle = .fullScreen
        self.present(vehicleTakePictureVC, animated: true, completion: nil)
      }))
      self.present(alert, animated: true, completion: nil)
    default:
      break
    }
  }
}

// MARK: - VehicleTakePictureViewDelegate

extension VehicleTakePictureVC: VehicleTakePictureViewDelegate {
  func buttonAction(_ sender: UIButton) {
    switch sender {
    case vehicleTakePictureView.vehicleTakePictureFrontView.vehicleTakePictureButton:
      print("전면")
      openCamera()
    case vehicleTakePictureView.vehicleTakePicturePassengerFrontSeatView.vehicleTakePictureButton:
      print("보조석 앞면")
      openCamera()
    case vehicleTakePictureView.vehicleTakePicturePassengerBackSeatView.vehicleTakePictureButton:
      print("보조석 뒷면")
      openCamera()
    case vehicleTakePictureView.vehicleTakePictureBackView.vehicleTakePictureButton:
      print("후면")
      openCamera()
    case vehicleTakePictureView.vehicleTakePictureDriveBackSeatView.vehicleTakePictureButton:
      print("운전석 뒷면")
      openCamera()
    case vehicleTakePictureView.vehicleTakePictureDriveFrontSeatView.vehicleTakePictureButton:
      print("운전석 앞면")
      openCamera()
    default:
      break
    }
  }
}

// MARK: - Function

extension VehicleTakePictureVC {
  func openCamera() {
    let vehicleCustomCameraVC = VehicleCustomCameraVC()
    vehicleCustomCameraVC.modalPresentationStyle = .fullScreen
    present(vehicleCustomCameraVC, animated: true)
  }
}
