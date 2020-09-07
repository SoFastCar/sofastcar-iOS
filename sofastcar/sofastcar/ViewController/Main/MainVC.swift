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
    
    var topAreaFlag = false
    var markerTapFlag = false
    var carListonTopFlag = false
    var searchVCDismissFlag = false
    let marker = NMFMarker()
    let naverMapView = NMFNaverMapView()
    lazy var callPositionMarker = NMFMarker(position: defaultMarkerPosition, iconImage: NMF_MARKER_IMAGE_YELLOW)
    
    lazy var safeArea = self.view.safeAreaLayoutGuide
    let topView = TopView()
    let searchView = SearchView()
    let whiteView = UIView()
    let carListView = CarListView()
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    lazy var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - View Life Cycle        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNM()
        setupUI()
        setupConstraint()
        setupMarkers()
        activateSearchView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if searchVCDismissFlag {
            UIView.animate(withDuration: 0.5, animations: {
                self.topView.snp.updateConstraints({
                    $0.top.equalTo(self.safeArea).offset(8)
                    $0.leading.equalTo(self.safeArea).offset(10)
                    $0.trailing.equalTo(self.safeArea).offset(-10)
                    $0.height.equalTo(52)
                })
                self.searchView.snp.updateConstraints({
                    $0.top.equalTo(self.safeArea).offset(8)
                    $0.leading.equalTo(self.safeArea).offset(10)
                    $0.trailing.equalTo(self.safeArea).offset(-10)
                    $0.height.equalTo(52)
                })
                self.view.layoutIfNeeded()
                self.topView.alpha = 1
                self.searchView.alpha = 0
                self.whiteView.alpha = 0
            })
        } else {
            
        }
    }
    
    // MARK: - Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !topAreaFlag,
            markerTapFlag {
            UIView.animate(withDuration: 0.3, animations: {
                self.carListView.frame.origin.y = self.view.frame.height * 0.82
            })
        } else {
            // do nothing
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    private func activateSearchView() {
        topView.searchButton.addTarget(self, action: #selector(didTapSearchButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Selector
    @objc func didTapSearchButton(_ sender: UIButton) {
        
        // animate
        UIView.animate(withDuration: 0.5, animations: {
            self.topView.snp.updateConstraints({
                $0.top.equalTo(self.safeArea.snp.top).offset(0)
                $0.leading.equalTo(self.safeArea.snp.leading).offset(0)
                $0.trailing.equalTo(self.safeArea.snp.trailing).offset(0)
                $0.height.equalTo(60)
            })
            self.searchView.snp.updateConstraints({
                $0.top.equalTo(self.safeArea.snp.top).offset(0)
                $0.leading.equalTo(self.safeArea.snp.leading).offset(0)
                $0.trailing.equalTo(self.safeArea.snp.trailing).offset(0)
                $0.height.equalTo(60)
            })
            self.view.layoutIfNeeded()
            self.topView.alpha = 0
            self.searchView.alpha = 1
            self.whiteView.alpha = 1
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            let searchVC = SearchVC()
            searchVC.modalPresentationStyle = .fullScreen
            searchVC.modalTransitionStyle = .crossDissolve
            self.searchVCDismissFlag = false
            self.present(searchVC, animated: true)
        })
        
    }
    
    @objc func didPan(_ pan: UIPanGestureRecognizer) {
        let topY = view.frame.height * 0.09
        let centerY = view.frame.height / 2
        let bottomY = view.frame.height * 0.82
        let betweenTopCenterY = topY + (centerY - topY) / 2
        let betrweenCenterBottomY = centerY + (bottomY - centerY) / 2
        let yOffset: CGFloat = carListView.frame.origin.y
        let translation = pan.translation(in: view)
        
        if yOffset + translation.y <= topY {
            carListView.frame.origin.y = yOffset
        } else {
            carListView.frame.origin.y = yOffset + translation.y
            if yOffset + translation.y >= centerY {
                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height - carListView.frame.origin.y, right: 0)    
            } else {
                // do nothing
            }
            topAreaFlag = false
        }
        
        pan.setTranslation(.zero, in: view)
        switch pan.state {
        case .changed:
            switch yOffset {
            case 0..<topY:
                visualEffectView.alpha = 1 - yOffset / centerY
            case topY..<betweenTopCenterY:
                visualEffectView.alpha = 1 - yOffset / centerY
            case betweenTopCenterY..<centerY:
                visualEffectView.alpha = 1 - yOffset / centerY
            default:
                break
            }
        case .ended:
            switch yOffset {
            case 0..<topY:
                topAreaFlag = true
                carListView.carListTableView.isScrollEnabled = true
                carListView.frame.origin.y = topY
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
            case topY..<betweenTopCenterY:
                topAreaFlag = true
                carListView.carListTableView.isScrollEnabled = true
                carListView.frame.origin.y = topY
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
            case betweenTopCenterY..<centerY:
                topAreaFlag = false
                carListView.frame.origin.y = centerY
                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height - carListView.frame.origin.y, right: 0)
                visualEffectView.alpha = 0
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
            case centerY..<betrweenCenterBottomY:
                topAreaFlag = false
                carListView.frame.origin.y = centerY
                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height - carListView.frame.origin.y, right: 0)
                visualEffectView.alpha = 0
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
            case betrweenCenterBottomY..<bottomY:
                topAreaFlag = false
                carListView.frame.origin.y = bottomY
                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height - carListView.frame.origin.y, right: 0)
                visualEffectView.alpha = 0
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
            case bottomY...:
                topAreaFlag = false
                carListView.frame.origin.y = bottomY
                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height - carListView.frame.origin.y, right: 0)
                visualEffectView.alpha = 0
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
            default:
                break
            }
            carListonTopFlag = false
        default:
            break
        }
    }
    
    // MARK: - SetupNM
    private func setupNM() {
        naverMapView.frame = view.frame
        view.addSubview(naverMapView)
        naverMapView.mapView.touchDelegate = self
        naverMapView.mapView.addCameraDelegate(delegate: self)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: defaultCamPosition))
        marker.position = defaultMarkerPosition
        marker.mapView = naverMapView.mapView
        callPositionMarker.mapView = naverMapView.mapView
    }
    
    // MARK: - SetupMarkers
    private func setupMarkers() {
        marker.touchHandler = { (overlay) in
            self.markerTapFlag = true
            if let marker = overlay as? NMFMarker {
                marker.iconImage = NMFOverlayImage(name: "mSNormalBlue")
                self.callPositionMarker.mapView = nil
                // Car List 팝업 by View
                UIView.animate(withDuration: 0.5, animations: {
                    self.carListView.frame.origin.y = self.view.center.y
                    self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.center.y, right: 0)
                    self.topView.alpha = 0
                })
                // NMF Content Inset 이용
//                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.center.y, right: 0)
                
                // 지도 좌표로 카메라 위치 이동
//                let selectedMarkerPosition = defaultMarkerPosition - NMGLatLng(lat: 5300, lng: 0)
                let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(defaultMarkerPosition, zoom: 14))
//                let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.540003, lng: 127.057221), zoom: 14))
                // 뷰 좌표로 카메라 위치 이동
                //                let camUpdateParams = NMFCameraUpdateParams()
                //                camUpdateParams.scroll(by: CGPoint(x: .zero, y: -1 * (self.view.bounds.height / 4)))
                //                let camUpdate = NMFCameraUpdate(params: camUpdateParams)
                
                camUpdate.animation = .fly
                camUpdate.animationDuration = 0.5
                self.naverMapView.mapView.moveCamera(camUpdate)
            }
            return true
        }
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.addSubview(whiteView)
        
        searchView.alpha = 0
        view.addSubview(searchView)
        
        view.addSubview(topView)
        
        carListView.carListTableView.delegate = self
        carListView.carListTableView.dataSource = self
        carListView.carListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        carListView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        panGesture.delegate = self
        carListView.addGestureRecognizer(panGesture)
        
        visualEffectView.frame = view.frame
        visualEffectView.alpha = 0
        
        whiteView.frame = view.frame
        whiteView.backgroundColor = .white
        whiteView.alpha = 0
        
        view.addSubview(visualEffectView)
        view.addSubview(carListView)
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.snp.makeConstraints({
            $0.top.equalTo(self.safeArea).offset(8)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.height.equalTo(52)
        })
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.snp.makeConstraints({
            $0.top.equalTo(self.safeArea).offset(8)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.height.equalTo(52)
        })
    }
}

// MARK: - Extension(NMF)
extension MainVC: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        callPositionMarker.mapView = mapView
        print("didTapMap")
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.alpha = 1
            self.carListView.frame.origin.y = self.view.frame.height
            self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        })
        markerTapFlag = false
    }
}

extension MainVC: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let camPosition = mapView.cameraPosition.target
        let meterPerPixel = mapView.projection.metersPerPixel(atLatitude: mapView.cameraPosition.target.lat, zoom: mapView.cameraPosition.zoom)
//        print(meterPerPixel)
        callPositionMarker.position = camPosition
        topView.searchButton.setTitle("Geocoding", for: .normal)
    }
}

// MARK: - Extenstion(Gesture)
extension MainVC: UIGestureRecognizerDelegate {
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
//        print(#function, "press")
//        return true
//    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
//        print(#function, "event")
//        return true
//    }
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print(#function, "touch")
//        return true
//    }
//    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(#function)
        if topAreaFlag,
            !carListonTopFlag {
            carListView.carListTableView.isScrollEnabled = true
            return false
        } else {
            carListView.carListTableView.isScrollEnabled = false
            return true
        }
    }
//    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print(#function)
        return false
//        if topAreaFlag,
//        !carListonTopFlag {
//            carListView.carListTableView.isScrollEnabled = true
//            return false
//        } else {
//            carListView.carListTableView.isScrollEnabled = false
//            return false
//        }
    }
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(#function, otherGestureRecognizer)
//        return false
//    }
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(otherGestureRecognizer)
//        return false
//    }
}

// MARK: - Extension(TableView)
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(#function)
        if indexPath.row == 0 {
            carListonTopFlag = true
        } else {
            carListonTopFlag = false
        }
    }
    
}
