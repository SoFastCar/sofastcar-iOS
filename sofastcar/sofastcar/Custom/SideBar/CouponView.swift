//
//  CouponView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CouponView: UIView {
  var coupon: Coupon?
  
  let couponTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중...."
    label.font = .boldSystemFont(ofSize: 13)
    return label
  }()
  
  let couponPriceLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중...."
    label.font = .boldSystemFont(ofSize: 13)
    return label
  }()
  
  let couponInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중...."
    label.font = .systemFont(ofSize: 13)
    label.textColor = .darkGray
    return label
  }()
  
  let downloadButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "tray.and.arrow.down.fill"), for: .normal)
    button.imageView?.tintColor = .white
    button.backgroundColor = .systemGray4
    button.layer.cornerRadius = 25
    return button
  }()
  
  init(frame: CGRect, coupon: Coupon) {
    super.init(frame: frame)
    self.coupon = coupon
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
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
    configureLabelContent()
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
      downloadButton.widthAnchor.constraint(equalToConstant: 50),
      downloadButton.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
  
  private func configureLabelContent() {
    guard let couponUid = coupon?.uid else { return print("1")}
    guard let name = coupon?.name else { return print("2")}
    guard let discountPrice = coupon?.discountPrice else { return print("3")}
    guard let description = coupon?.description else { return print("4")}
    couponTitleLabel.text = "[쏘카클럽] \(name)"
    couponPriceLabel.text = "\(discountPrice)원"
    couponInfoLabel.text = "\(description)"
    downloadButton.setTitle(couponUid, for: .selected)
  }
}
