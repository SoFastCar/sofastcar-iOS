//
//  PaymentConfirmTableVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class PaymentConfirmTableVC: UITableViewController {
  // MARK: - Properties
  var sectionTitle: [PaymentCellType] = [.detailCostCell, .paymentCardCell, .warningBeforeReservationCell, .agreeAllTerms]
  enum PaymentCellType: String {
    case detailCostCell = "상세요금"
    case paymentCardCell = "결제카드"
    case warningBeforeReservationCell = "예약 전 주의사항"
    case agreeAllTerms = "약관동의"
  }
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureStatusBar()
    configureNavigationContoller()
    configureTableView()
    configureReservationConfirmButton()
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
    title = "결제 정보 확인"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = UIColor.white
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
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitle.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = PaymentConfirmCell(style: .default, reuseIdentifier: PaymentConfirmCell.identifier)
    cell.configureCellByType(cellType: sectionTitle[indexPath.section].rawValue)
    cell.delegate = self
    return cell
  }
  
  // MARK: - Button Action
  @objc func tabReservationFinishButton() {
    print("Tab complete Button")
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
