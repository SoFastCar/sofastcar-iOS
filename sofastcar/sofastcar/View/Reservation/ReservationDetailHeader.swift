//
//  ReservationDetailHeader.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationDetailHeader: UIView {
  // MARK: - Properies
  
  lazy var segmentControll: UISegmentedControl = {
    let segControll = UISegmentedControl()
    
    segControll.backgroundColor = .white
    segControll.tintColor = .white
    segControll.selectedSegmentTintColor = .none
    segControll.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
    segControll.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    segControll.insertSegment(withTitle: "대여정보", at: 0, animated: false)
    segControll.insertSegment(withTitle: "결제정보", at: 1, animated: false)
    segControll.insertSegment(withTitle: "기타정보", at: 2, animated: false)
    segControll.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18),
                                        .foregroundColor: UIColor.systemGray4], for: .normal)
    segControll.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 18),
                                        .foregroundColor: UIColor.black], for: .selected)
    return segControll
  }()
  
  lazy var closeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue), for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let carNumberLabel: UILabel = {
    let label = UILabel()
    label.text = "57하4455"
    label.textColor = .black
    label.font = .boldSystemFont(ofSize: 25)
    return label
  }()
  
  let reservationStatueLabel: UIButton = {
    let button = UIButton()
    button.setTitle("운행중", for: .normal)
    button.setTitle("반납완료", for: .selected)
    button.setTitleColor(.systemGray5, for: .normal)
    button.setTitleColor(.darkGray, for: .selected)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.layer.cornerRadius = 3
    button.isSelected = true
    button.isUserInteractionEnabled = false
    button.backgroundColor = .systemGray5
    return button
  }()
  
  let segmentindicator: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    return view
  }()
  
  // MARK: - Life Cycle
  init(frame: CGRect, isReservationEnd: Bool) {
    super.init(frame: frame)
    reservationStatueLabel.isSelected = isReservationEnd
    reservationStatueLabel.backgroundColor = isReservationEnd ? .systemGray5 : CommonUI.mainDark
    configureDefaultSetting()
    configureLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureDefaultSetting() {
    segmentControll.selectedSegmentIndex = 0
    self.backgroundColor = .white
    self.layoutMargins = UIEdgeInsets(top: 20, left: 30, bottom: 0, right: 30)
  }
  
  private func configureLayout() {
    [closeButton, carNumberLabel, reservationStatueLabel, segmentControll, segmentindicator].forEach {
      addSubview($0)
    }
    
    closeButton.snp.makeConstraints {
      $0.top.leading.equalTo(self).offset(5)
      $0.height.width.equalTo(40)
    }
    
    carNumberLabel.snp.makeConstraints {
      $0.top.equalTo(closeButton.snp.bottom).offset(5)
      $0.leading.equalTo(layoutMarginsGuide)
    }
    
    reservationStatueLabel.snp.makeConstraints {
      $0.leading.equalTo(carNumberLabel.snp.trailing).offset(10)
      $0.height.equalTo(carNumberLabel).offset(-10)
      $0.width.equalTo(70)
      $0.centerY.equalTo(carNumberLabel.snp.centerY)
    }
    
    segmentControll.snp.makeConstraints {
      $0.top.equalTo(carNumberLabel.snp.bottom)
      $0.height.equalTo(50)
      $0.width.equalTo(250)
      $0.leading.equalTo(layoutMarginsGuide).offset(-10)
      $0.bottom.equalTo(layoutMarginsGuide)
    }
    
    segmentindicator.snp.makeConstraints {
      $0.top.equalTo(segmentControll.snp.bottom).offset(-1)
      $0.height.equalTo(1)
      $0.width.equalTo(65)
      $0.leading.equalTo(segmentControll).offset(9)
    }
  }
}
