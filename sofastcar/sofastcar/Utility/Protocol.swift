//
//  Protocol.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

protocol ResrvationConfirmCellDelegate: class {
  func tabChangeInsuranceButton(forCell cell: ReservationConfirmCustomCell)
  func tabChangeUsingTime(forCell cell: ReservationConfirmCustomCell)
  func tabSocarZoneDetailButton(forCell cell: ReservationConfirmCustomCell)
}

protocol PaymentConfirmCellDelegate: class {
  func tabChangeCouponButton(forCell cell: PaymentConfirmCell)
  func tabChangePaymentCardButton(forCell cell: PaymentConfirmCell)
  func tabWarningBeforeConfirmButton(forCell cell: PaymentConfirmCell)
  func tabAgreeButton(forCell cell: PaymentConfirmCell, tapedButton: TouButton)
}
