//
//  FriendsInciteVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class FriendsInciteVC: UIViewController {
  // MARK: - Properties
  let myView = FriendsInviteView()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationController()
    configureScrollViewButtonAaction()
  }
  
  override func loadView() {
     view = myView
  }
  
  private func configureNavigationController() {
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue), style: .plain, target: self, action: #selector(tapCloseButton))
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = UIColor.white
  }
  
  private func configureScrollViewButtonAaction() {
    myView.couponSendButton.addTarget(self, action: #selector(tapCouponSendButton), for: .touchUpInside)
    
    let kakaoTapGuesture = UITapGestureRecognizer(target: self, action: #selector(tapKakaoInviteButton))
    myView.kakaoInviteImageView.isUserInteractionEnabled = true
    myView.kakaoInviteImageView.addGestureRecognizer(kakaoTapGuesture)
    
    let shareTapGuesture = UITapGestureRecognizer(target: self, action: #selector(tapShareInviteButton))
    myView.shareInviteImageView.isUserInteractionEnabled = true
    myView.shareInviteImageView.addGestureRecognizer(shareTapGuesture)
  }

  // MARK: - Handler
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
  
  @objc private func tapCouponSendButton() {
    print("tapCouponSendButton")
  }
  
  @objc private func tapKakaoInviteButton() {
    print("tapKakaoInviteButton")
  }
  
  @objc private func tapShareInviteButton() {
    print("tapShareInviteButton")
  }
}
