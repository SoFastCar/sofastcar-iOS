//
//  RentHistoryVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum RentHistoryCellType {
  case headerViewCell
  case rentHistroyCell
  
  static func allcase() -> [RentHistoryCellType] {
    return [headerViewCell, rentHistroyCell]
  }
}

class RentHistoryVC: UITableViewController {
  // MARK: - Properties
  var reservations: [Reservation]?
  lazy var rentHistoryCellTypeList = RentHistoryCellType.allcase()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RentHistoryVC {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return rentHistoryCellTypeList.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : reservations?.count ?? 0
  }
}
