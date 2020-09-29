//
//  EventAndBenefitsVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class EventAndBenefitsVC: UITableViewController {
  // MARK: - Properties
  var isExtend = false
  var eventAndBenefitsArray: [EventBenifits]?
  
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
    tableView.register(EventAndBenefitsCell.self, forCellReuseIdentifier: EventAndBenefitsCell.identifier)
  }
  
  // MARK: - Handler
  @objc private func tapCloseButton() {
    dismiss(animated: true, completion: nil)
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5 // isExtend == false ? 4 : eventAndBenefitsArray?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = EventAndBenefitsCell(style: .default, reuseIdentifier: EventAndBenefitsCell.identifier)
    if let eventAndBenefit = eventAndBenefitsArray?[indexPath.row] {
      cell.configureCellContent(eventAndBenefit: eventAndBenefit)
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.text = "  이벤트"
    label.font = .boldSystemFont(ofSize: 20)
    return label
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 60
  }
}
