//
//  CheckDriverLicenseVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CheckDriverLicenseVC: UIViewController {
  
  let imageNameArray = ["socarpass1", "socarpass2", "socarpass3"]
  let myView = CheckDriverLicenseView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    myView.customAuthAllAgreeButton.addTarget(self, action: #selector(tabAgreeButton(_:)), for: .touchUpInside)
    myView.driverAuthCompleteButton.addTarget(self, action: #selector(tabComplutebutton), for: .touchUpInside)
  }
  
  override func loadView() {
    view = myView
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let navi = navigationController {
      navi.navigationBar.isHidden = false
      navi.navigationBar.tintColor = .black
    }
    title = "운전면허 확인"
    self.navigationController?.navigationBar.topItem?.title = ""
  }
  
  // MARK: - Button handler
  
  @objc func tabComplutebutton() {
    let socarPassVC = SocarPassVC()
    let naviController = UINavigationController(rootViewController: socarPassVC)
    naviController.modalPresentationStyle = .overFullScreen
    navigationController?.present(naviController, animated: true, completion: {
      self.navigationController?.popToRootViewController(animated: false)
    })
  }
  
  @objc func tabAgreeButton(_ sender: UIButton) {
    sender.isSelected.toggle()
  }

}
