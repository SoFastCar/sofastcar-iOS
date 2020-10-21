//
//  ReservationDetailTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

enum DetailTableViewType: Int {
  case rentalInfo = 0
  case paymentInfo = 1
  case etcInfo = 2
}

class ReservationDetailTableVC: UITableViewController {
  // MARK: - Properties
  let disposeBag = DisposeBag()
  
  private var socarVM: SocarViewModel!
  private var socarZoneVM: SocarZoneViewModel!
  private var reservationVM: ReservationViewModel!
  private var resrvationDetailVM: ReservationDetailViewModel!
  
  var socarZoneData: SocarZoneData?
  var socarData: Socar?
  var reservationData: Reservation?
  var paymentBefore: PaymentBefore?
  
  var customTableHeaderView = ReservationDetailHeader(frame: .zero)
  
  var showTableViewIndex: DetailTableViewType = .rentalInfo
  var isReservationEnd: Bool = false
  
  // MARK: - Life Cycle
  init(_ isReservationEnd: Bool, _ socarVM: SocarViewModel, _ socarZoneVM: SocarZoneViewModel, _ reservationVM: ReservationViewModel) {
    super.init(style: .grouped)
    self.socarVM = socarVM
    self.socarZoneVM = socarZoneVM
    self.reservationVM  = reservationVM
    self.isReservationEnd = isReservationEnd
    getPaymentBeforeInfo()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.backgroundColor = .systemGray6
    configureTableViewHeader()
    configureTableView()
  }
  
  private func configureTableViewHeader() {
    tableView.tableHeaderView = customTableHeaderView
    customTableHeaderView.closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
    tableView.tableHeaderView?.frame.size.height = 135
    
    customTableHeaderView.reservationStatueLabel.isSelected = isReservationEnd
    customTableHeaderView.reservationStatueLabel.backgroundColor = isReservationEnd ? .systemGray5 : CommonUI.mainDark
    
    socarVM.number.asDriver(onErrorJustReturn: "")
      .drive(customTableHeaderView.carNumberLabel.rx.text)
      .disposed(by: disposeBag)
    
    customTableHeaderView.segmentControll.addTarget(self, action: #selector(tabChangeTableViewMenuSegment(_:)), for: .valueChanged)
  }
  
  private func configureTableView() {
    tableView.allowsSelection = false
    tableView.estimatedRowHeight = 600
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
    tableView.separatorStyle = .none
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    guard let resrvationDetailVM = resrvationDetailVM else { return 0 }
    switch showTableViewIndex {
    case .rentalInfo:
      return resrvationDetailVM.rentalTypeTitleArray.count
    case .paymentInfo:
      return resrvationDetailVM.paymentTypeTitleArray.count
    case .etcInfo:
      return resrvationDetailVM.etcTypeTitleArray.count
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch showTableViewIndex {
    case .rentalInfo:
      let cell = ReservationRentalInfoCell(socarVM.socar, socarZoneVM.socarZone, reservationVM.reservation)
      cell.configureCell(cellType: resrvationDetailVM.rentalTypeTitleArray[indexPath.section])
      cell.delegate = self
            
      if resrvationDetailVM.rentalTypeTitleArray[indexPath.section] == .usingTime {
        cell.changeOptionButton.isHidden = true
      }
      return cell
    case .paymentInfo:
      let cell = ReservationPaymentCell(paymentBefore: resrvationDetailVM.payments[0].payment)
      cell.isReservationEnd = isReservationEnd
      cell.delegate = self
      cell.configureCell(cellType: resrvationDetailVM.paymentTypeTitleArray[indexPath.section])
      return cell
    case .etcInfo:
      let cell = ReservationEtcCell(style: .subtitle, reuseIdentifier: ReservationEtcCell.identifier)
      cell.buttonNameLabel.text = resrvationDetailVM.etcTypeTitleArray[indexPath.section].rawValue
      cell.delegate = self
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  // MARK: - Button Action
  @objc func tabChangeTableViewMenuSegment(_ sender: UISegmentedControl) {
    setShowingTableViewType(setIndex: sender.selectedSegmentIndex)
    changeHeaderViewTitleUnderLine(setIndex: sender.selectedSegmentIndex)
    tableView.reloadData()
  }
  
  private func setShowingTableViewType(setIndex: Int) {
    self.showTableViewIndex = DetailTableViewType.init(rawValue: setIndex) ?? DetailTableViewType.rentalInfo
  }
  
  private func changeHeaderViewTitleUnderLine(setIndex: Int) {
    customTableHeaderView.segmentindicator.snp.updateConstraints {
      $0.leading.equalTo(customTableHeaderView.segmentControll).offset(9+setIndex*83)
    }
  }
  
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
}

// MARK: - RentalInfoCell Button Action
extension ReservationDetailTableVC: ReservationRentalInfoCellDelegate {
  func tapChangeUsingTimeButton(forCell cell: ReservationRentalInfoCell) {
    print("tabChangeUsingTimeButton")
  }
  
  func tapReservationCancelButton(forCell cell: ReservationRentalInfoCell) {
    print("tabReservationCancelButton")
  }
  
  func tapDetailButton(forCell cell: ReservationRentalInfoCell, sectionTitle: String) {
    guard let socarZoneData = socarZoneData else { return }
    let detailSocarZoneInfoVC = DetailSocarZoneInfoVC(socarZoneData: socarZoneData)
    present(detailSocarZoneInfoVC, animated: true, completion: nil)
  }
}

// MARK: - PaymentCell Button Action
extension ReservationDetailTableVC: ReservationPaymentCellDelegte {
  func tapCompleteNotPaidCostButton(forCell cell: ReservationPaymentCell) {
    print("tapCompleteNotPaidCostButton")
  }
  
  func tapSendEmailButton(forCell cell: ReservationPaymentCell) {
    print("tapSendMailButton")
  }
  
  func tapShowReceiptButton(forCell cell: ReservationPaymentCell) {
    print("tapShowReceiptButton")
  }
}

// MARK: - EtcCell Button Action
extension ReservationDetailTableVC: ReservationEtcCellDelegate {
  func tapDownLoadReceipforPDF(forCell cell: ReservationEtcCell) {
    print("tapDownLoadReceipforPDF")
  }
  
  func tapShowWashingHistory(forCell cell: ReservationEtcCell) {
    print("tapShowWashingHistory")
  }
  
  func tapContectCustomerCenter(forCell cell: ReservationEtcCell) {
    print("tapContectCustomerCenter")
  }
}

// MARK: - NetworkService
extension ReservationDetailTableVC {
  
  private func getPaymentBeforeInfo() {
    
    URLRequest.load(resource: PaymentBefore.getPaymentInfo(reservationVM.reservation.reservationUid))
      .subscribe(onNext: { [weak self] payments in
        if let payments = payments?.results {
          self?.resrvationDetailVM = ReservationDetailViewModel(payments)
          DispatchQueue.main.async {
            self?.tableView.reloadData()
          }
        }
      }).disposed(by: disposeBag)
    
  }
}
