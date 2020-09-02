//
//  InitVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/25.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class InitVC: UIViewController {
  
  // MARK: - Properites
  let scrollViewImagArray = ["Third", "InitLogo", "Second", "Third", "InitLogo"]
  let buttonHeight = UIScreen.main.bounds.height*0.1
  let viewWidthSize = UIScreen.main.bounds.width
  var timerMoveMent: Int = 0
  var timer: Timer?
  
  lazy var imageScrollView: UIScrollView = {
    let view = UIScrollView(frame: .zero)
    view.delegate = self
    view.isPagingEnabled = true
    view.indicatorStyle = .black
    return view
  }()
  
  lazy var pageController: UIPageControl = {
    let pageC = UIPageControl(frame: .zero)
    pageC.currentPage = 0
    pageC.numberOfPages = scrollViewImagArray.count - 2
    pageC.pageIndicatorTintColor = .systemGray5
    pageC.currentPageIndicatorTintColor = .systemGray
    return pageC
  }()
  
  let loginButton: UIButton = {
    let button = UIButton()
    button.setTitle("로그인\n", for: .normal)
    button.contentVerticalAlignment = .top
    button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = CommonUI.mainDark
    button.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
    return button
  }()
  
  lazy var signupButton: UIButton = {
    let button = UIButton()
    button.setTitle("가입하기\n", for: .normal)
    button.contentVerticalAlignment = .top
    button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    button.titleLabel?.font = .boldSystemFont(ofSize: 20)
    button.backgroundColor = CommonUI.mainBlue
    button.addTarget(self, action: #selector(tapSignupButtonTap), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureScrollView()
    
    configureLayout()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.navigationBar.isHidden = true
    startMainImageScrollViewMoveTimer()
    moveMainImageScrollView(movePageIndex: 1, withAnimated: false)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopImageMoveTimer()
  }

  private func configureScrollView() {
    
    let imageNumber = scrollViewImagArray.count
    imageScrollView.contentSize = .init(width: viewWidthSize*CGFloat(imageNumber),
                                        height: UIScreen.main.bounds.height)
    
    for index in scrollViewImagArray.indices {
      let imageView = UIImageView()
      imageView.contentMode = .scaleAspectFill
      imageView.clipsToBounds = true
      imageView.image = UIImage(named: scrollViewImagArray[index])
      imageScrollView.addSubview(imageView)
      imageView.frame = CGRect(x: Int(viewWidthSize)*index,
                               y: 0,
                               width: Int(viewWidthSize),
                               height: Int(UIScreen.main.bounds.height))
    }
  }
  
  private func configureLayout() {
    [imageScrollView, loginButton, signupButton, pageController].forEach {
      view.addSubview($0)
    }
    
    imageScrollView.snp.makeConstraints {
      $0.top.leading.trailing.bottom.equalTo(view)
    }
    
    loginButton.snp.makeConstraints {
      $0.leading.bottom.equalTo(view)
      $0.trailing.equalTo(view.snp.centerX)
      $0.height.equalTo(buttonHeight)
    }
    
    signupButton.snp.makeConstraints {
      $0.leading.equalTo(view.snp.centerX)
      $0.trailing.bottom.equalTo(view)
      $0.height.equalTo(buttonHeight)
    }
    
    pageController.snp.makeConstraints {
      $0.centerX.equalTo(view.snp.centerX)
      $0.bottom.equalTo(loginButton.snp.top).offset(-30)
      $0.height.equalTo(30)
    }
  }
  
  fileprivate func stopImageMoveTimer() {
    if let timer = timer {
      timer.invalidate()
    }
  }
  
  fileprivate func startMainImageScrollViewMoveTimer() {
    timer = Timer.scheduledTimer(timeInterval: 3.0, target: self,
                                 selector: #selector(moveScrollViewImage),
                                 userInfo: nil,
                                 repeats: true)
  }
  
  fileprivate func moveMainImageScrollView(movePageIndex: Int, withAnimated: Bool) {
    imageScrollView.setContentOffset(.init(x: viewWidthSize*CGFloat(movePageIndex), y: 0), animated: withAnimated)
  }
  
  // MARK: - Handler
  @objc func moveScrollViewImage() {
    timerMoveMent += 1
    moveMainImageScrollView(movePageIndex: timerMoveMent+1, withAnimated: true)
    pageController.currentPage = timerMoveMent%3
    
    if timerMoveMent == 3 { // 마지막페이지에서 첫번째 페이지로 변경
      DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        self.timerMoveMent = 0
        self.moveMainImageScrollView(movePageIndex: 1, withAnimated: false)
      }
    }
  }
  
  @objc private func tapSignupButtonTap() {
    let signUpInit = SingUpInitVC()
    navigationController?.pushViewController(signUpInit, animated: true)
  }
  
  @objc private func tapLoginButton() {
    let loginVC = LoginVC()
    navigationController?.pushViewController(loginVC, animated: true)
  }
}

// MARK: - UIScrollViewDelegate
extension InitVC: UIScrollViewDelegate {
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    mainImageViewScollInfinity(scrollView)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    prevnetScrollAsixY(scrollView)
  }
  
  fileprivate func prevnetScrollAsixY(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > 0 {
      scrollView.contentOffset.y = 0
    } else if scrollView.contentOffset.y < 0 {
      scrollView.contentOffset.y = 0
    }
  }
  
  fileprivate func mainImageViewScollInfinity(_ scrollView: UIScrollView) {
    pageController.currentPage = Int(scrollView.contentOffset.x/viewWidthSize-1)%3
    timerMoveMent = Int(scrollView.contentOffset.x/viewWidthSize-1)%3
    
    // 무한하게 돌아가도록 설정
    if scrollView.contentOffset.x < viewWidthSize/2 {
      moveMainImageScrollView(movePageIndex: 3, withAnimated: false)
    } else if scrollView.contentOffset.x > viewWidthSize*3.5 {
      moveMainImageScrollView(movePageIndex: 1, withAnimated: false)
    }
  }
}
