//
//  Protocol.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

protocol ResrvationConfirmCellDelegate: class {
  func tabChangeInsuranceButton(forCell: ReservationConfirmCustomCell)
  func tabChangeUsingTime(forCell: ReservationConfirmCustomCell)
  func tabSocarZoneDetailButton(forCell: ReservationConfirmCustomCell)
}
