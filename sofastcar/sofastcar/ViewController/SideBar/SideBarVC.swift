//
//  SideBarVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum SideBarMenuType: String {
  case eventBannerCell = ""
  case usingHistocyCell = "이용내역"
  case socarPassCell = "쏘카패스"
  case couponCell = "쿠폰"
  case evnetWithBenigitCell = "이벤트/해택"
  case socarPlusCell = "쏘카플러스"
  case inviteFriendCell = "친구 초대하기"
  case customerCenterCell = "고객센터"
  case mainBoardCell = "공지사항"
  
  static func allcase() -> [SideBarMenuType] {
    return [eventBannerCell, usingHistocyCell, socarPassCell, couponCell, evnetWithBenigitCell,
    socarPlusCell, inviteFriendCell, customerCenterCell, mainBoardCell]
  }
}

class SideBarVC: UIViewController {
  // MARK: - Properties
  let tableView = UITableView(frame: .zero, style: .plain)
  let viewWidthSizeRatio: CGFloat = 0.85
  let tableHeaderView = SideBarHeaderView()
  let buttonImageName = ["business", "option", "plan"]
  lazy var sideBarCellTypes = SideBarMenuType.allcase()
  var isHorizenScrolling = false
  var isVerticalStcolling = false
  var gapX: CGFloat = 0
  var tableViewOriginX: CGFloat = 0
  var firstTouchOriginX: CGFloat = 0
  
  let sideBarBottonView = SideBarBottonView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.black.withAlphaComponent(0)
    configureTableView()
    configureTableViewPanGuesture()
    configureBottomView()
  }
  
  private func configureTableView() {
    tableView.backgroundColor = .white
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableHeaderView = tableHeaderView
    tableView.tableHeaderView?.frame.size.height = 140
    tableView.separatorStyle = .none
    tableView.register(SideBarCustomCell.self, forCellReuseIdentifier: SideBarCustomCell.identifier)
    view.addSubview(tableView)
    tableView.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0.0,
                             width: UIScreen.main.bounds.width*viewWidthSizeRatio,
                             height: UIScreen.main.bounds.height)
    
    tableHeaderView.settingButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.notiButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.userlevelButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
  }
  
  private func configureTableViewPanGuesture() {
    let sideViewPanGuesture = UIPanGestureRecognizer(target: self, action: #selector(dragTableView(_:)))
    view.addGestureRecognizer(sideViewPanGuesture)
  }
  
  private func configureBottomView() {
    tableView.addSubview(sideBarBottonView)
    sideBarBottonView.snp.makeConstraints {
      $0.leading.trailing.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(50)
      $0.height.equalTo(120)
    }
    sideBarBottonView.businessButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
    sideBarBottonView.planButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
    sideBarBottonView.pairingButton.addTarget(self, action: #selector(tapButtomViewButton(_:)), for: .touchUpInside)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard let touch = touches.first else { return }
    let touchPoint = touch.location(in: touch.view)  // 실제 터치한 위치
    if touchPoint.x > UIScreen.main.bounds.maxX * viewWidthSizeRatio {
      dismissWithAnimated(completion: nil)
    }
    
  }
  // MARK: - Custtom Present/Dismiss Animate
  func animateWithAnimate() {
    UIView.animate(withDuration: 0.5) {
      self.tableView.center.x += UIScreen.main.bounds.width
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
  }
  
  func dismissWithAnimated(completion: (() -> Void)?) {
    UIView.animate(withDuration: 0.5, animations: {
      self.tableView.center.x -= UIScreen.main.bounds.width
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
    }, completion: { success in
      if success {
        self.dismiss(animated: false, completion: nil)
        completion?()
      }
    })
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sideBarCellTypes.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SideBarCustomCell.identifier)
      as? SideBarCustomCell else { fatalError() }
    cell.cellConfigure(cellType: sideBarCellTypes[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cellType = sideBarCellTypes[indexPath.row]
    switch cellType {
    case .usingHistocyCell:
      dismissWithAnimated {
        guard let navi = self.presentingViewController as? UINavigationController else { return }
        guard let mainVC = navi.viewControllers.last as? MainVC else { return }
        let rentHistoryVC = RentHistoryVC(style: .grouped)
        mainVC.navigationController?.pushViewController(rentHistoryVC, animated: true)
      }
    case .couponCell, .customerCenterCell, .eventBannerCell, .evnetWithBenigitCell:
      break
    case .mainBoardCell, .socarPassCell, .socarPlusCell, .inviteFriendCell:
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
    case tableHeaderView.userlevelButton:
      print("tableHeaderView.userlevelButton")
    case tableHeaderView.settingButton:
      print("tableHeaderView.tapHaederButton")
      UIView.animate(withDuration: 0.5, animations: {
        self.tableView.center.x -= UIScreen.main.bounds.width
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
      }, completion: { sucess in
        if sucess {
          let userDetailVC = UserDetailVC()
          userDetailVC.modalPresentationStyle = .overFullScreen
          self.present(userDetailVC, animated: false, completion: {
            print("animate")
            userDetailVC.presentWithAnimate()
          })
        }
      })
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
        dismissWithAnimated(completion: nil)
      } else {
        UIView.animate(withDuration: 0.2) {
          self.tableView.center.x = self.tableViewOriginX
        }
      }
    }
  }
}
