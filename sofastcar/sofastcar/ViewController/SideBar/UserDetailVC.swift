//
//  UserDetailVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum UserDetailSectionType: String {
  case accountManager = "계정 관리"
  case payAndDiscount = "결제 및 할인"
  case alarm = "알림"
  case usingInfomation = "이용 정보"
  case logoutButton = "로그아웃"
  
  static func allcase() -> [UserDetailSectionType] {
    return [accountManager, payAndDiscount, alarm, usingInfomation, logoutButton]
  }
  
  static func getDetailCellType(sectionType: UserDetailSectionType) -> [String] {
    switch sectionType {
    case .accountManager:
      return ["비밀번호 재설정", "휴대폰 번호 재설정", "비지니스 프로필 설정", "계정 연동 설정", "추가 카드키 설정", "쏘카패스 구독 설정"]
    case .payAndDiscount:
      return ["결제 / 운전면허 / T맴버쉽", "크래딧"]
    case .alarm:
      return ["혜택 알림 설정"]
    case .usingInfomation:
      return ["쏘카 이용약관", "개인정보처리방침", "쏘카 자동차대여약관", "위치기반 서비스 이용약관", "전자금융거래 이용약관", "회원 탈퇴하기", "앱 버전"]
    case .logoutButton:
      return["로그아웃"]
    }
  }
}

class UserDetailVC: UIViewController {
  // MARK: - Properties
  let tableView = UITableView(frame: .zero, style: .grouped)
  let tableHeaderView = SideBarHeaderView(frame: .zero, isMain: false)
  lazy var sectionTitleArray = UserDetailSectionType.allcase()
  var cellTitleArray = [String]()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    print("start viewDidLoad")
    view.backgroundColor = .none
    configureLayout()
    configureTableView()
  }
  
  private func configureLayout() {
    view.addSubview(tableView)
    tableView.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
  }
  
  private func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableHeaderView = tableHeaderView
    tableView.tableHeaderView?.frame.size.height = 150
    tableView.tableHeaderView?.backgroundColor = .white
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.rowHeight = 50
    tableView.sectionHeaderHeight = 50
    tableView.sectionFooterHeight = 10
  }
  
  // MARK: - Present, dismiss Animation
  func presentWithAnimate() {
    UIView.animate(withDuration: 0.4) {
      self.tableView.center.x -= UIScreen.main.bounds.width
    }
  }
  
  func dismissWithAnimation(completion: () -> Void) {
    UIView.animate(withDuration: 0.4) {
      self.tableView.center.x += UIScreen.main.bounds.width
    }
    completion()
  }
}

extension UserDetailVC: UITableViewDataSource, UITableViewDelegate {
  // MARK: - Table view data source
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitleArray.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cellTitleArray = UserDetailSectionType.getDetailCellType(sectionType: sectionTitleArray[section])
    return cellTitleArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    cell.textLabel?.text = cellTitleArray[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.backgroundColor = .white
    label.text = "    \(sectionTitleArray[section].rawValue)"
    label.font = .boldSystemFont(ofSize: 18)
    return label
  }
}
