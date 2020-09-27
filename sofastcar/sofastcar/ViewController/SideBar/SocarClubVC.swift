//
//  SocarClubVCViewController.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/25.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SocarClubVC: UIViewController {
  // MARK: - Properties
  let myScrollView = SocarClubScrollView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    configureScrollViewButtonConfigure()
  }
  
  override func loadView() {
    view = myScrollView
  }
  
  private func configureNavigationController() {
    title = "쏘카클럽"
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue), style: .plain, target: self, action: #selector(tapCloseButton))
    navigationController?.navigationBar.tintColor = .black
  }
  
  private func configureScrollViewButtonConfigure() {
    myScrollView.downLoadButtonArray.forEach {
      $0.addTarget(self, action: #selector(tapDownloadCouponButton(_:)), for: .touchUpInside)
    }
  }
  
  // MARK: - Handler
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func tapDownloadCouponButton(_ sender: UIButton) {
    print("aaa")
    guard let couponTitle = sender.currentTitle else { return print("aa") }
    print(couponTitle)
  }
}
