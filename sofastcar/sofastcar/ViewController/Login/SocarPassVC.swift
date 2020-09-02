//
//  SocarPassVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/01.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SocarPassVC: UIViewController {
  
  // MARK: - Properties
  let scrollViewImagArray = ["socarpass1", "socarpass2", "socarpass3"]
  
  lazy var imageScrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.delegate = self
    view.isPagingEnabled = true
    view.indicatorStyle = .black
    return view
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
  
  let buttonHeight = UIScreen.main.bounds.height*0.1
  let viewHeightSize = UIScreen.main.bounds.height
  let viewWidthSize = UIScreen.main.bounds.width
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "쏘카 패스"
    self.navigationController?.navigationBar.topItem?.title = ""
    view.backgroundColor = .white
    imageScrollView.backgroundColor = .white
    
    configureScrollView()
    
    configureXButtonUI()
  }
  
  private func configureScrollView() {
    
    view.addSubview(imageScrollView)
    imageScrollView.snp.makeConstraints {
      $0.top.bottom.equalTo(view.layoutMarginsGuide).offset(30)
      $0.leading.equalTo(view.layoutMarginsGuide).offset(10)
      $0.trailing.equalTo(view.layoutMarginsGuide).offset(-10)
    }
    
    let imageNumber = scrollViewImagArray.count
    imageScrollView.contentSize = .init(width: viewWidthSize,
                                        height: UIScreen.main.bounds.height*CGFloat(imageNumber))
    for index in scrollViewImagArray.indices {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.image = UIImage(named: scrollViewImagArray[index])
      imageScrollView.addSubview(imageView)
      imageView.frame = CGRect(x: 0,
                               y: Int(viewHeightSize)*index,
                               width: Int(viewWidthSize),
                               height: Int(UIScreen.main.bounds.height))
      print(imageView.frame)
    }
  }
  
  private func configureXButtonUI() {
    view.addSubview(backButton)
    backButton.snp.makeConstraints {
      $0.top.equalTo(view.layoutMarginsGuide).offset(10)
      $0.leading.equalTo(view.layoutMarginsGuide).offset(10)
    }
  }
  
  @objc private func tabBackButton() {
    dismiss(animated: true) {
      //메인 화면으로 이동
    }
  }
}

extension SocarPassVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollView.contentOffset.x = 0
  }
}
