//
//  BookingTimeCell.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class BookingTimeCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "BookingTimeCell"
  lazy var guide = contentView.layoutMarginsGuide
  weak var delegate: BookingTimeCellDelegate?
  var addDateButtons: [UIButton]?
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중입니다..."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let selectTimeButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .none
    return button
  }()
  
  let selectedTimeShowLabel: UILabel = {
    let label = UILabel()
    label.text = "9/21 (월) 00:10"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let openStatusImageButton: UIButton = {
    let button = UIButton()
    let imageConf = UIImage.SymbolConfiguration(pointSize: CommonUI.titleTextFontSize, weight: .medium)
    button.setImage(UIImage(systemName: "chevron.down", withConfiguration: imageConf), for: .normal)
    button.setImage(UIImage(systemName: "chevron.up", withConfiguration: imageConf), for: .selected)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let rentTimeDatePicker: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.backgroundColor = .white
    pickerView.setValue(CommonUI.mainBlue, forKeyPath: "textColor")
    return pickerView
  }()
  
  lazy var addDayButton: UIButton = {
    let button = UIButton()
    button.setTitle("+1일", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.setTitleColor(.gray, for: .normal)
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isHidden = true
    button.addTarget(self, action: #selector(tapAddDayButton), for: .touchUpInside)
    return button
  }()
  
  lazy var addHourButton: UIButton = {
    let button = UIButton()
    button.setTitle("+1시간", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.setTitleColor(.gray, for: .normal)
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isHidden = true
    button.addTarget(self, action: #selector(tapAddHourButton), for: .touchUpInside)
    return button
  }()
  
  lazy var addHalfHourButton: UIButton = {
    let button = UIButton()
    button.setTitle("+30분", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    button.setTitleColor(.gray, for: .normal)
    button.layer.borderColor = UIColor.systemGray4.cgColor
    button.layer.borderWidth = 1
    button.isHidden = true
    button.addTarget(self, action: #selector(tapAddHalfHourButton), for: .touchUpInside)
    return button
  }()

  // MARK: - Life Cycle
  init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, showTimeAddButtons: Bool, isOpen: Bool) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.backgroundColor = .white
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    // 순서 변경 X
    configureLayout(showTimeAddButtons: showTimeAddButtons)
    configureContentViewTopLayer()
    cellUIContoller(isOpen: isOpen)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout(showTimeAddButtons: Bool) {
    [titleLabel, selectedTimeShowLabel, openStatusImageButton, selectTimeButton, addDayButton,
     addHourButton, addHalfHourButton, rentTimeDatePicker].forEach {
      contentView.addSubview($0)
    }
    
    selectTimeButton.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(self)
      $0.height.equalTo(70)
    }
    
    openStatusImageButton.snp.makeConstraints {
      $0.centerY.equalTo(selectTimeButton.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    selectedTimeShowLabel.snp.makeConstraints {
      $0.centerY.equalTo(selectTimeButton.snp.centerY)
      $0.trailing.equalTo(openStatusImageButton.snp.leading).offset(-10)
    }
    
    titleLabel.snp.makeConstraints {
      $0.centerY.equalTo(selectTimeButton.snp.centerY)
      $0.leading.equalTo(guide)
    }
    
    addHalfHourButton.snp.makeConstraints {
      $0.top.equalTo(openStatusImageButton.snp.bottom).offset(25)
      $0.trailing.equalTo(selectedTimeShowLabel.snp.trailing)
      $0.width.equalTo(50)
    }
    
    addHourButton.snp.makeConstraints {
      $0.centerY.equalTo(addHalfHourButton)
      $0.trailing.equalTo(addHalfHourButton.snp.leading).offset(-10)
      $0.width.equalTo(addHalfHourButton)
    }
    
    addDayButton.snp.makeConstraints {
      $0.centerY.equalTo(addHalfHourButton)
      $0.trailing.equalTo(addHourButton.snp.leading).offset(-10)
      $0.width.equalTo(addHalfHourButton)
    }
    
    if !showTimeAddButtons {
      [addHourButton, addDayButton, addHalfHourButton].forEach {
        $0.isHidden = true
      }
      rentTimeDatePicker.snp.makeConstraints {
        $0.top.equalTo(selectedTimeShowLabel.snp.bottom).offset(10)
        $0.leading.equalTo(guide).offset(20)
        $0.trailing.equalTo(selectedTimeShowLabel)
        $0.height.equalTo(140)
      }
    } else {
      addDateButtons = [addHourButton, addDayButton, addHalfHourButton]
      rentTimeDatePicker.snp.makeConstraints {
        $0.top.equalTo(addHalfHourButton.snp.bottom).offset(10)
        $0.leading.equalTo(guide).offset(20)
        $0.trailing.equalTo(selectedTimeShowLabel)
        $0.height.equalTo(140)
      }
    }
  }
  
  private func configureContentViewTopLayer() {
    let view = UIView()
    view.backgroundColor = .systemGray4
    contentView.addSubview(view)
    view.snp.makeConstraints {
      $0.top.leading.trailing.equalTo(contentView)
      $0.height.equalTo(0.7)
    }
  }
  
  // MARK: - UI Handler
  func cellUIContoller(isOpen: Bool) {
    self.openStatusImageButton.isSelected = isOpen
    self.rentTimeDatePicker.isHidden = !isOpen
    self.addDateButtons?.forEach {
      $0.isHidden = !isOpen
    }
    self.contentView.layoutIfNeeded()
  }
  
  func updateRentTimeDatePicker(dayIndex: Int, changedTime: Date) {
    guard let hourIndex = Int(Time.getTimeString(type: .hourHH, date: changedTime)) else { return }
    guard let minCount = Int(Time.getTimeString(type: .minMM, date: changedTime)) else { return }
    rentTimeDatePicker.selectRow(dayIndex, inComponent: 0, animated: true)
    rentTimeDatePicker.selectRow(hourIndex, inComponent: 1, animated: true)
    rentTimeDatePicker.selectRow(minCount/10+1, inComponent: 2, animated: true)
    let minRowIndex = rentTimeDatePicker.selectedRow(inComponent: 2)
    let setMinString = minRowIndex == 0 ? 00 : minRowIndex*10
    selectedTimeShowLabel.text = "\(Time.getTimeString(type: .castMddEHH, date: changedTime.addingTimeInterval(600))):\(setMinString)"
  }
  
  @objc func tapAddDayButton() {
    delegate?.tapAddDayButton(forCell: self)
  }
  
  @objc func tapAddHourButton() {
    delegate?.tapAddHourButton(forCell: self)
  }
  
  @objc func tapAddHalfHourButton() {
    delegate?.tapAddHalfHourButton(forCell: self)
  }
}
