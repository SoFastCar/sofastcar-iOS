//
//  CouponBook.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class CouponBook {
  var uid: String!
  var name: String!
  var description: String!
  var usage: String!
  var discountPrice: Int!
  var restrictions: String!
  
  init(uid: String, name: String, desctiption: String, usage: String, discountPrice: Int, restrictions: String) {
    self.uid = uid
    self.name = name
    self.description = desctiption
    self.usage = usage
    self.discountPrice = discountPrice
    self.restrictions = restrictions
  }
}
