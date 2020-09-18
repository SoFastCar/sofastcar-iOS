//
//  NMapAddress.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class NMapAddress: Decodable {
  let roadAddress: String
  let jibunAddress: String
  let lat: Double
  let lng: Double
  
  enum CodingKeys: String, CodingKey {
    case roadAddress
    case jibunAddress
    case lat = "x"
    case lng = "y"
  }
}
