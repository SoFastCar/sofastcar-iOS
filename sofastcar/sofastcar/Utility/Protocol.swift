//
//  Protocol.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

protocol ResrvationConfirmCellDelegate: class {
  func tapChangeInsuranceButton(forCell cell: ReservationConfirmCustomCell)
  func tapChangeUsingTime(forCell cell: ReservationConfirmCustomCell)
  func tapSocarZoneDetailButton(forCell cell: ReservationConfirmCustomCell)
}

protocol PaymentConfirmCellDelegate: class {
  func tapChangeCouponButton(forCell cell: PaymentConfirmCell)
  func tapChangePaymentCardButton(forCell cell: PaymentConfirmCell)
  func tapWarningBeforeConfirmButton(forCell cell: PaymentConfirmCell)
  func tapAgreeButton(forCell cell: PaymentConfirmCell, tapedButton: TouButton)
}

protocol ReservationRentalInfoCellDelegate: class {
  func tapChangeUsingTimeButton(forCell cell: ReservationRentalInfoCell)
  func tapReservationCancelButton(forCell cell: ReservationRentalInfoCell)
  func tapDetailButton(forCell cell: ReservationRentalInfoCell, sectionTitle: String)
}
