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
  
  let buttonHeight = UIScreen.main.bounds.height*0.1
  let viewHeightSize = UIScreen.main.bounds.height
  let viewWidthSize = UIScreen.main.bounds.width
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    configureNavigationContoller()
    configureScrollView()
  }
    
  private func configureNavigationContoller() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(tabBackButton))
    navigationItem.leftBarButtonItem?.tintColor = .black
  }
  
  private func configureScrollView() {
    imageScrollView.backgroundColor = .white
    view.addSubview(imageScrollView)
    imageScrollView.snp.makeConstraints {
      $0.top.bottom.equalTo(view.safeAreaLayoutGuide).offset(30)
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
    }
  }
  
  @objc private func tabBackButton() {
    print("Tab Back BTuuton")
    dismiss(animated: true) {
      let mainVC = MainVC()
      let navigationController = UINavigationController(rootViewController: mainVC)
      self.present(navigationController, animated: true, completion: nil)
    }
  }
}

extension SocarPassVC: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    scrollView.contentOffset.x = 0
  }
}
