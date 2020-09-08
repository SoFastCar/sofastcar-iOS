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
  var sectionTitle: [TalbleViewCellType] = [.insuranceCell, .usingTiemCell, .usingSocarZone, .business]
  enum TalbleViewCellType: String {
    case insuranceCell = "차량손해면책 상품"
    case usingTiemCell = "이용시간"
    case usingSocarZone = "이용장소"
    case business = "비지니스 예약"
  }
  
  var isEelectronicCar: Bool = false
  
  let reservationCostInfoButton: UIButton = {
    let button = UIButton()
    button.setTitle("총 합계 23,380원", for: .normal)
    button.contentVerticalAlignment = .top
    button.backgroundColor = CommonUI.mainDark
    button.titleEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.titleLabel?.textColor = .white
    button.isEnabled = false
    return button
  }()
  
  let reservationConfirmButton: UIButton = {
    let button = UIButton()
    button.setTitle("결제정보 확인", for: .normal)
    button.contentVerticalAlignment = .top
    button.titleEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    button.backgroundColor = CommonUI.mainBlue
    button.titleLabel?.textColor = .white
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return button
  }()
  
  // MARK: - Life Cycle
  init() {
    super.init(style: .grouped)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureStatusBar()
    configureNavigationContoller()
    configureTableHeaderView()
    configureReservationConfirmButton()
    configureButtonAction()
    
    if isEelectronicCar {
      guard let headerView = tableView.tableHeaderView as? ReservationConfirmTableHeaderView else { return }
      [headerView.electronicCarUsingTitle, headerView.electorinicCarDrivingCostInfoTextView, headerView.showElectronicCostWebViewButton] .forEach {
        $0.snp.updateConstraints {
          $0.height.equalTo(0)
        }
      }
      tableView.tableHeaderView?.frame = CGRect(x: 0, y: 10,
                                                width: UIScreen.main.bounds.width,
                                                height: 550)
    }

  }
  
  private func configureStatusBar() {
    let statusBar =  UIView()
    let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    guard let statusBarFrame = window?.windowScene?.statusBarManager?.statusBarFrame else { return }
    statusBar.frame = statusBarFrame
    statusBar.backgroundColor = .white
    UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
  }
  
  private func configureNavigationContoller() {
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .white
    
    navigationController?.navigationBar.barTintColor = UIColor.white
    
    title = "대여 정보 확인"
  }
  
  private func configureTableHeaderView() {
    tableView.allowsSelection = false
    tableView.register(ReservationConfirmCustomCell.self,
                       forCellReuseIdentifier: ReservationConfirmCustomCell.identifier)
    tableView.tableHeaderView = myHeaderView
    tableView.tableHeaderView?.frame = CGRect(x: 0, y: 10,
                                              width: UIScreen.main.bounds.width,
                                              height: 650)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 700
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
  }
  
  private func configureReservationConfirmButton() {
    [reservationCostInfoButton, reservationConfirmButton].forEach {
      tableView.addSubview($0)
    }
    
    reservationCostInfoButton.snp.makeConstraints {
      $0.leading.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(35)
      $0.height.equalTo(100)
    }
    
    reservationConfirmButton.snp.makeConstraints {
      $0.leading.equalTo(reservationCostInfoButton.snp.trailing)
      $0.trailing.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(35)
      $0.height.equalTo(reservationCostInfoButton)
      $0.width.equalTo(reservationCostInfoButton.snp.width).multipliedBy(0.5)
    }
  }
  
  private func configureButtonAction() {
    
  }
  
  // MARK: - Button Action
  
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
    cell.confiure(cellType: sectionTitle[indexPath.section].rawValue)
    cell.delegate = self
    return cell
  }
}

extension ReservationConfirmTableVC: ResrvationConfirmCellDelegate {
  func tabChangeInsuranceButton(forCell: ReservationConfirmCustomCell) {
    print("tabChangeInsuranceButton")
  }
  
  func tabChangeUsingTime(forCell: ReservationConfirmCustomCell) {
    print("tabChangeUsingTime")
  }
  
  func tabSocarZoneDetailButton(forCell: ReservationConfirmCustomCell) {
    print("tabSocarZoneDetailButton")
  }
}
