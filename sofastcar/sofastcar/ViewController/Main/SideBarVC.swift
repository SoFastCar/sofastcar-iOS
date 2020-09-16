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
  let tableHeaderView = SideBarHeaderView()
  let buttonImageName = ["business", "option", "plan"]
  
  let sideBarBottonView = SideBarBottonView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .none
    configureTableView()
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
                                  width: UIScreen.main.bounds.width*0.85,
                                  height: UIScreen.main.bounds.height)
    
    tableHeaderView.settingButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.notiButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
    tableHeaderView.userlevelButton.addTarget(self, action: #selector(tapHaederButton(_:)), for: .touchUpInside)
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
    UIView.animate(withDuration: 0.5, animations: {
      self.tableView.center.x -= UIScreen.main.bounds.width
    }, completion: { success in
      if success {
        self.dismiss(animated: false, completion: nil)
      }
    })
  }
  
  func animate() {
    UIView.animate(withDuration: 0.5) {
      self.tableView.center.x += UIScreen.main.bounds.width
    }
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideBarVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return SideBarMenuType.allcase().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SideBarCustomCell.identifier)
      as? SideBarCustomCell else { fatalError() }
    let cellType = SideBarMenuType.allcase()
    cell.cellConfigure(cellType: cellType[indexPath.row])
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 55
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cellType = SideBarMenuType.allcase()
    print(cellType[indexPath.row].rawValue)
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
    case tableHeaderView.notiButton:
      print("tableHeaderView.notiButton")
    default:
      return
    }
  }
}
