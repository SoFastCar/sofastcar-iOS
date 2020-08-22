//
//  ViewController.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import NMapsMap

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let mapView = NMFMapView(frame: view.frame)
    view.addSubview(mapView)
  }
}
