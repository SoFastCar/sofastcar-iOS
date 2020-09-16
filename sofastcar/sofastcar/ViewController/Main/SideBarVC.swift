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
  
  static func getCount() -> Int {
    return 9
  }
}

class SideBarVC: UIViewController {
  
  let tableView = UITableView(frame: .zero, style: .plain)
  let tableHeaderView = SideBarHeaderView()
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .none
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.backgroundColor = .white
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableHeaderView = tableHeaderView
    tableView.tableHeaderView?.frame.size.height = 140
    tableView.allowsSelection = false
    tableView.separatorStyle = .none
    view.addSubview(tableView)
       tableView.frame = CGRect(x: -UIScreen.main.bounds.width, y: 0.0,
                                  width: UIScreen.main.bounds.width*0.85,
                                  height: UIScreen.main.bounds.height)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    UIView.animate(withDuration: 0.5, animations: {
      self.tableView.center.x -= UIScreen.main.bounds.width
    }) { success in
      if success {
        self.dismiss(animated: false, completion: nil)
      }
    }
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
    return SideBarMenuType.getCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
    if indexPath.row == 0 {
      cell.backgroundColor = .systemGray4
    }
    cell.textLabel?.text = sectionTitleArray[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50
  }
}
