//
//  UserCouponVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum UserCouponTableViewType: String {
  case couponBook
  case myCoupon
}

enum UserCouponCellType: String {
  case inviteFriendsCell
  case couponCell
  
  static func allcase(couponCount: Int) -> [UserCouponCellType] {
    var resultArray = [inviteFriendsCell]
    for _ in 0..<couponCount {
      resultArray.append(couponCell)
    }
    return resultArray
  }
}

class UserCouponVC: UIViewController {
  // MARK: - Properties
  var userCouponList: [CouponBook]?
  let myView = UserCouponView()
  let tableView = UITableView(frame: .zero, style: .grouped)
  var currentSelectedTableView = UserCouponTableViewType.couponBook
  
  var cellTypeArray: [UserCouponCellType] = []
  
  lazy var backButtonImageView: UIImageView = {
    let imageView = UIImageView()
    let sysImageConfigure = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium)
    imageView.image = UIImage(systemName: "xmark", withConfiguration: sysImageConfigure)
    imageView.isUserInteractionEnabled = true
    let tapguesture = UITapGestureRecognizer.init(target: self, action: #selector(tapCancelButton))
    imageView.addGestureRecognizer(tapguesture)
    return imageView
  }()
  
  let cellSelectedBackgroundView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigation()
    configureCouponDate()
    configureTableView()
    configureMyViewButtonAction()
  }
  
  override func loadView() {
    super.loadView()
    view = myView
  }
  
  private func configureNavigation() {
    title = "쿠폰"
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.addSubview(backButtonImageView)
    backButtonImageView.snp.makeConstraints {
      $0.top.leading.equalTo(navigationController!.navigationBar.safeAreaLayoutGuide).offset(10)
    }
  }
  
  private func configureCouponDate() {
    guard let couponCount = userCouponList?.count else { return }
    cellTypeArray = UserCouponCellType.allcase(couponCount: couponCount)
  }
  
  private func configureTableView() {
    myView.addSubview(tableView)
    tableView.snp.makeConstraints {
      $0.top.equalTo(myView.couponBookButton.snp.bottom)
      $0.leading.trailing.equalTo(myView.guide)
      $0.bottom.equalToSuperview()
    }
    tableView.dataSource = self
    tableView.delegate = self
    tableView.backgroundColor = .systemGray6
    tableView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 500
    tableView.separatorStyle = .none
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 10
  }
  
  private func configureMyViewButtonAction() {
    myView.couponBookButton.addTarget(self, action: #selector(tapCouponBookButton), for: .touchUpInside)
    myView.myCouponButton.addTarget(self, action: #selector(tapMyCouponButton), for: .touchUpInside)
  }
  
  // MARK: - Handler
  @objc private func tapCancelButton() {
    dismiss(animated: true)
  }
  
  @objc private func tapCouponBookButton() {
    if currentSelectedTableView == .myCoupon {
      myView.buttonBottomView.center.x -= UIScreen.main.bounds.width/2
      currentSelectedTableView = .couponBook
      tableView.reloadData()
    }
  }
  
  @objc private func tapMyCouponButton() {
    if currentSelectedTableView == .couponBook {
      myView.buttonBottomView.center.x += UIScreen.main.bounds.width/2
      currentSelectedTableView = .myCoupon
      tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource
extension UserCouponVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    switch currentSelectedTableView {
    case .couponBook:
      return userCouponList?.count ?? 0
    case .myCoupon:
      return 5
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch currentSelectedTableView {
    case .couponBook:
      guard let userCouponList = userCouponList else { fatalError() }
      let cell = UserCouponBookCell(cellType: cellTypeArray[indexPath.section], couponData: userCouponList[indexPath.section])
      cell.couponData = userCouponList[indexPath.section]
      cell.selectedBackgroundView = cellSelectedBackgroundView
      return cell
    case .myCoupon:
      let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
      return cell
    }
  }
}

// MARK: - UITableViewDelegate
extension UserCouponVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.section == 0 {
      let alertController = UIAlertController(title: "알림", message: "'쏘카'에서 '카카오톡'을(를) 열려고 합니다.", preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: nil))
      alertController.addAction(UIAlertAction(title: "열기", style: .default, handler: nil))
      present(alertController, animated: true, completion: nil)
      return
    }
    
    guard let cell = tableView.cellForRow(at: indexPath) as? UserCouponBookCell else { return }
    let couponDetailVC = CouponDetailVC()
    couponDetailVC.couponDate = cell.couponData
    couponDetailVC.modalPresentationStyle = .overFullScreen
    present(couponDetailVC, animated: false, completion: nil)
  }
}
