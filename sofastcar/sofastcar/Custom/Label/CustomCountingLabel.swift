//
//  CustomCountingLabel.swift
//  sofastcar
//
//  Created by 요한 on 2020/10/07.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CustomCountingLabel: UILabel {
  
  let counterVelocity: Float = 3.0
  
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
  
  var timer: Timer?
  
  var counterType: CounterType!
  var counterAnimationType: CounterAnimationType!
  
  func count(fromValue: Float, to toValue: Float, withDuration duration: TimeInterval, andAnimationType animationType: CounterAnimationType, andCounterType counterType: CounterType) {
    
    self.startNumber = fromValue
    self.endNumber = toValue
    self.duration = duration
    self.counterType = counterType
    self.counterAnimationType = animationType
    self.progress = 0
    self.lastUpdate = Date.timeIntervalSinceReferenceDate
    
    invalidateTimer()
    
    timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(CustomCountingLabel.updateValue), userInfo: nil, repeats: true)
    
    
  }
  
  @objc func updateValue() {
    let now = Date.timeIntervalSinceReferenceDate
    progress = progress + (now - lastUpdate)
    lastUpdate = now
    
    if progress >= duration {
      invalidateTimer()
      progress = duration
    }
    
  }
  
  func updateText(value: Float) {
    switch counterType! {
    case .Int:
      self.text = "\(Int(value))"
    case .Float:
      self.text = "\(Int(value))"
    }
  }
  
  func updateCounter(counterValue: Float) -> Float {
    switch counterAnimationType! {
    case .Linear:
      return counterValue
    case .EaseIn:
      return powf(counterValue, counterVelocity)
    case .EaseOut:
      return 1.0 - powf(1.0 - counterValue, counterVelocity)
    }
  }

  func invalidateTimer() {
    timer?.invalidate()
    timer = nil
  }
}
