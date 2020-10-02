//
//  NSData+Int8.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/30.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

extension Data {
  static func dataWithValue(value: Int8) -> Data {
    var variableValue = value
    return Data(buffer: UnsafeBufferPointer(start: &variableValue, count: 1))
  }
  
  func int8Value() -> Int8 {
    return Int8(bitPattern: self[0])
  }
}
