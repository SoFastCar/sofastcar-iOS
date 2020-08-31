//
//  CardEnrollVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CardEnrollVC: UIViewController {
  
  let cardEnrollView = CardEnrollView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "개인카드 등록"
    
  }
  
  override func loadView() {
    view = cardEnrollView
  }
}
