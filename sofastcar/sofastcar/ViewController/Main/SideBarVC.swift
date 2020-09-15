//
//  SideBarVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SideBarVC: UIViewController {
  
  let tableView = UITableView(frame: .zero, style: .plain)
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .none
    
    view.addSubview(contentView)
    contentView.frame = CGRect(x: 0.0, y: 0.0,
                               width: UIScreen.main.bounds.width*0.85,
                               height: UIScreen.main.bounds.height)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.dismissDetail()
  }
}
