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
  
  static func allcase(isExpent: Bool) -> [EventAndBenefitsCellType] {
    if !isExpent {
      return [title, nomal, nomal, nomal, expendButton]
    } else {
      return [title]
    }
  }
}

class EventAndBenefitsVC: UITableViewController {
  // MARK: - Properties
  var isExpend = false
  var eventAndBenefitsArray: [EventBenifits]?
  lazy var cellTypeArray = EventAndBenefitsCellType.allcase(isExpent: isExpend)
  
  // MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
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
    tableView.register(EventAndBenefitsCell.self, forCellReuseIdentifier: EventAndBenefitsCell.identifier)
  }
  
  // MARK: - Handler
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return isExpend == false ? 5 : eventAndBenefitsArray?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if !isExpend {
      let cell = EventAndBenefitsCell(style: .default, reuseIdentifier: EventAndBenefitsCell.identifier, cellType: cellTypeArray[indexPath.row])
      if let eventAndBenefit = eventAndBenefitsArray?[indexPath.row] {
        cell.configureCellContent(eventAndBenefit: eventAndBenefit)
      }
      return cell
    } else {
      let cell = EventAndBenefitsCell(style: .default, reuseIdentifier: EventAndBenefitsCell.identifier, cellType: cellTypeArray[indexPath.row])
      if let eventAndBenefit = eventAndBenefitsArray?[indexPath.row] {
        cell.configureCellContent(eventAndBenefit: eventAndBenefit)
      }
      return cell
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if !isExpend {
      return indexPath.row == 0 || indexPath.row == 4 ? 50 : 100
    } else {
      return 100
    }
  }
}
