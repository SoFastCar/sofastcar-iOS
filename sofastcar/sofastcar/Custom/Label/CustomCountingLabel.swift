//
//  CustomCountingLabel.swift
//  sofastcar
//
//  Created by 요한 on 2020/10/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomCountingLabel: UILabel {
  enum CounterAnimationType {
    case Linear
    case EaseIn
    case EaseOut
  }
  
  enum CounterType {
    case Int
    case Float
  }
  
  var startNumber: Float = 0.0
  var endNumber: Float = 0.0
  
  var progress: TimeInterval!
  var duration: TimeInterval!
  var lastUpdate: TimeInterval!
  
  var time: Timer?
  
  var counterType: CounterType!
  var counterAnimationType: CounterAnimationType!
  
  func count(fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType: CounterAnimationType, andCounterType counterType: CounterType) {
    
  }
}
