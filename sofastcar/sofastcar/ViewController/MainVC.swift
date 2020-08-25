//
//  MainVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/21.
//  Copyright © 2020 김광수. All rights reserved.
//
// 패캠 좌표 37.545303, 127.057221

import UIKit
import NMapsMap
public let defaultPosition = NMFCameraPosition(NMGLatLng(lat: 37.545303, lng: 127.057221), zoom: 14, tilt: 0, heading: 0)

class MainVC: UIViewController {
    
    let locationManager = CLLocationManager()
    let marker = NMFMarker()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    let mapView = NMFMapView(frame: view.frame)
    view.addSubview(mapView)
    let coord = NMGLatLng(lat: 37.545303, lng: 127.057221)
    marker.position = coord
    marker.mapView = mapView
    mapView.moveCamera(NMFCameraUpdate(position: defaultPosition))
    mapView.positionMode = .direction
  }
    
}
