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

extension CouponBook {
  
  static func testDataLoad() -> [CouponBook] {
    return [
      CouponBook(uid: "1", name: "", desctiption: "", usage: "", discountPrice: 10, restrictions: ""),
      CouponBook(uid: "1", name: "전기차 30% 할인", desctiption: "서울시 나눔카 전기차 전용", usage: "주중/주말 사용가능", discountPrice: 30, restrictions: "서울특별시 내 전기차 전용"),
      CouponBook(uid: "2", name: "전기차 1일 30% 할인", desctiption: "서울시 나눔카 전가차 전용", usage: "부름 요금 무료", discountPrice: 30, restrictions: "서울특별시 내 전기차 전용"),
      CouponBook(uid: "3", name: "경기 인천 전기차 30% 할인", desctiption: "경기/인천 전기차 전용", usage: "주중/주말 사용가능", discountPrice: 30, restrictions: "경기도,인천광역시 내 전기차 전용")
    ]
  }
}
