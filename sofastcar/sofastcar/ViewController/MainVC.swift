//
//  MainVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/21.
//  Copyright © 2020 김광수. All rights reserved.
//
// 패캠 좌표 37.545303, 127.057221
// 네이버맵 인증 키 10nhse2dsn(우빈), xexx2450ca(광수)

import UIKit
import NMapsMap

public let defaultCamPosition = NMFCameraPosition(NMGLatLng(lat: 37.545303, lng: 127.057221), zoom: 14, tilt: 0, heading: 0)
public let defaultMarkerPosition = NMGLatLng(lat: 37.545303, lng: 127.057221)

class MainVC: UIViewController {
    
    let marker = NMFMarker()
    let naverMapView = NMFNaverMapView()
    let topSearchView = TopSearchView()
    var carListTransitionDelegate: InteractiveModalTransitionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNM()
        setupUI()
        setupConstraint()
        setupMarkers()
        
    }
    
    private func setupNM() {
//        let mapView = NMFMapView(frame: view.frame)
        naverMapView.frame = view.frame
        view.addSubview(naverMapView)
        naverMapView.mapView.touchDelegate = self
        print(defaultCamPosition)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: defaultCamPosition))
        marker.position = defaultMarkerPosition
        marker.mapView = naverMapView.mapView
    }
    
    private func setupMarkers() {
        marker.touchHandler = { (overlay) in
            if let marker = overlay as? NMFMarker {
                let carListTableVC = CarListTableViewController()
                self.carListTransitionDelegate = InteractiveModalTransitionDelegate(from: self, to: carListTableVC)
                carListTableVC.modalPresentationStyle = .custom
                carListTableVC.isModalInPresentation = true
                carListTableVC.transitioningDelegate = self.carListTransitionDelegate
                self.present(carListTableVC, animated: true)
                // 지도 좌표로 카메라 위치 이동
                let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.540003, lng: 127.057221),
                                                                            zoom: 14))
                // 뷰 좌표 으로 카메라 위치 이동
//                let camUpdateParams = NMFCameraUpdateParams()
//                camUpdateParams.scroll(by: CGPoint(x: .zero, y: -1 * (self.view.bounds.height / 4)))
//                let camUpdate = NMFCameraUpdate(params: camUpdateParams)
                camUpdate.animation = .fly
                camUpdate.animationDuration = 0.5
                self.naverMapView.mapView.moveCamera(camUpdate)
                self.topSearchView.alpha = 0
            }
            return true
        }
    }
    
    private func setupUI() {
        topSearchView.backgroundColor = .systemTeal
        view.addSubview(topSearchView)
    }
    
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        topSearchView.translatesAutoresizingMaskIntoConstraints = false
        topSearchView.snp.makeConstraints({
            $0.top.equalTo(safeArea.snp.top).offset(20)
            $0.leading.equalTo(safeArea.snp.leading).offset(10)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            $0.height.equalTo(50)
        })
    }
    
}

extension MainVC: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("마커 탭 델리게이트")
    }
}
