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
  var isTimeChange: Bool = false
  var isHalfHourSelected: Bool = false
  
  var rentCurrnetSelectedRow: [Int] = [0, 0, 0] // 일 시 분
  var returnCurrnetSelectedRow: [Int] = [0, 0, 0]
  
  var startDate = Date()
  var endDate = Date()
    
  var setBookingTimeMain: SetBookingTimeButton?
  var setBookingTimeCarList: SetBookingTimeButton?
  
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
    guard let navi = self.presentingViewController as? UINavigationController else { return }
    if let presentingVC = navi.viewControllers.last as? MainVC {
      presentingVC.newStartDate = startDate
      presentingVC.newEndDate = endDate
      setBookingTimeMain?.setupTime(isChaged: true, startTime: startDate, endTime: endDate)
      setBookingTimeMain?.setButtonTitle(sTime: startDate, eTime: endDate)
      setBookingTimeCarList?.setupTime(isChaged: true, startTime: startDate, endTime: endDate)
      setBookingTimeCarList?.setButtonTitle(sTime: startDate, eTime: endDate)
        presentingVC.calculatedCarPrice.removeAll()
      presentingVC.carListView.carListTableView.reloadData()
    }
    
    if let presentingVC = navi.viewControllers.last as? ReservationConfirmTableVC {
      print("reservationConfirm push")
      presentingVC.startDate = startDate
      presentingVC.endDate = endDate
      presentingVC.reloadUsingTimeCell()
    }
    self.dismiss(animated: true, completion: nil)
  }
}

// MARK: - UITableViewDataSource && UITableViewDelegate
extension BookingTimeVC: UITableViewDataSource, UITableViewDelegate {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  fileprivate func configureBookingTimeCell(_ cell: BookingTimeCell, _ indexPath: IndexPath) {
    cell.titleLabel.text = titleStringArray[indexPath.row-1]
    cell.selectTimeButton.addTarget(self, action: #selector(tapSelectTimeButton(_:)), for: .touchUpInside)
    cell.selectTimeButton.tag = indexPath.row
    cell.rentTimeDatePicker.tag = indexPath.row
    cell.rentTimeDatePicker.dataSource = self
    cell.rentTimeDatePicker.delegate = self
    cell.delegate = self
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
      let myCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
      return firstCellconfigure(cell: myCell)
    } else {
      let cell = BookingTimeCell(style: .default,
                                 reuseIdentifier: BookingTimeCell.identifier,
                                 showTimeAddButtons: indexPath.row == 2 ? true : false,
                                 isOpen: indexPath == selectedIndex ? true : false)
      configureBookingTimeCell(cell, indexPath)
      settingPickerViewByTime(cell: cell, row: indexPath.row)
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
  
  private func firstCellconfigure(cell: UITableViewCell) -> UITableViewCell {
    cell.textLabel?.text = firstCellTitleConfigure()
    cell.textLabel?.font = .boldSystemFont(ofSize: 20)
//    if isTimeChange {
      cell.detailTextLabel?.text = Time.getStartEndTimeShowLabel(start: startDate, end: endDate)
//    } else {
//      cell.detailTextLabel?.text = "\(Time.getTimeString(type: .todayHHmm, date: startDate)) - \(Time.getTimeString(type: .hourHHmm, date: endDate))"
//    }
    cell.detailTextLabel?.numberOfLines = 2
    cell.detailTextLabel?.textColor = .systemGray
    return cell
  }
  
  private func firstCellTitleConfigure() -> String {
    if isTimeChange == false {
      return "이용시간 설정하기"
    } else {
      var returnText = "총 "
      let offsetComps = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: startDate, to: endDate)
      if let day = offsetComps.day,
        day != 0 {
        returnText.append("\(day)일 ")
      }
      if let hour = offsetComps.hour,
        hour != 0 {
        returnText.append("\(hour)시간 ")
      }
      if let minute = offsetComps.minute,
        minute != 0 {
        returnText.append("\(minute)분 ")
      }
      returnText.append("이용")
      return returnText
    }
  }
  
  private func firstCellDetailTitleCongifure() -> String {
    guard let firstCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? BookingTimeCell else { fatalError() }
    guard let secondCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? BookingTimeCell else { fatalError() }
    
    if let rendTimeString = firstCell.selectedTimeShowLabel.text,
      let returnTimeString = secondCell.selectedTimeShowLabel.text {
      return "\(rendTimeString) - \(returnTimeString)\n"
    }
    return "로딩중입니다..."
  }
  
  private func settingPickerViewByTime(cell: BookingTimeCell, row: Int) {
    let showTimeDate = row == 1 ? startDate : endDate
    rentCurrnetSelectedRow[0] = Time.getDayIndex(start: Date(), end: startDate)
    returnCurrnetSelectedRow[0] = Time.getDayIndex(start: Date(), end: endDate)
    let dayIndex = row == 1 ? rentCurrnetSelectedRow[0] : returnCurrnetSelectedRow[0]
    cell.updateRentTimeDatePicker(dayIndex: dayIndex, changedTime: showTimeDate)
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
        pickerLabel?.text = Time.getTimeString(type: .castMMddE, date: Date().addingTimeInterval(TimeInterval(Time.day*row)))
      } else {
        pickerLabel?.text = Time.getTimeString(type: .castMMddE, date: Date().addingTimeInterval(TimeInterval(Time.day*row+4*Time.hour)))
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
      changedValue = Time.day
    case DateComponentType.hour.rawValue:
      changedValue = Time.hour
    case DateComponentType.min.rawValue:
      changedValue = Time.min*10
    default:
      return print("Error")
    }
    
    guard let cell = tableView.cellForRow(at: IndexPath(row: pickViewType, section: 0)) as? BookingTimeCell else { return }
    
    if pickViewType == 1 { // rentTimePickerView
      let amount = row - rentCurrnetSelectedRow[component]
      startDate.addTimeInterval(TimeInterval(changedValue*amount))
      if component == DateComponentType.day.rawValue {
        cell.updateRentTimeDatePicker(dayIndex: row, changedTime: startDate)
      } else {
        cell.updateRentTimeDatePicker(dayIndex: rentCurrnetSelectedRow[0], changedTime: startDate)
      }
    } else { // returnTimePickerView
      let amount = row - returnCurrnetSelectedRow[component]
      endDate.addTimeInterval(TimeInterval(changedValue*amount))
      if component == DateComponentType.day.rawValue {
        cell.updateRentTimeDatePicker(dayIndex: row, changedTime: endDate)
      } else {
        cell.updateRentTimeDatePicker(dayIndex: returnCurrnetSelectedRow[0], changedTime: endDate)
      }
    }
  }
  
  private func saveCurrnetSelectedRow(pickerView: UIPickerView) {
    var tempArray: [Int] = []
    for index in 0..<3 {
      tempArray.append(pickerView.selectedRow(inComponent: index))
    }
    if pickerView.tag == 1 {
      rentCurrnetSelectedRow = tempArray
    } else {
      returnCurrnetSelectedRow = tempArray
    }
  }
}

// MARK: - BookingTimeCellDelegate
extension BookingTimeVC: BookingTimeCellDelegate {
  func tapAddDayButton(forCell cell: BookingTimeCell) {
    endDate = endDate.addingTimeInterval(TimeInterval(Time.day))
    returnCurrnetSelectedRow[0] += 1
    cell.updateRentTimeDatePicker(dayIndex: returnCurrnetSelectedRow[0], changedTime: endDate)
    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
  
  func tapAddHalfHourButton(forCell cell: BookingTimeCell) {
    isHalfHourSelected.toggle()
    let beforeEndDate = endDate
    var dayIndex = returnCurrnetSelectedRow[0]
    endDate = endDate.addingTimeInterval(TimeInterval(Time.hour/2))
    if Time.getTimeString(type: .dayd, date: beforeEndDate) != Time.getTimeString(type: .dayd, date: endDate) {
      dayIndex += 1
      returnCurrnetSelectedRow[0] = dayIndex
    }
    cell.updateRentTimeDatePicker(dayIndex: returnCurrnetSelectedRow[0], changedTime: endDate)
    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
  
  func tapAddHourButton(forCell cell: BookingTimeCell) {
    let beforeEndDate = endDate
    var dayIndex = returnCurrnetSelectedRow[0]
    endDate = endDate.addingTimeInterval(TimeInterval(Time.hour))
    if Time.getTimeString(type: .dayd, date: beforeEndDate) != Time.getTimeString(type: .dayd, date: endDate) {
      dayIndex += 1
      returnCurrnetSelectedRow[0] = dayIndex
    }
    cell.updateRentTimeDatePicker(dayIndex: dayIndex, changedTime: endDate)
    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
    saveCurrnetSelectedRow(pickerView: cell.rentTimeDatePicker)
  }
}
