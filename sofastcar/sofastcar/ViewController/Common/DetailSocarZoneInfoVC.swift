//
//  DetailSocarZoneInfoVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum DetailSocarZoneInfoCellType: String {
  case mainTitle = "주차장"
  case subTitle = "쏘카 이용 매너"
  case detailInfoButton = "상세안내 더보기"
  case warningForUsing = "이용 주의사항"
  
  static func allcases(isReservationEnd: Bool) -> [DetailSocarZoneInfoCellType] {
    return isReservationEnd == true ? [mainTitle, subTitle, detailInfoButton] : [mainTitle, warningForUsing, subTitle]
  }
}

class DetailSocarZoneInfoVC: UITableViewController {
  // MARK: - Properties
  var detailSocarzoneInfoCellTypeList: [DetailSocarZoneInfoCellType]?
  var socarZoneData: SocarZoneData?
  
  init(socarZoneData: SocarZoneData, isReservationEnd: Bool) {
    super.init(style: .grouped)
    self.socarZoneData = socarZoneData
    detailSocarzoneInfoCellTypeList = DetailSocarZoneInfoCellType.allcases(isReservationEnd: isReservationEnd)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.allowsSelection = false
    tableView.estimatedRowHeight = 600
    tableView.rowHeight = UITableView.automaticDimension
    tableView.sectionHeaderHeight = 0
    tableView.sectionFooterHeight = 20
    tableView.separatorStyle = .none
    tableView.register(DetailSocarZoneInfoCell.self, forCellReuseIdentifier: DetailSocarZoneInfoCell.identifier)
  }
  
  // MARK: - Button Action
  @objc private func tapCloseButton() {
    print("tapCloseButton")
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    guard let menuList = detailSocarzoneInfoCellTypeList else { fatalError() }
    return menuList.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = DetailSocarZoneInfoCell(style: .default, reuseIdentifier: DetailSocarZoneInfoCell.identifier)
    cell.socarZoneData = self.socarZoneData
    guard let menuList = detailSocarzoneInfoCellTypeList else { fatalError()  }
    cell.configureCellUI(cellType: menuList[indexPath.section])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .systemGray6
    return view
  }
}
