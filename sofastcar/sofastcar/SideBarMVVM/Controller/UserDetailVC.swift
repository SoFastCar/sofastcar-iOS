//
//  UserDetailVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/24.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum UserDetailSectionType: String {
  case blank = ""
  case accountManager = "계정 관리"
  case payAndDiscount = "결제 및 할인"
  case alarm = "알림"
  case usingInfomation = "이용 정보"
  case logoutButton = "로그아웃"
  
  static func allcase() -> [UserDetailSectionType] {
    return [blank, accountManager, payAndDiscount, alarm, usingInfomation, logoutButton]
  }
  
  static func getDetailCellType(sectionType: UserDetailSectionType) -> [String] {
    switch sectionType {
    case .blank:
      return []
    case .accountManager:
      return ["비밀번호 재설정", "휴대폰 번호 재설정", "비지니스 프로필 설정", "계정 연동 설정", "추가 카드키 설정", "쏘카패스 구독 설정"]
    case .payAndDiscount:
      return ["결제 / 운전면허 / T맴버쉽", "크래딧"]
    case .alarm:
      return ["혜택 알림 설정"]
    case .usingInfomation:
      return ["쏘카 이용약관", "개인정보처리방침", "쏘카 자동차대여약관", "위치기반 서비스 이용약관", "전자금융거래 이용약관", "회원 탈퇴하기", "앱 버전"]
    case .logoutButton:
      return ["로그아웃"]
    }
  }
}

class UserDetailVC: UIViewController {
  // MARK: - Properties
  var user: User?
  let tableView = UITableView(frame: .zero, style: .grouped)
  let tableHeaderView = SideBarHeaderView(frame: .zero, isMain: false)
  lazy var sectionTitleArray = UserDetailSectionType.allcase()
  var cellTitleArray = [String]()
  
  let statusBar =  UIView()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .none
//    configureNavigationContoller()
    configureLayout()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    configureNavigationContoller()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.navigationBar.isHidden = true
  }
  
  private func configureNavigationContoller() {
    guard let navi = navigationController else { return }
    title = "설정"
    navi.isNavigationBarHidden = false
    navi.navigationBar.isHidden = false
    navi.navigationBar.prefersLargeTitles = true
    navi.navigationItem.largeTitleDisplayMode = .automatic
    navi.navigationBar.backgroundColor = .white
    navi.navigationBar.barTintColor = UIColor.white
    navi.navigationBar.tintColor = UIColor.black
    
    let appearance = UINavigationBarAppearance(idiom: .phone)
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
    appearance.backgroundColor = .white
    appearance.shadowColor = .none
    navigationItem.standardAppearance = appearance
    navigationItem.scrollEdgeAppearance = appearance
  }
  
  private func configureLayout() {
    view.addSubview(tableView)
    tableView.frame = CGRect(x: 0, y: -30, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+30)
  }
  
  private func configureTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.tableHeaderView = tableHeaderView
    tableView.tableHeaderView?.frame = CGRect(x: 0, y: 0,
                                              width: UIScreen.main.bounds.width, height: 120)
    tableView.separatorStyle = .none
    tableView.tableHeaderView?.backgroundColor = .white
    tableView.rowHeight = 50
    tableView.sectionHeaderHeight = 50
    tableView.sectionFooterHeight = 10
  }
  
  func configureTableHaderView() {
    guard let user = user else { return }
    tableHeaderView.userNameLable.text = user.name
    tableHeaderView.userPhoneNumberLabel.text = user.phoneNumber
    tableHeaderView.userIdLable.text = user.email
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
  func getCellTitleArray(section: Int) -> [String] {
    return UserDetailSectionType.getDetailCellType(sectionType: sectionTitleArray[section])
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitleArray.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    cellTitleArray = getCellTitleArray(section: section)
    return cellTitleArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    cellTitleArray = getCellTitleArray(section: indexPath.section)
    let cell = UserDetailCell(style: .default, reuseIdentifier: UserDetailCell.identifier, cellType: cellTitleArray[indexPath.row])
    cell.delegate = self
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    if sectionTitleArray[section] == .blank || sectionTitleArray[section] == .logoutButton {
      label.frame = .zero
      return label
    }
    label.backgroundColor = .white
    label.text = "     \(sectionTitleArray[section].rawValue)"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .darkGray
    return label
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if section == 0 { return 0 }
    if section == sectionTitleArray.count - 2 { return 0 }
    return 50
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    if section == 0 { return 0 }
    if section == sectionTitleArray.count - 2 { return 0 }
    return 10
  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    if section == sectionTitleArray.count - 1 || section == sectionTitleArray.count - 2 { return nil }
    view.backgroundColor = .systemGray6
    view.layer.borderColor = UIColor.systemGray5.cgColor
    view.layer.borderWidth = 1
    return view
  }
}

extension UserDetailVC: UserDetailCellDelegate {
  func tapLogoutButton(forCell cell: UserDetailCell) {
    let alertActionContoller = UIAlertController(title: "확인해주세요", message: "정말 로그아웃 하시겠어요?", preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (_) in }
    let okAction = UIAlertAction(title: "확인", style: .default) { _ in
      UserDefaults.deleteUserSettingForLogout()
      let initVC = InitVC()
      self.navigationController?.pushViewController(initVC, animated: false)
    }
    alertActionContoller.addAction(cancelAction)
    alertActionContoller.addAction(okAction)
    present(alertActionContoller, animated: true, completion: nil)
  }
}
