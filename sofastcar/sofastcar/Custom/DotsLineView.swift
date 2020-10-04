//
//  LineView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class DotsLineView: UIView {
  override func draw(_ rect: CGRect) {
    self.backgroundColor = .white
    let path = UIBezierPath()
    UIColor.systemGray4.set()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: 0))
    path.lineWidth = 5
    let pattern: [CGFloat] = [1, 1]
    path.setLineDash(pattern, count: pattern.count, phase: 0)
    path.stroke()
  }
  
  func drawVertical(_ rect: CGRect) {
//    super.draw(rect)
    self.backgroundColor = .white
    let path = UIBezierPath()
    CommonUI.mainBlue.set()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: 0, y: self.frame.height))
    path.lineWidth = 5
    let pattern: [CGFloat] = [1, 1]
    path.setLineDash(pattern, count: pattern.count, phase: 0)
    path.stroke()
  }
}
