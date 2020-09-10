//
//  ReservationPaymentCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ReservationPaymentCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  
  // MARK: - Life Cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  // MARK: - configure
  func configureCell(cellType: PaymentCellType) {
    switch cellType {
    case <#pattern#>:
      <#code#>
    default:
      <#code#>
    }
  }
}
