//
//  BookingTimeVC.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class BookingTimeVC: UIViewController {
  // MARK: - Properties
  let titleStringArray = ["대여 시각", "반납 시각"]
  let calendar = Calendar.current
  let min = 600
  let hour = 3600
  let day = 86400
  var isTimeChange: Bool = false
  
  var rentCurrnetSelectedRow: [Int] = [0, 0, 0]
  var returnCurrnetSelectedRow: [Int] = [0, 0, 0]
  
  let format: DateFormatter =  {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = "M/dd (E) HH:mm"
    return format
  }()
  
  let pickerViewformat: DateFormatter =  {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = "MM / dd (E)"
    return format
  }()
  
  let firstPickerViewformat: DateFormatter =  {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = "오늘 (E)"
    return format
  }()
  
  let hourFormat: DateFormatter =  {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = "H"
    return format
  }()
  
  let dayFormat: DateFormatter =  {
    let format = DateFormatter()
    format.locale = CommonUI.locale as Locale
    format.dateFormat = "d"
    return format
  }()
  
  var startDate = Date() {
    didSet {
      tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
  }
  var endDate = Date() {
    didSet {
      tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    }
  }
  
  enum DateComponentType: Int {
    case day = 0
    case hour = 1
    case min = 2
  }
  
  let dismissButton: UIButton = {
    let button = UIButton()
    let sysimgaCongfigure = UIImage.SymbolConfiguration(pointSize: 30, weight: .thin)
    button.setImage(UIImage(systemName: "xmark", withConfiguration: sysimgaCongfigure), for: .normal)
    button.imageView?.tintColor = .black
    button.addTarget(self, action: #selector(tapDismissButton), for: .touchUpInside)
    return button
  }()
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)
  
  let authCompleteButton = CompleteButton(frame: .zero, title: "확인")
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    endDate = Date().addingTimeInterval(TimeInterval(hour*4))
    view.backgroundColor = .white
    configureTableView()
    configureLayout()
    settingAuthCompleteButton()
  }
  
  fileprivate func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    tableView.allowsSelection = false
    tableView.isScrollEnabled = false
    tableView.register(BookingTimeCell.self, forCellReuseIdentifier: BookingTimeCell.identifier)
  }
  
  fileprivate func configureLayout() {
    [dismissButton, tableView].forEach {
      view.addSubview($0)
    }
    
    dismissButton.snp.makeConstraints {
      $0.top.leading.equalTo(view).offset(10)
      $0.width.height.equalTo(40)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(dismissButton.snp.bottom).offset(20)
      $0.leading.trailing.bottom.equalTo(view)
    }
  }
  
  private func settingAuthCompleteButton() {
    tableView.addSubview(authCompleteButton)
    authCompleteButton.isEnabled = true
    authCompleteButton.addTarget(self, action: #selector(tapCompliteButton), for: .touchUpInside)
    authCompleteButton.snp.makeConstraints {
      $0.leading.trailing.equalTo(tableView.safeAreaLayoutGuide)
      $0.bottom.equalTo(tableView.safeAreaLayoutGuide).offset(40)
      $0.height.equalTo(100)
    }
  }
  
  // MARK: - Button Action
  @objc private func tapDismissButton() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc private func tapCompliteButton() {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - Handler
  private func timeToString(date: Date) -> String {
    return format.string(from: date)
  }
}

struct MCDropData {
  var title: String
  var url: String
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension BookingTimeVC: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {    
    if indexPath.row == 0 {
      let myCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
      var days = returnCurrnetSelectedRow[0] - rentCurrnetSelectedRow[0]
      var hour = Int(hourFormat.string(from: startDate))! - Int(hourFormat.string(from: endDate))!
      let offsetComps = calendar.dateComponents([.year, .month, .day], from: startDate, to: endDate)
      if case let (year?, month?, dayyy?) = (offsetComps.year, offsetComps.month, offsetComps.day) {
        print("\(year)년\(month)월\(dayyy)일만큼 차이남")
      }
      var titleText = ""
      print(days)
      print(hour)
      if hour < 0 {
        hour = 24 + hour
        days -= 1
      }
      if isTimeChange == false {
        titleText = "이용시간 설정하기"
      } else {
        if days == 0 {
          titleText = "총 \(hour)시간 이용"
        } else {
          titleText = "총 \(days)일 \(hour)시간 이용"
        }
      }
      myCell.textLabel?.text = titleText
      myCell.textLabel?.font = .boldSystemFont(ofSize: 20)
      myCell.detailTextLabel?.text = "\(format.string(from: startDate)) - \(format.string(from: endDate))\n"
      myCell.detailTextLabel?.numberOfLines = 2
      myCell.detailTextLabel?.textColor = .systemGray
      return myCell
    } else {
      let showDate = indexPath.row == 1 ? startDate : endDate
      let dayIndex = indexPath.row == 1 ? rentCurrnetSelectedRow[0] : returnCurrnetSelectedRow[0]
      let cell = BookingTimeCell(style: .default,
                                 reuseIdentifier: BookingTimeCell.identifier,
                                 showTimeAddButtons: indexPath.row == 1 ? false : true,
                                 isOpen: indexPath == selectedIndex ? true : false)
      cell.selectTimeButton.addTarget(self, action: #selector(tapSelectTimeButton(_:)), for: .touchUpInside)
      cell.selectTimeButton.tag = indexPath.row
      cell.rentTimeDatePicker.tag = indexPath.row
      cell.rentTimeDatePicker.dataSource = self
      cell.rentTimeDatePicker.delegate = self
      cell.delegate = self
      cell.titleLabel.text = titleStringArray[indexPath.row-1]
      cell.updateRentTimeDatePicker(dayIndex: dayIndex, changedTime: showDate)
      saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
      return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 { return 70 }
    return indexPath == selectedIndex ? 220 : 70
  }
  
  @objc private func tapSelectTimeButton(_ sender: UIButton) {
    let beoforeIndexPath = selectedIndex
    selectedIndex = selectedIndex.row == sender.tag ? .init(row: 0, section: 0) : .init(row: sender.tag, section: 0)
    tableView.reloadRows(at: [selectedIndex, beoforeIndexPath], with: .none)
  }
}
// MARK: - UIPickerViewDelegate && UIPickerViewDataSource
extension BookingTimeVC: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 3
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if component == 0 { return 60 }
    if component == 1 { return 24 }
    if component == 2 { return 6 }
    return 0
  }
  
  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 50
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    isTimeChange = true
    updatePickerViewTime(pickViewType: pickerView.tag, row: row, component: component)
    saveCurrnetSelectedRow(pickerView: pickerView)
    pickerView.reloadComponent(component)
  }
  
  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
    if component == 0 { return 80 }
    return 50
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var pickerLabel: UILabel? = (view as? UILabel)
    if pickerLabel == nil {
      pickerLabel = UILabel()
      pickerLabel?.font = .boldSystemFont(ofSize: CommonUI.contentsTextFontSize)
      pickerLabel?.textAlignment = .center
    }
    
    var textColor = UIColor.darkGray
    if pickerView.selectedRow(inComponent: component) == row {
      textColor = CommonUI.mainBlue
    }
    pickerLabel?.textColor = textColor
     
    switch component {
    case DateComponentType.day.rawValue:
      if pickerView.tag == 1 {
        pickerLabel?.text = pickerViewformat.string(from: Date().addingTimeInterval(TimeInterval(day*row)))
      } else {
        pickerLabel?.text = pickerViewformat.string(from: Date().addingTimeInterval(TimeInterval(day*row+4*hour)))
      }
    case DateComponentType.hour.rawValue:
      pickerLabel?.text = "\(row)"
    case DateComponentType.min.rawValue:
      pickerLabel?.text = "\(row*10)"
    default:
      pickerLabel?.text = ""
    }
    return pickerLabel!
  }
  
  private func updatePickerViewTime(pickViewType: Int, row: Int, component: Int) {
    var changedValue: Int = 0
    switch component {
    case DateComponentType.day.rawValue:
      changedValue = day
    case DateComponentType.hour.rawValue:
      changedValue = hour
    case DateComponentType.min.rawValue:
      changedValue = min
    default:
      return print("Error")
    }
    
    guard let cell = tableView.cellForRow(at: IndexPath(row: pickViewType, section: 0)) as? BookingTimeCell else { return }
    
    if pickViewType == 1 {
      let amount = row - rentCurrnetSelectedRow[component]
      startDate.addTimeInterval(TimeInterval(changedValue*amount))
      if component == 0 {
        cell.updateRentTimeDatePicker(dayIndex: row, changedTime: startDate)
      } else {
        cell.updateRentTimeDatePicker(dayIndex: rentCurrnetSelectedRow[0], changedTime: startDate)
      }
      
    } else {
      let amount = row - returnCurrnetSelectedRow[component]
      endDate.addTimeInterval(TimeInterval(changedValue*amount))
      if component == 0 {
        cell.updateRentTimeDatePicker(dayIndex: row, changedTime: endDate)
      } else {
        cell.updateRentTimeDatePicker(dayIndex: rentCurrnetSelectedRow[0], changedTime: endDate)
      }
    }
  }
  
  private func saveCurrnetSelectedRow(pickerView: UIPickerView) {
    var tempArray: [Int] = []
    for index in 0..<3 {
      print("Add", pickerView.selectedRow(inComponent: index))
      tempArray.append(pickerView.selectedRow(inComponent: index))
    }
    if pickerView.tag == 1 {
      rentCurrnetSelectedRow = tempArray
    } else {
      returnCurrnetSelectedRow = tempArray
    }
    print("saveCurrnetSelectedRow", tempArray)
  }
}

// MARK: - BookingTimeCellDelegate
extension BookingTimeVC: BookingTimeCellDelegate {
  func tapAddDayButton(forCell cell: BookingTimeCell) {
    print("tapAddDayButton")
    endDate = endDate.addingTimeInterval(TimeInterval(day))
    returnCurrnetSelectedRow[0] += 1
    cell.updateRentTimeDatePicker(dayIndex: returnCurrnetSelectedRow[0], changedTime: endDate)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
  
  func tapAddHalfHourButton(forCell cell: BookingTimeCell) {
    let beforeEndDate = endDate
    var dayIndex = returnCurrnetSelectedRow[0]
    endDate = endDate.addingTimeInterval(TimeInterval(hour/2))
    if dayFormat.string(from: beforeEndDate) != dayFormat.string(from: endDate) {
      dayIndex += 1
      returnCurrnetSelectedRow[0] = dayIndex
    }
    cell.updateRentTimeDatePicker(dayIndex: returnCurrnetSelectedRow[0], changedTime: endDate)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
  
  func tapAddHourButton(forCell cell: BookingTimeCell) {
    let beforeEndDate = endDate
    var dayIndex = returnCurrnetSelectedRow[0]
    endDate = endDate.addingTimeInterval(TimeInterval(hour))
    if dayFormat.string(from: beforeEndDate) != dayFormat.string(from: endDate) {
      dayIndex += 1
      returnCurrnetSelectedRow[0] = dayIndex
    }
    cell.updateRentTimeDatePicker(dayIndex: dayIndex, changedTime: endDate)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
}
