//
//  CouponView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CouponView: UIView {
  let textFontSize: CGFloat = 13
  let buttonWidth: CGFloat = 50
  
  var couponIndex = 12
  var couponName = "월간 저녁 쿠폰 - 최대 16시간"
  var couponPrice = 9000
  var couponInfo = "월간 쿠폰, 매달 다운로드 가능"
  
  lazy var couponTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "[쏘카클럽] \(couponName)"
    label.font = .boldSystemFont(ofSize: textFontSize)
    return label
  }()
  
  lazy var couponPriceLabel: UILabel = {
    let label = UILabel()
    label.text = "\(couponPrice)원"
    label.font = .boldSystemFont(ofSize: textFontSize)
    return label
  }()
  
  lazy var couponInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "\(couponInfo)"
    label.font = .systemFont(ofSize: textFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  lazy var downloadButton: UIButton = {
    let button = UIButton()
    button.setTitle("\(couponIndex)", for: .selected)
    button.setImage(UIImage(systemName: "tray.and.arrow.down.fill"), for: .normal)
    button.imageView?.tintColor = .white
    button.backgroundColor = .systemGray4
    button.layer.cornerRadius = buttonWidth/2
    return button
  }()
  
  override func draw(_ rect: CGRect) {
    self.backgroundColor = .white
    let path = UIBezierPath()
    UIColor.systemGray4.set()
    path.move(to: CGPoint(x: 0, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: 0))
    path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
    path.addLine(to: CGPoint(x: 0, y: self.frame.height))
    path.addLine(to: CGPoint(x: 0, y: 70))
    path.addCurve(to: CGPoint(x: 0, y: 40), controlPoint1: CGPoint(x: 25, y: 70), controlPoint2: CGPoint(x: 25, y: 40))
    path.addLine(to: CGPoint(x: 0, y: 0))
    path.close()
    path.lineWidth = 2
    path.stroke()
    
    configureLabelUI()
  }
  
  private func configureLabelUI() {
    [couponTitleLabel, couponPriceLabel, couponInfoLabel, downloadButton].forEach {
      addSubview($0)
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
      couponPriceLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      couponPriceLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
      
      couponTitleLabel.bottomAnchor.constraint(equalTo: couponPriceLabel.topAnchor, constant: -5),
      couponTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
      
      couponInfoLabel.topAnchor.constraint(equalTo: couponPriceLabel.bottomAnchor, constant: 5),
      couponInfoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 35),
      
      downloadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      downloadButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
      downloadButton.widthAnchor.constraint(equalToConstant: buttonWidth),
      downloadButton.heightAnchor.constraint(equalToConstant: buttonWidth)
    ])
  }
}
