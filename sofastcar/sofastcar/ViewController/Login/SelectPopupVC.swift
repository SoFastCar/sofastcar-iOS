//
//  SelectPopupVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectPopupVC: UIViewController {
  
  var sectionTitle: String = ""
  var selectionMenus: [String] = []
  let cellHeight: CGFloat = 50
  
  var passUserSelectDataClosure: ((String) -> Void)!
  var passBlurView: UIView!
  var passPhoneNuberTextField: UITextField!
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.separatorStyle = .none
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .none
    
    view.addSubview(tableView)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    tableView.translatesAutoresizingMaskIntoConstraints = false
    let tableViewHeight = CGFloat(selectionMenus.count+1)*cellHeight + 20
    tableView.frame = CGRect(x: 0,
                             y: UIScreen.main.bounds.height - tableViewHeight,
                             width: UIScreen.main.bounds.width,
                             height: tableViewHeight)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismiss(animated: true)
    UIView.animate(withDuration: 0.5) {
      self.passBlurView.alpha = 0
      self.passPhoneNuberTextField.becomeFirstResponder()
    }
  }
}

// MARK: - UITableViewDataSource
extension SelectPopupVC: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return selectionMenus.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = "  \(selectionMenus[indexPath.row])"
    cell.textLabel?.font = .systemFont(ofSize: 17)
    return cell
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 17)
    label.textColor = .black
    label.backgroundColor = .white
    label.text = "    \(sectionTitle)"
    return label
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return cellHeight
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeight
  }
}

// MARK: - UITableViewDelegate
extension SelectPopupVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    passUserSelectDataClosure(selectionMenus[indexPath.row])
    self.dismiss(animated: true)
    UIView.animate(withDuration: 0.5) {
      self.passBlurView.alpha = 0
      self.passPhoneNuberTextField.becomeFirstResponder()
    }
  }
}
