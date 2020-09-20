//
//  RentHistoryVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class RentHistoryVC: UITableViewController {
  // MARK: - Properties
  var reservations: [Reservation]?
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTableView()
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(RentHistoryCell.self, forCellReuseIdentifier: RentHistoryCell.identifier)
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension RentHistoryVC {
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = RentHistoryCell(style: .default, reuseIdentifier: RentHistoryCell.identifier)
    return cell
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : reservations?.count ?? 3
  }
}
