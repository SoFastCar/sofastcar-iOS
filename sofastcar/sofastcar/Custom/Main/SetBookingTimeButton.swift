//
//  SetBookingTimeButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum SetPlace {
  case carList
  case mainVC
}

class SetBookingTimeButton: UIButton {
  
  let clockSymbolImageView = UIImageView()
  let setTimeLabel = UILabel()
  let timeLabel = UILabel()
  let chevronSymbolImageView = UIImageView()
  var startTime: Date = Date()
  var endTime: Date = Date()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(on place: SetPlace) {
    self.init()
    setupUI(on: place)
    setupConstraint(on: place)
    setupTime(on: place, isChaged: false, startTime: Date(), endTime: Date())
  }
  
  private func setupUI(on place: SetPlace) {
    switch place {
    case .carList:
      let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20)
      
      self.backgroundColor = .white
      
      clockSymbolImageView.tintColor = CommonUI.mainBlue
      clockSymbolImageView.image = UIImage(systemName: "clock", withConfiguration: symbolConfig)
      self.addSubview(clockSymbolImageView)
      
      setTimeLabel.text = "이용시간 설정하기"
      setTimeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
      self.addSubview(setTimeLabel)
      
      timeLabel.font = .systemFont(ofSize: 15, weight: .regular)
      timeLabel.textColor = .gray
      self.addSubview(timeLabel)
      
    case .mainVC:
      let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20)
      self.backgroundColor = .white
      
      clockSymbolImageView.tintColor = CommonUI.mainBlue
      clockSymbolImageView.image = UIImage(systemName: "clock", withConfiguration: symbolConfig)
      self.addSubview(clockSymbolImageView)
      
      setTimeLabel.text = "이용시간 설정하기"
      setTimeLabel.font = .systemFont(ofSize: 18, weight: .semibold)
      setTimeLabel.textColor = CommonUI.mainDark
      self.addSubview(setTimeLabel)
      
      timeLabel.font = .systemFont(ofSize: 14, weight: .regular)
      timeLabel.textColor = .lightGray
      self.addSubview(timeLabel)
      
      chevronSymbolImageView.image = UIImage(systemName: "chevron.down", withConfiguration: self.symbolConfiguration(pointSize: 18, weight: .regular))
      chevronSymbolImageView.tintColor = CommonUI.mainDark
      self.addSubview(chevronSymbolImageView)
    }
  }
  
  private func setupConstraint(on place: SetPlace) {
    switch place {
    case .carList:
      [clockSymbolImageView, setTimeLabel, timeLabel].forEach({
        $0.translatesAutoresizingMaskIntoConstraints = false
      })
      
      clockSymbolImageView.snp.makeConstraints({
        $0.centerY.equalTo(self)
        $0.leading.equalTo(self).offset(20)
      })
      
      setTimeLabel.snp.makeConstraints({
        $0.centerY.equalTo(self)
        $0.leading.equalTo(clockSymbolImageView.snp.trailing).offset(10)
      })
      
      timeLabel.snp.makeConstraints({
        $0.centerY.equalTo(self)
        $0.trailing.equalTo(self).offset(-20)
      })
    case .mainVC:
      [clockSymbolImageView, setTimeLabel, timeLabel, chevronSymbolImageView].forEach({
        $0.translatesAutoresizingMaskIntoConstraints = false
      })
      
      clockSymbolImageView.snp.makeConstraints({
        $0.top.equalToSuperview().offset(35)
        $0.leading.equalTo(self).offset(20)
      })
      
      setTimeLabel.snp.makeConstraints({
        $0.centerY.equalTo(clockSymbolImageView).offset(-10)
        $0.leading.equalTo(clockSymbolImageView.snp.trailing).offset(15)
      })
      
      timeLabel.snp.makeConstraints({
        $0.centerY.equalTo(clockSymbolImageView).offset(15)
        $0.leading.equalTo(clockSymbolImageView.snp.trailing).offset(15)
      })
      
      chevronSymbolImageView.snp.makeConstraints({
        $0.centerY.equalTo(clockSymbolImageView)
        $0.trailing.equalToSuperview().offset(-20)
      })
    }
  }
  
  func setButtonTitle(sTime: Date, eTime: Date) {
    setTimeLabel.text = Time.getDiffTwoDateValueReturnString(start: sTime, end: eTime)
  }
  
    func setupTime(on place: SetPlace, isChaged flag: Bool, startTime sTime: Date, endTime eTime: Date) {
    if flag {
        startTime = sTime
        endTime = eTime
        switch place {
        case .mainVC:
            timeLabel.text = Time.getStartEndTimeShowLabel(start: sTime, end: eTime)
        case .carList:
            timeLabel.text = Time.getStartEndTimeShowLabelShort(start: sTime)
        }
    } else {
      Time.getInitialStartAndEndTimeForReservation { (sTime, eTime) in
        self.startTime = sTime
        self.endTime = eTime
        switch place {
        case .mainVC:
            timeLabel.text = Time.getStartEndTimeShowLabel(start: sTime, end: eTime)
        case .carList:
            timeLabel.text = Time.getStartEndTimeShowLabelShort(start: sTime)
        }
      }
    }
  }
}
