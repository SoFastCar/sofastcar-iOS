//
//  SideBarVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class SideBarVC: UIViewController {
  // MARK: - Properties
  private var sideBarVM: SideBarViewModel!
  
  let tableView = UITableView(frame: .zero, style: .plain)
  let tableHeaderView = SideBarHeaderView(frame: .zero, isMain: true)
  let buttonImageName = ["business", "option", "plan"]
  let viewWidthSizeRatio: CGFloat = 0.85
  
  var isHorizenScrolling = false
  var isVerticalStcolling = false
  
  var gapX: CGFloat = 0
  var tableViewOriginX: CGFloat = 0
  var firstTouchOriginX: CGFloat = 0
  
  let sideBarBottonView = SideBarBottonView()
  
  var disposeBag = DisposeBag()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0)

    getUserDataByRx()
    configureTableView()
    configureBottomView()
    configureTableViewPanGuesture()
  }
  
  private func configureTableHeaderView() {
    tableView.tableHeaderView = tableHeaderView
    tableView.tableHeaderView?.frame.size.height = 140
    
    sideBarVM.name.asDriver(onErrorJustReturn: UserData.empty.results[0].name)
      .drive(tableHeaderView.userNameLable.rx.text)
      .disposed(by: disposeBag)
    
    sideBarVM.email.asDriver(onErrorJustReturn: UserData.empty.results[0].email)
      .drive(tableHeaderView.userIdLable.rx.text)
      .disposed(by: disposeBag)
    
    sideBarVM.creditPoint.asDriver(onErrorJustReturn: "0원")
      .drive(tableHeaderView.creditLabel.rx.text)
      .disposed(by: disposeBag)
  }
  
  private func configureTableView() {
    tableView.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self

    tableView.separatorStyle = .none
    tableView.register(SideBarCustomCell.self, forCellReuseIdentifier: SideBarCustomCell.identifier)
    
    view.addSubview(tableView)
    tableView.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0.0,
                             width: UIScreen.main.bounds.width*viewWidthSizeRatio,
                             height: UIScreen.main.bounds.height)
    
    tableHeaderView.settingButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.notiButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.socarClubButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
  }
  
  private func configureBottomView() {
    tableView.addSubview(sideBarBottonView)
    sideBarBottonView.snp.makeConstraints {
      $0.leading.trailing.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(130)
    }
    sideBarBottonView.businessButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
    sideBarBottonView.planButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
    sideBarBottonView.pairingButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
  }
  
  private func configureTableViewPanGuesture() {
    let sideViewPanGuesture = UIPanGestureRecognizer(target: self, action: #selector(dragTableView(_:)))
    view.addGestureRecognizer(sideViewPanGuesture)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)  // 실제 터치한 위치
    if touchPoint.x > UIScreen.main.bounds.maxX * viewWidthSizeRatio {
      dismissWithAnimated(nil, completion: nil)
    }
  }
  // MARK: - Custtom Present/Dismiss Animate
  func animateWithAnimate() {
    UIView.animate(withDuration: 0.5) {
      self.tableView.center.x += UIScreen.main.bounds.width
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
  }
  
  func dismissWithAnimated(_ presentedVC: UIViewController?, completion: (() -> Void)?) {
    guard let navi = self.presentingViewController as? UINavigationController else { return }
    guard let mainVC = navi.viewControllers.last as? MainVC else { return }
    
    UIView.animate(withDuration: 0.5, animations: {
      self.tableView.center.x -= UIScreen.main.bounds.width
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
    }, completion: { [ weak self ]success in
      if success {
        
        self?.dismiss(animated: false, completion: {
          
          if let presentedVC = presentedVC {
            let navigationController = UINavigationController(rootViewController: presentedVC)
            navigationController.modalPresentationStyle = .overFullScreen
            mainVC.present(navigationController, animated: true, completion: nil)
          }
          
        })

        completion?()
      }
    })
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sideBarVM == nil ? 0 : sideBarVM.sideBarCellTypes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SideBarCustomCell.identifier)
      as? SideBarCustomCell else { fatalError() }
    cell.cellConfigure(cellType: sideBarVM.sideBarCellTypes[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 53
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cellType = sideBarVM.sideBarCellTypes[indexPath.row]
    switch cellType {
    case .usingHistocyCell:
      
      guard let navi = self.presentingViewController as? UINavigationController else { return }
      dismissWithAnimated(nil) {
        let rentHistoryVC = RentHistoryVC()
        navi.navigationBar.prefersLargeTitles = true
        navi.pushViewController(rentHistoryVC, animated: true)
      }
      
    case .evnetWithBenigitCell:
      
      let eventAndBenefitsVC = EventAndBenefitsVC()
      eventAndBenefitsVC.eventAndBenefitsArray = EventBenifits.initialData()
      dismissWithAnimated(eventAndBenefitsVC, completion: nil)
      
    case .inviteFriendCell:
      
      let friendsInciteVC = FriendsInciteVC()
      dismissWithAnimated(friendsInciteVC, completion: nil)
      
    case .couponCell:
      
      let userCouponVC = UserCouponVC()
      userCouponVC.userCouponList = CouponBook.testDataLoad()
      dismissWithAnimated(userCouponVC, completion: nil)
      
    case .customerCenterCell, .eventBannerCell:
      break
    case .mainBoardCell, .socarPassCell, .socarPlusCell:
      break
    }
  }
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    isVerticalStcolling = false
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    isVerticalStcolling = true
  }
}

// MARK: - Network Fetch User Data
extension SideBarVC {
  func getUserDataByRx() {
   
    URLRequest.load(resource: UserData.all)
      .subscribe(onNext: { [weak self] result in
        if let result = result {
          
          self?.sideBarVM = SideBarViewModel(result.results[0])
          DispatchQueue.main.async {
            self?.configureTableHeaderView()
            self?.tableView.reloadData()
          }
          
        }
      }).disposed(by: disposeBag)
    
  }
}

// MARK: - button Action
extension SideBarVC {
  @objc func tapButtomViewButton(_ sender: UIButton) {
    switch sender {
    case sideBarBottonView.businessButton:
      print("sideBarBottonView.businessButton")
    case sideBarBottonView.planButton:
      print("sideBarBottonView.planButton")
    case sideBarBottonView.pairingButton:
      print("sideBarBottonView.pairingButton")
    default:
      return
    }
  }
  
  @objc func tapHaederButton(_ sender: UIButton) {
    switch sender {
    case tableHeaderView.socarClubButton:
      
      let socarClubVC = SocarClubVC()
      dismissWithAnimated(socarClubVC, completion: nil)
      
    case tableHeaderView.settingButton:
      guard let navi = self.presentingViewController as? UINavigationController else { return }
      let userDetailVC = UserDetailVC()
      userDetailVC.user = sideBarVM.user
      userDetailVC.configureTableHaderView()
      dismissWithAnimated(nil) {
        navi.pushViewController(userDetailVC, animated: true)
      }
      
    case tableHeaderView.notiButton:
      print("tableHeaderView.notiButton")
    default:
      return
    }
  }
}

// MARK: - TableView PnaGuresture Recognizer
extension SideBarVC {

  @objc private func dragTableView(_ sender: UIPanGestureRecognizer) {
    guard isVerticalStcolling == false else { return }
    let touchPoint = sender.location(in: view)
    
    if sender.state == .began {
      isHorizenScrolling = true
      gapX = touchPoint.x - tableView.center.x
      tableViewOriginX = tableView.center.x
      firstTouchOriginX = touchPoint.x
    } else if sender.state == .changed {
      guard firstTouchOriginX > touchPoint.x else { return }
      let viewBackGroundColorRatio = min(touchPoint.x/UIScreen.main.bounds.width, 0.5)
      self.view.backgroundColor = UIColor.black.withAlphaComponent(viewBackGroundColorRatio)
      tableView.center.x = touchPoint.x - gapX
    } else if sender.state == .ended {
      isHorizenScrolling = false
      if touchPoint.x < UIScreen.main.bounds.width*(1-viewWidthSizeRatio) {
        dismissWithAnimated(nil, completion: nil)
      } else {
        UIView.animate(withDuration: 0.2) {
          self.tableView.center.x = self.tableViewOriginX
        }
      }
    }
  }
}
