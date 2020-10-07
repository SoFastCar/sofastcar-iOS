//
//  ReservationDetailTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire

enum DetailTableViewType: Int {
  case rentalInfo = 0
  case paymentInfo = 1
  case etcInfo = 2
}

enum RentalCellType: String {
  case usingTime = "이용시간"
  case rentCarInfo = "차량정보"
  case socarZone = "이용장소"
  case otherDriver = "동승운전자"
  case insurance = "차량손해면책 상품"
  case cancelWarning = "취소수수로 및 패털티 안내"
  case cancel = "예약 취소하기"
  case blank = "빈칸"
}

enum PaymentCellType: String {
  case serviceTotalCost = "서비스 이용 총 금액"
  case beforeCost = "운행 전 요금"
  case afterCost = "운행 후 요금"
  case blank = "빈칸"
}

enum EtcCellType: String {
  case usingPdfDownLoad = "이용내역서(pdf) 다운로드"
  case washingCarHistory = "세차 기록 보기"
  case contectCustomerCenter = "이 예약 고객센터 문의하기"
  case blank = ""
}

class ReservationDetailTableVC: UITableViewController {
  // MARK: - Properties
  var socarZoneData: SocarZoneData?
  var socarData: Socar?
  var reservationData: Reservation?
  var paymentBefore: PaymentBefore?
  
  var customTableHeaderView: ReservationDetailHeader?
  var rentalTypeTitleArray: [RentalCellType] = [.blank, .usingTime, .rentCarInfo, .socarZone, .otherDriver, .insurance, .cancelWarning, .cancel]
  var paymentTypeTitleArray: [PaymentCellType] = [.blank, .serviceTotalCost, .beforeCost, .afterCost]
  var etcTypeTitleArray: [EtcCellType] = [.blank, .usingPdfDownLoad, .washingCarHistory, .contectCustomerCenter]
  var showTableViewIndex: DetailTableViewType = .rentalInfo
  var isReservationEnd: Bool = false
  
  // MARK: - Life Cycle
  init(_ isReservationEnd: Bool, _ socar: Socar, _ socarZoneData: SocarZoneData, _ reservation: Reservation) {
    super.init(style: .grouped)
    self.socarData = socar
    self.socarZoneData = socarZoneData
    self.isReservationEnd = isReservationEnd
    self.reservationData = reservation
    getReservaionPaymentInfo(reservation: reservation)
    customTableHeaderView = ReservationDetailHeader(frame: .zero, isReservationEnd, socar.number)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    tableView.backgroundColor = .systemGray6
    configureTableView()
    configureTableViewSegController()
  }
  
  private func configureTableView() {
    tableView.allowsSelection = false
    tableView.tableHeaderView = customTableHeaderView
    customTableHeaderView?.closeButton.addTarget(self, action: #selector(tapCloseButton), for: .touchUpInside)
    tableView.tableHeaderView?.frame.size.height = 135
    tableView.estimatedRowHeight = 600
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
    tableView.separatorStyle = .none
  }
  
  private  func configureTableViewSegController() {
    customTableHeaderView?.segmentControll.addTarget(self, action: #selector(tabChangeTableViewMenuSegment(_:)), for: .valueChanged)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    //var namesCount = Enum.GetNames(typeof(MyEnum)).Length;
    switch showTableViewIndex {
    case .rentalInfo:
      return rentalTypeTitleArray.count
    case .paymentInfo:
      return paymentTypeTitleArray.count
    case .etcInfo:
      return etcTypeTitleArray.count
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch showTableViewIndex {
    case .rentalInfo:
      guard let socarData = socarData else { fatalError() }
      guard let socarZoneData = socarZoneData else { fatalError() }
      guard let reservationData = reservationData else { fatalError() }
      let cell = ReservationRentalInfoCell(socarData, socarZoneData, reservationData)
      cell.configureCell(cellType: rentalTypeTitleArray[indexPath.section])
      cell.delegate = self
      if rentalTypeTitleArray[indexPath.section] == .usingTime {
//        guard let reservationStatus = customTableHeaderView?.reservationStatueLabel.isSelected else { fatalError() }
        cell.changeOptionButton.isHidden = true
      }
      return cell
    case .paymentInfo:
      guard let paymentBefore = paymentBefore else { fatalError() }
      let cell = ReservationPaymentCell(paymentBefore: paymentBefore)
      cell.isReservationEnd = isReservationEnd
      cell.delegate = self
      cell.configureCell(cellType: paymentTypeTitleArray[indexPath.section])
      return cell
    case .etcInfo:
      let cell = ReservationEtcCell(style: .subtitle, reuseIdentifier: ReservationEtcCell.identifier)
      cell.buttonNameLabel.text = etcTypeTitleArray[indexPath.section].rawValue
      cell.delegate = self
      if etcTypeTitleArray[indexPath.section] == .blank {
        cell.rightSideImage.image = UIImage()
      }
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if showTableViewIndex == .etcInfo {
      return indexPath.section == 0 ? 0 : 65
    }
    if indexPath.section == 0 {
      return CGFloat(0)
    }
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
    guard let view = customTableHeaderView else { return }
    view.segmentindicator.snp.updateConstraints {
      $0.leading.equalTo(view.segmentControll).offset(9+setIndex*83)
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
  private func getReservaionPaymentInfo(reservation: Reservation) {
    print("Start Download")
    let paymentBefore = URL(string: "https://sofastcar.moorekwon.xyz/reservations/\(reservation.reservationUid)/payment_before")!
    AF.request(paymentBefore, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"]).validate().responseDecodable(of: PaymentBeforeDataSet.self, queue: .main, completionHandler: { (response) in
      switch response.result {
      case .success(let paymentBefore):
        self.paymentBefore = paymentBefore.results[0]
      case .failure(let error):
        print("fail to get payment Before Data", error.localizedDescription)
      }
    })
  }
}
