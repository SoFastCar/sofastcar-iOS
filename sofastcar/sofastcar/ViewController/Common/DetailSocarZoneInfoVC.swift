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
  var detailSocarzoneInfoCellTypeList: [DetailSocarZoneInfoCellType] = DetailSocarZoneInfoCellType.allcases()
  var socarZoneData: SocarZoneData?
  var socarDate: SocarList?
  
  init(socarZoneData: SocarZoneData) {
    super.init(style: .grouped)
    self.socarZoneData = socarZoneData
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    dismiss(animated: true, completion: nil)
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
    cell.delegate = self
    cell.closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
    cell.configureCellUI(cellType: detailSocarzoneInfoCellTypeList[indexPath.section])
    return cell
  }
}

extension DetailSocarZoneInfoVC: DetailSocarZoneInfoCellDelegate {
  func tapShowDetailInfo(forCell cell: DetailSocarZoneInfoCell) {
    guard let socarZoneData = socarZoneData else { return }
    let detailSocarZoneInfoVC = DetailSocarZoneInfoVC(socarZoneData: socarZoneData)
    present(detailSocarZoneInfoVC, animated: true, completion: nil)
  }
  
  func tapShowLoactionInMap(forCell cell: DetailSocarZoneInfoCell) {
    print("tapShowLoactionInMap")
  }
  
  func tapFindWayToSocarZone(forCell cell: DetailSocarZoneInfoCell) {
    print("tapFindWayToSocarZone")
  }
  
}
