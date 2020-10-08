//
//  PaymentBefore.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct PaymentBeforeDataSet: Decodable {
  let next: String?
  let results: [PaymentBefore]
  let previous: String?
}

struct PaymentBefore: Decodable {
  let paymentBeforeUid: Int
  let member: Int
  let reservationUid: Int
  let rentalFee: Int
  let insuranceFee: Int
  let couponDiscount: Int
  let etcDiscount: Int
  let extensionFee: Int
  let totalFee: Int
  let creatTime: String
  let updateTime: String
  
  enum CodingKeys: String, CodingKey {
    case paymentBeforeUid = "id"
    case member
    case reservationUid = "reservation"
    case rentalFee = "rental_fee"
    case insuranceFee = "insurance_fee"
    case couponDiscount = "coupon_discount"
    case etcDiscount = "etc_discount"
    case extensionFee = "extension_fee"
    case totalFee = "total_fee"
    case creatTime = "created_at"
    case updateTime = "updated_at"
  }
}
