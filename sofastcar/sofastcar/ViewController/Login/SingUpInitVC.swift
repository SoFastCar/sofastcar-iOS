//
//  SingUpInitVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class SingUpInitVC: UIViewController {
  
  // MARK: - Properties
  let imageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "SingupStarter"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let pageController: UIPageControl = {
    let pageC = UIPageControl(frame: .zero)
    pageC.currentPage = 0
    pageC.numberOfPages = 2
    pageC.pageIndicatorTintColor = .systemGray5
    pageC.currentPageIndicatorTintColor = .systemGray
    return pageC
  }()
  
  let backButton: UIButton = {
    let button = UIButton()
    let attributeImage = UIImage.SymbolConfiguration(pointSize: 25, weight: .thin)
    let leftChevronImage = UIImage(systemName: "arrow.left", withConfiguration: attributeImage)
    button.setImage(leftChevronImage, for: .normal)
    button.imageView?.tintColor = .black
    button.addTarget(self, action: #selector(tabBackButton), for: .touchUpInside)
    return button
  }()
  
  lazy var signupButton: UIButton = {
    let button = UIButton()
    button.setTitle("가입하기\n", for: .normal)
    button.contentVerticalAlignment = .top
    button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = #colorLiteral(red: 0.00789394509, green: 0.7206848264, blue: 0.9998746514, alpha: 1)
    button.addTarget(self, action: #selector(singupButtonTap), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    [pageController, imageView, signupButton, backButton].forEach{
      view.addSubview($0)
    }
    
    let safe = view.safeAreaLayoutGuide
    backButton.snp.makeConstraints {
      $0.leading.top.equalTo(safe).offset(10)
    }
    
    pageController.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(20)
      $0.leading.equalTo(safe.snp.leading).offset(30)
    }
    
    imageView.snp.makeConstraints {
      $0.top.equalTo(pageController.snp.bottom).offset(5)
      $0.leading.equalTo(safe)
      $0.trailing.equalTo(safe.snp.trailing)
    }
    
    signupButton.snp.makeConstraints {
      $0.leading.equalTo(safe.snp.leading).offset(20)
      $0.trailing.equalTo(safe.snp.trailing).offset(-20)
      $0.bottom.equalTo(safe.snp.bottom).offset(-20)
    }
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let navi = navigationController {
      navi.navigationBar.isHidden = true
    }
  }
  
  // MARK: - Handler
  @objc func tabBackButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func singupButtonTap() {
    let touVC = TouVC()
    navigationController?.pushViewController(touVC, animated: true)
  }
}
