//
//  Insurance.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class Insurance {
  
  var name: String!
  var guarantee: Int!
  var cost: Int!
  
  init(name: String, guarantee: Int, cost: Int) {
    self.name = name
    self.guarantee = guarantee
    self.cost = cost
  }
}
