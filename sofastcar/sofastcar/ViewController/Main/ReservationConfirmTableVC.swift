//
//  ReservationConfirmTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum TalbleViewCellType: String {
  case blank = ""
  case insuranceCell = "차량손해면책 상품"
  case usingTiemCell = "이용시간"
  case usingSocarZone = "이용장소"
  case business = "비지니스 예약"
  
  static func allcases() -> [TalbleViewCellType] {
    return [blank, insuranceCell, usingTiemCell, usingSocarZone, business]
  }
}

class ReservationConfirmTableVC: UITableViewController {
  // MARK: - Properties
  var socarZoneData: SocarZoneData?
  var insuranceData: Insurance?
  var socarData: SocarList? {
    didSet {
      isSocarSaveCar = isSaveCarCheck()
      isElectronicCar = isEelctronicCarCheck()
      isBurom = isBuromCheck()
    }
  }
  var startDate: Date?
  var endDate: Date?
  var newStartDate: Date?
  var newEndDate: Date?
  var totalPrice: Int? {
    didSet {
      guard let totalPrice = totalPrice else { return }
      reservationCostInfoButton.setTitle("총 합계 \(totalPrice) 원", for: .normal)
    }
  }
  var headerViewHeight: CGFloat = 650
  var isSocarSaveCar: Bool = false
  var isElectronicCar: Bool = false
  var isBurom: Bool = false
  
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
    button.addTarget(self, action: #selector(tabReservationConfirmButton), for: .touchUpInside)
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
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.isNavigationBarHidden = false
    navigationController?.navigationBar.isHidden = false
    configureNavigationContoller()
    tableView.reloadData()
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
    title = "대여 정보 확인"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = UIColor.white
    navigationController?.navigationBar.tintColor = UIColor.black
  }
  
  private func calculateTableViewHeaderHeight() {
    headerViewHeight -= isSocarSaveCar == true ? 0 : 15
    headerViewHeight -= isElectronicCar == true ? 0 : 130
  }
  
  private func configureTableHeaderView() {
    let myHeaderView = ReservationConfirmTableHeaderView(frame: .zero, isElecticCar: isElectronicCar, isBurom: isBurom, isSocarSaveCar: isSocarSaveCar)
    configureTableHeaderViewContents(myHeaderView: myHeaderView)
    calculateTableViewHeaderHeight()
    tableView.allowsSelection = false
    tableView.register(ReservationConfirmCustomCell.self,
                       forCellReuseIdentifier: ReservationConfirmCustomCell.identifier)
    tableView.tableHeaderView = myHeaderView
    tableView.tableHeaderView?.frame = CGRect(x: 0, y: 10,
                                              width: UIScreen.main.bounds.width,
                                              height: headerViewHeight)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 700
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
  }
  
  private func isSaveCarCheck() -> Bool {
    // 로직 필요 true / false
    isSocarSaveCar = false
    return false
  }
  
  private func isEelctronicCarCheck() -> Bool {
    guard let feulType = socarData?.fuelType else { return false }
    isElectronicCar = feulType == "전기" ? true : false
    return isElectronicCar
  }
  
  private func isBuromCheck() -> Bool {
    // 로직
    return false
  }
  
  private func configureTableHeaderViewContents(myHeaderView: ReservationConfirmTableHeaderView) {
    guard let socarData = socarData else { return }
    myHeaderView.carImage.loadImage(with: socarData.image)
    myHeaderView.carName.text = socarData.name
    socarData.safetyOpt.split(separator: ",").forEach {
      myHeaderView.safetyOptions.append(String($0))
    }
    myHeaderView.safetyOptions.append("∙∙∙")
    myHeaderView.collectionView.reloadData()
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
  
  // MARK: - Button Action
  @objc func tabReservationConfirmButton() {
    let paymentConfirmTableVC = PaymentConfirmTableVC(style: .grouped)
    navigationController?.pushViewController(paymentConfirmTableVC, animated: true)
  }
  
  // MARK: - UITableViewDataSource
  override func numberOfSections(in tableView: UITableView) -> Int {
    return TalbleViewCellType.allcases().count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = ReservationConfirmCustomCell(style: .default, reuseIdentifier: ReservationConfirmCustomCell.identifier)
    let cellTypeArray = TalbleViewCellType.allcases()
    cell.confiure(cellType: cellTypeArray[indexPath.section])
    cell.delegate = self
    switch cellTypeArray[indexPath.section] {
    case .insuranceCell:
      cell.insuranceInfo = insuranceData
    case .usingSocarZone:
      cell.socarZone = socarZoneData
    case .usingTiemCell:
      cell.startDate = startDate
      cell.endDate = endDate
    case .business, .blank:
      break
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return indexPath.section == 0 ? 0 : UITableView.automaticDimension
  }
}

extension ReservationConfirmTableVC: ResrvationConfirmCellDelegate {
  func tapChangeInsuranceButton(forCell: ReservationConfirmCustomCell) {
    print("tabChangeInsuranceButton")
  }
  
  func tapChangeUsingTime(forCell: ReservationConfirmCustomCell) {
    guard let startDate = startDate,
          let endDate = endDate else { return }
    let bookingTimeVC = BookingTimeVC()
    bookingTimeVC.startDate = startDate
    bookingTimeVC.endDate = endDate
    present(bookingTimeVC, animated: true)
  }
  
  func tapSocarZoneDetailButton(forCell: ReservationConfirmCustomCell) {
    print("tabSocarZoneDetailButton")
  }
  
  func reloadUsingTimeCell() {    
    tableView.reloadRows(at: [IndexPath(row: 0, section: 2)], with: .none)
  }
}
