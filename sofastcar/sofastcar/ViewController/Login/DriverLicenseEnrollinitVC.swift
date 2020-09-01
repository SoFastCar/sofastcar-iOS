//
//  DriverLicenseEnrollinitVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import MobileCoreServices

class DriverLicenseEnrollinitVC: UIViewController {
  // MARK: - Properties
  let myView = DriverLicenseEnrollinitView()
  
  lazy var imagePicker: UIImagePickerController = {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    return imagePicker
  }()
  
  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureButtonTargetAction()
    
  }
  
  override func loadView() {
    view = myView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = true
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.isNavigationBarHidden = false
  }

  private func configureButtonTargetAction() {
    myView.backButton.addTarget(self, action: #selector(tabBackButton), for: .touchUpInside)
    myView.driverAuthCompleteButton.addTarget(self, action: #selector(tapDriverAuthCompletebutton), for: .touchUpInside)
  }
  
  // MARK: - Handler
  @objc private func tabBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func tapDriverAuthCompletebutton() {
    guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
    imagePicker.sourceType = .camera // sourceType 카메라 선택
    
    let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
    
    imagePicker.mediaTypes = mediaTypes ?? []
    imagePicker.mediaTypes = ["public.image"]
    
    if UIImagePickerController.isFlashAvailable(for: .rear) {
      imagePicker.cameraFlashMode = .off
    }
    
    present(imagePicker, animated: true, completion: {
      
    })
  }
  
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension DriverLicenseEnrollinitVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: {
      let checkDriverLicenseVC = CheckDriverLicenseVC()
      self.navigationController?.pushViewController(checkDriverLicenseVC, animated: true)
    })
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    if let mediaType = info[.mediaType] as? NSString {
      if UTTypeEqual(mediaType, kUTTypeImage) {
        // handle Image Type
        let originalImage = info[.originalImage] as? UIImage    // 이미지를 가져옴
        let editedImage = info[.editedImage] as? UIImage        // editedImage
//        let cripImage = info[.cropRect]  as? UIImage
//        let selectedImage = cripImage ?? editedImage ?? originalImage
      }
    }
    dismiss(animated: true, completion: {
      let checkDriverLicenseVC = CheckDriverLicenseVC()
      self.navigationController?.pushViewController(checkDriverLicenseVC, animated: true)
    })
  }
}
