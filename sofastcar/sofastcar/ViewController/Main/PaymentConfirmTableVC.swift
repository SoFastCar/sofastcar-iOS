//
//  PaymentConfirmTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Alamofire

enum PaymentConfirmCellType: String {
  case detailCostCell = "상세요금"
  case paymentCardCell = "결제카드"
  case warningBeforeReservationCell = "예약 전 주의사항"
  case agreeAllTerms = "약관동의"
  
  static func allcase() -> [PaymentConfirmCellType] {
    return [detailCostCell, paymentCardCell, warningBeforeReservationCell, agreeAllTerms]
  }
}

class PaymentConfirmTableVC: UITableViewController {
  // MARK: - Properties
  var insuranceData: Insurance?
  var rentPrice: Int?
  var socarData: SocarList?
  var socarZoneData: SocarZoneData?
  var startDate: Date?
  var endDate: Date?
  
  lazy var tableViewCellArray: [PaymentConfirmCellType] = PaymentConfirmCellType.allcase()
  
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
  
  let reservationFinishButton: CompleteButton = {
    let button = CompleteButton(frame: .zero, title: "예약 완료하기")
    button.contentVerticalAlignment = .top
    button.contentEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 0)
    button.titleLabel?.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    button.addTarget(self, action: #selector(tabReservationFinishButton), for: .touchUpInside)
    return button
  }()
  
  // MARK: - Life Cycle
  override init(style: UITableView.Style) {
    super.init(style: style)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureNavigationContoller()
    configureTableView()
    configureReservationConfirmButton()
    setTotalPriceAtResertvationCompleteButton()
  }
  
  private func configureNavigationContoller() {
    title = "결제 정보 확인"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = UIColor.white
    navigationController?.navigationBar.topItem?.title = ""
  }
  
  private func configureTableView() {
    tableView.register(PaymentConfirmCell.self, forCellReuseIdentifier: PaymentConfirmCell.identifier)
    tableView.rowHeight = UITableView.automaticDimension
    tableView.allowsSelection = false
    tableView.estimatedRowHeight = 700
    tableView.sectionHeaderHeight = 10
    tableView.sectionFooterHeight = 0
    tableView.separatorStyle = .none
  }
  
  private func configureReservationConfirmButton() {
    [reservationCostInfoButton, reservationFinishButton].forEach {
      tableView.addSubview($0)
    }
    
    reservationCostInfoButton.snp.makeConstraints {
      $0.leading.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(35)
      $0.height.equalTo(100)
    }
    
    reservationFinishButton.snp.makeConstraints {
      $0.leading.equalTo(reservationCostInfoButton.snp.trailing)
      $0.trailing.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(35)
      $0.height.equalTo(reservationCostInfoButton)
      $0.width.equalTo(reservationCostInfoButton.snp.width).multipliedBy(0.5)
    }
  }
  
  func configurePaymentConfirmTableVC(rentPrice: Int, insuranceData: Insurance, socarData: SocarList, socarZoneData: SocarZoneData) {
    self.rentPrice = rentPrice
    self.insuranceData = insuranceData
    self.socarData = socarData
    self.socarZoneData = socarZoneData
    tableView.reloadData()
  }
  // MARK: - Handler
  private func setTotalPriceAtResertvationCompleteButton() {
    guard let rentPrice = rentPrice ,
        let insurancePrice = insuranceData?.cost else { return }
    let totalPrice = rentPrice + insurancePrice
    let totalPriceWithDot = totalPrice.priceWithDots()
    reservationCostInfoButton.setTitle("총 합계 \(totalPriceWithDot) 원", for: .normal)
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewCellArray.count 
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = PaymentConfirmCell(style: .default, reuseIdentifier: PaymentConfirmCell.identifier)
    cell.delegate = self
    cell.insuranceData = insuranceData
    cell.rentPrice = rentPrice
    cell.configureCellByType(cellType: tableViewCellArray[indexPath.section])
    return cell
  }
  
  // MARK: - Button Action
  @objc func tabReservationFinishButton() {
    guard let socarzoneUid = socarZoneData?.id else { return }
    guard let socarUid = socarData?.id else { return }
    guard let insuranceName = insuranceData?.name else { return }
    guard let startDate = startDate else { return }
    guard let endDate = endDate else { return }
    var insuranceCaseName: String = ""
    switch insuranceName {
    case "라이트":
      insuranceCaseName = "light"
    case "스탠다드":
      insuranceCaseName = "standard"
    case "스페셜":
      insuranceCaseName = "special"
    default:
      insuranceCaseName = "standard"
    }
    
    let url = URL(string: "https://sofastcar.moorekwon.xyz/carzones/\(socarzoneUid)/cars/\(Int(socarUid))/reservations")!

    let utcStartDate = Time.toStringUTC(changeForDate: startDate)
    let utcEndDate = Time.toStringUTC(changeForDate: endDate)
    let reservationData = [
      "insurance": insuranceCaseName,
      "date_time_start": utcStartDate,
      "date_time_end": utcEndDate
    ]
    
    AF.request(url, method: .post, parameters: reservationData, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"])
      .responseJSON { response in
        if response.response?.statusCode == 201 {
          guard let responseData = response.data else { return }
          
          if let jsonData = try? JSONSerialization.jsonObject(with: responseData) as? [String: AnyObject] {
            if let reservationUid = jsonData["id"] as? Int {
              print(reservationUid)
              UserDefaults.setReservationUid(uid: reservationUid)
              let reservationDashboardVC = ReservationDashboardVC()
              reservationDashboardVC.modalPresentationStyle = .overFullScreen
              self.present(reservationDashboardVC, animated: false, completion: nil)
            }
          }
        } else {
          print("====Reservation Update fail====")
          print(response.response?.statusCode)
          print(response.error)
        }
      }
    
  }
}

extension PaymentConfirmTableVC: PaymentConfirmCellDelegate {
  func tapChangeCouponButton(forCell: PaymentConfirmCell) {
    print("tabChangeCouponButton")
  }
  
  func tapChangePaymentCardButton(forCell: PaymentConfirmCell) {
    print("tabChangePaymentCardButton")
  }
  
  func tapWarningBeforeConfirmButton(forCell: PaymentConfirmCell) {
    print("tabWarningBeforeConfirmButton")
  }
  
  func tapAgreeButton(forCell: PaymentConfirmCell, tapedButton: TouButton) {
    let allagreeButton = forCell.customAuthAllAgreeButton
    tapedButton.isSelected.toggle()
    if tapedButton == allagreeButton {
      forCell.customerAgreeButtonArray.forEach {
        $0.isSelected = tapedButton.isSelected // 전체 동의시 하위 버튼 동일하게 변경
      }
    } else {
      allagreeButton.isSelected = true
      forCell.customerAgreeButtonArray.forEach {
        if $0.isSelected == false {
          allagreeButton.isSelected = allagreeButton.isSelected && $0.isSelected
        }
      }
    }
    reservationFinishButton.isEnabled = allagreeButton.isSelected
  }
}
