//
//  ReservationConfirmTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationConfirmTableVC: UITableViewController {
  // MARK: - Properties
  let myHeaderView = ReservationConfirmTableHeaderView()
  
  lazy var sectionTitle: [TalbleViewCellType: String] = [
    .insuranceCell: "차량손해면책 상품",
    .usingTiemCell: "이용시간",
    .usingSocarZone: "이용장소",
    .business: "비지니스 예약"
  ]
  
  enum TalbleViewCellType: Int {
    case insuranceCell = 0
    case usingTiemCell = 1
    case usingSocarZone = 2
    case business = 3
  }
  
  // MARK: - Life Cycle
  init() {
    super.init(style: .grouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNavigationContoller()
    
    configureTableHeaderView()
  }
  
  private func configureNavigationContoller() {
    navigationController?.navigationBar.prefersLargeTitles = true
    title = "대여 정보 확인"
  }
  
  private func configureTableHeaderView() {
//    tableView.backgroundColor = .white
    
    tableView.tableHeaderView = myHeaderView
//    tableView.estimatedSectionHeaderHeight = 300
    tableView.tableHeaderView?.frame.size.height = 300
    
    tableView.register(ReservationConfirmCustomCell.self,
                       forCellReuseIdentifier: ReservationConfirmCustomCell.identifier)
    
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 80
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitle.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ReservationConfirmCustomCell.identifier,
                                                   for: indexPath) as? ReservationConfirmCustomCell else { fatalError() }
    
    return cell
  }
  // MARK: - UITableViewDelegate
  
}
