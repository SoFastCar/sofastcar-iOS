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

public let defaultCamPosition = NMFCameraPosition(NMGLatLng(lat: 37.545303, lng: 127.057221),
                                                  zoom: 14, tilt: 0, heading: 0)
public let defaultMarkerPosition = NMGLatLng(lat: 37.545303, lng: 127.057221)

class MainVC: UIViewController {
    
    let marker = NMFMarker()
    let naverMapView = NMFNaverMapView()
    let topSearchView = TopSearchView()
    let carListView = CarListView()
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNM()
        setupUI()
        setupConstraint()
        setupMarkers()
        
    }
    
    @objc func didPan(_ pan: UIPanGestureRecognizer) {
            let topY = view.frame.height * 0.09
            let centerY = view.frame.height / 2
            let bottomY = view.frame.height * 0.82
            let betweenTopCenterY = topY + (centerY - topY) / 2
            let betrweenCenterBottomY = centerY + (bottomY - centerY) / 2
            let yOffset: CGFloat = carListView.frame.origin.y
            
            let translation = pan.translation(in: view)
            carListView.frame.origin.y = yOffset + translation.y
            pan.setTranslation(.zero, in: view)
            
            switch pan.state {
            case .ended:
                switch yOffset {
                case 0..<topY:
                    carListView.frame.origin.y = topY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
                case topY..<betweenTopCenterY:
                    carListView.frame.origin.y = topY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
                case betweenTopCenterY..<centerY:
                    carListView.frame.origin.y = centerY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
                case centerY..<betrweenCenterBottomY:
                    carListView.frame.origin.y = centerY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
                case betrweenCenterBottomY..<bottomY:
                    carListView.frame.origin.y = bottomY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
                case bottomY...:
                    carListView.frame.origin.y = bottomY
                    print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
                default:
                    break
                }
            default:
                break
            }
        }
    
    private func setupNM() {
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
                marker.iconImage = NMFOverlayImage(name: "mSNormalBlue")
                
                // Car List 팝업 by View
                UIView.animate(withDuration: 0.5, animations: {
                    self.carListView.frame.origin.y = self.view.center.y
                })
                
                // 지도 좌표로 카메라 위치 이동
                let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.540003, lng: 127.057221),
                                                                            zoom: 14))
                // 뷰 좌표로 카메라 위치 이동
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
        
        carListView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        carListView.addGestureRecognizer(panGesture)
        view.addSubview(carListView)
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
