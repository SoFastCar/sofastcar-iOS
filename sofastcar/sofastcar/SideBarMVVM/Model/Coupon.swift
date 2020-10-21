//
//  Coupon.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/28.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class Coupon {
  var uid: String!
  var name: String!
  var description: String!
  var discountPrice: Int!
  
  init(uid: String, name: String, desctiption: String, discountPrice: Int) {
    self.uid = uid
    self.name = name
    self.description = desctiption
    self.discountPrice = discountPrice
  }
}
