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

  // MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.topItem?.title = ""
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
    navigationController?.navigationBar.isHidden = false
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func tapDriverAuthCompletebutton() {
    let customCameraVC = CustomCameraVC()
    navigationController?.pushViewController(customCameraVC, animated: false)
  }
}
