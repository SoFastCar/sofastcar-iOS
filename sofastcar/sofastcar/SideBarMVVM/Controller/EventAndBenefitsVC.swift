//
//  EventAndBenefitsVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

enum EventAndBenefitsCellType: String {
  case title = "이벤트"
  case nomal
  case expendButton = "진행중 이벤트 더보기"
  case blank
  
  static func allcase(isExpent: Bool, cellCount: Int?) -> [EventAndBenefitsCellType] {
    if !isExpent {
      return [title, nomal, nomal, nomal, expendButton, blank]
    } else {
      guard let count = cellCount else { return [] }
      var array = [title]
      for _ in 0..<count {
        array.append(nomal)
      }
      array.append(blank)
      return array
    }
  }
}

class EventAndBenefitsVC: UITableViewController {
  // MARK: - Properties
  var isExpend = false
  var eventAndBenefitsArray: [EventBenifits]?
  var cellTypeArray: [EventAndBenefitsCellType] = []
  let myFooterView = EventAndBenefitFooterView()
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    cellTypeArray = EventAndBenefitsCellType.allcase(isExpent: isExpend, cellCount: eventAndBenefitsArray?.count)
    configureNavigationController()
    configureTableView()
  }
  
  private func configureNavigationController() {
    navigationController?.isNavigationBarHidden = false
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue), style: .plain, target: self, action: #selector(tapCloseButton))
    navigationController?.navigationBar.tintColor = .black
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.barTintColor = UIColor.white
  }
  
  private func configureTableView() {
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    tableView.sectionFooterHeight = 10
    tableView.tableFooterView = myFooterView
    tableView.tableFooterView?.frame.size.height = 300
    myFooterView.checkBenefitsButton.addTarget(self, action: #selector(tapCheckBenefitButton), for: .touchUpInside)
  }
  
  // MARK: - Handler
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isExpend == false ? 6 : cellTypeArray.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = EventAndBenefitsCell(style: .default, reuseIdentifier: EventAndBenefitsCell.identifier, cellType: cellTypeArray[indexPath.row])
    if indexPath.row > 0 && eventAndBenefitsArray?.count ?? 0 > indexPath.row-1 {
      if let eventAndBenefit = eventAndBenefitsArray?[indexPath.row-1] {
        cell.configureCellContent(eventAndBenefit: eventAndBenefit)
      }
    }
    cell.selectedBackgroundView = UIView()
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let blankCellIndex = cellTypeArray.count - 1
    if !isExpend {
      return indexPath.row == 0 || indexPath.row == 4 ? 50 : (indexPath.row == blankCellIndex ? 10 : 100)
    } else {
      return indexPath.row == 0 ? 50 : (indexPath.row == blankCellIndex ? 10 : 100)
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if !isExpend {
      if indexPath.row == 4 {
        isExpend = true
        cellTypeArray = EventAndBenefitsCellType.allcase(isExpent: isExpend, cellCount: eventAndBenefitsArray?.count)
        tableView.reloadData()
      } else {
        print(indexPath.row)
      }
    } else {
      print(indexPath.row)
    }
  }
  
  // MARK: - Handler
  @objc private func tapCheckBenefitButton() {
    print("tapCheckBenefitButton")
  }
}
