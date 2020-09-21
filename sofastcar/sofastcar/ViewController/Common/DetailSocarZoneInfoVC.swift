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
  
  static func allcases() -> [DetailSocarZoneInfoCellType] {
    return [mainTitle, subTitle, detailInfoButton]
  }
}

class DetailSocarZoneInfoVC: UITableViewController {
  // MARK: - Properties
  lazy var detailSocarzoneInfoCellTypeList = DetailSocarZoneInfoCellType.allcases()
  var socarZoneData: SocarZoneData?
  
  init(socarZoneData: SocarZoneData) {
    super.init(style: .grouped)
    self.socarZoneData = socarZoneData
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
    tableView.estimatedRowHeight = 600
    tableView.rowHeight = UITableView.automaticDimension
    tableView.sectionHeaderHeight = 0
    tableView.sectionFooterHeight = 10
    tableView.separatorStyle = .none
    tableView.register(DetailSocarZoneInfoCell.self, forCellReuseIdentifier: DetailSocarZoneInfoCell.identifier)
  }
  
  // MARK: - Button Action
  @objc private func tapCloseButton() {
    print("tapCloseButton")
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return detailSocarzoneInfoCellTypeList.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = DetailSocarZoneInfoCell(style: .default, reuseIdentifier: DetailSocarZoneInfoCell.identifier)
    cell.socarZoneData = self.socarZoneData
    cell.configureCellUI(cellType: detailSocarzoneInfoCellTypeList[indexPath.section])
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let view = UIView()
    view.backgroundColor = .systemGray6
    return view
  }
}
