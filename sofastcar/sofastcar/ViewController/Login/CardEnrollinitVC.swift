//
//  CardEnrollinitVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CardEnrollinitVC: UIViewController {
  
  // MARK: - Properties
  var user: User?
  
  let pageController: UIPageControl = {
    let pageC = UIPageControl(frame: .zero)
    pageC.numberOfPages = 2
    pageC.pageIndicatorTintColor = .systemGray5
    pageC.currentPageIndicatorTintColor = .systemGray
    return pageC
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "결제카드를 등록해주세요"
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = CommonUI.mainDark
    return label
  }()
  
  let subTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "서비스 이용 시 등록한 카드로 결제되며,\n본인 소유의 카드만 등록할 수 있습니다."
    label.font = .systemFont(ofSize: 15)
    label.numberOfLines = 2
    label.textColor = CommonUI.mainDark
    return label
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
  
  let signUpCancel: UIButton = {
    let button = UIButton()
    button.setTitle("가입해지", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.addTarget(self, action: #selector(tabCancelButton), for: .touchUpInside)
    return button
  }()
  
  lazy var companyCardEnroll: UIButton = {
    let button = UIButton()
    button.setTitle("법인카드 등록하기\n", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = CommonUI.mainDark
    button.addTarget(self, action: #selector(tabCardEnrollButton(_:)), for: .touchUpInside)
    return button
  }()
  
  lazy var personalCardEnroll: UIButton = {
    let button = UIButton()
    button.setTitle("개인카드 등록하기\n", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(tabCardEnrollButton(_:)), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    self.navigationController?.navigationBar.topItem?.title = ""
    pageController.currentPage = 1
    
    configureLayout()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let navi = navigationController {
      navi.navigationBar.isHidden = true
    }
  }
  
  private func configureLayout() {
    [pageController, personalCardEnroll, titleLabel, subTitleLabel, companyCardEnroll,
     backButton, signUpCancel].forEach {
      view.addSubview($0)
    }
    
    let safe = view.safeAreaLayoutGuide
    view.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let guide = view.layoutMarginsGuide
    backButton.snp.makeConstraints {
      $0.leading.top.equalTo(safe).offset(10)
    }
    
    signUpCancel.snp.makeConstraints {
      $0.top.equalTo(safe).offset(10)
      $0.trailing.equalTo(guide)
    }
    
    pageController.snp.makeConstraints {
      $0.top.equalTo(backButton.snp.bottom).offset(20)
      $0.leading.equalTo(safe.snp.leading).offset(30)
      $0.height.equalTo(30)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.equalTo(pageController.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
    }
    
    subTitleLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
    }
    
    personalCardEnroll.snp.makeConstraints {
      $0.bottom.equalTo(safe).offset(-30)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(60)
    }
    
    companyCardEnroll.snp.makeConstraints {
      $0.bottom.equalTo(personalCardEnroll.snp.top).offset(-20)
      $0.leading.equalTo(safe).offset(20)
      $0.trailing.equalTo(safe).offset(-20)
      $0.height.equalTo(60)
    }
  }
  
  // MARK: - Handler
  @objc private func tabBackButton() {
    navigationController?.navigationBar.isHidden = false
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func tabCancelButton() {
    print("cancel!!")
  }
  
  @objc private func tabCardEnrollButton(_ sender: UIButton) {
    let cardEnrollVC = CardEnrollVC()
    
    navigationController?.pushViewController(cardEnrollVC, animated: true)
  }
}
