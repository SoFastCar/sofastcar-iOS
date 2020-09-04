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
    
    let marker = NMFMarker()
    let naverMapView = NMFNaverMapView()
    let topView = TopView()
    let carListView = CarListView()
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    lazy var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: - View Life Cycle        
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(view.bounds.height)
        setupNM()
        setupUI()
        setupConstraint()
        setupMarkers()
        activateSearchView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !topAreaFlag {
            UIView.animate(withDuration: 0.3, animations: {
                self.topView.alpha = 1
                self.carListView.frame.origin.y = self.view.frame.height * 0.82
            })
        } else {
            // do nothing
        }
    }
    
    private func activateSearchView() {
        topView.searchButton.addTarget(self, action: #selector(didTapSearchButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSearchButton(_ sender: UIButton) {
        print("search button")
        let safeArea = view.safeAreaLayoutGuide
        topView.searchButton.titleLabel?.text = "눌러짐"
        topView.sideBarButton.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        
        // animate
        UIView.animate(withDuration: 1, animations: {
            self.topView.snp.updateConstraints({
                $0.top.equalTo(safeArea.snp.top).offset(0)
                $0.leading.equalTo(safeArea.snp.leading).offset(0)
                $0.trailing.equalTo(safeArea.snp.trailing).offset(0)
                $0.height.equalTo(60)
            })
            self.view.layoutIfNeeded()
        })
        let searchVC = SearchVC()
        navigationController?.pushViewController(searchVC, animated: true)
        
        // animateKeyframes
//        UIView.animateKeyframes(withDuration: 2, delay: 0, animations: {
//            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1, animations: {
//                print("1")
//                self.topSearchView.snp.updateConstraints({
//                    $0.top.equalTo(safeArea.snp.top).offset(0)
//                    $0.leading.equalTo(safeArea.snp.leading).offset(0)
//                    $0.trailing.equalTo(safeArea.snp.trailing).offset(0)
//                    $0.height.equalTo(70)
//                })
//                self.view.layoutIfNeeded()
//            })
//            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 1, animations: {
//                print("2")
//                let searchVC = SearchVC()
//                self.navigationController?.pushViewController(searchVC, animated: true)
//            })
//        })
        
        // transition
//        let searchView = SearchView()
//        UIView.transition(from: topView, to: searchView, duration: 2, options: .overrideInheritedDuration, completion: nil)
        
    }
    
    // MARK: - Selector
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
        case .changed:
            switch yOffset {
            case 0..<topY:
                visualEffectView.alpha = 1 - yOffset / centerY
                print("visualEffectView.alpha: \(visualEffectView.alpha)")
            case topY..<betweenTopCenterY:
                visualEffectView.alpha = 1 - yOffset / centerY
                print("visualEffectView.alpha: \(visualEffectView.alpha)")
            case betweenTopCenterY..<centerY:
                visualEffectView.alpha = 1 - yOffset / centerY
                print("visualEffectView.alpha: \(visualEffectView.alpha)")
            default:
                break
            }
        case .ended:
            switch yOffset {
            case 0..<topY:
                topAreaFlag = true
                carListView.frame.origin.y = topY
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
            case topY..<betweenTopCenterY:
                topAreaFlag = true
                carListView.frame.origin.y = topY
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
            case betweenTopCenterY..<centerY:
                topAreaFlag = false
                carListView.frame.origin.y = centerY
                visualEffectView.alpha = 0
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
            case centerY..<betrweenCenterBottomY:
                topAreaFlag = false
                carListView.frame.origin.y = centerY
                visualEffectView.alpha = 0
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), centerY: \(centerY)")
            case betrweenCenterBottomY..<bottomY:
                topAreaFlag = false
                carListView.frame.origin.y = bottomY
                visualEffectView.alpha = 0
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
            case bottomY...:
                topAreaFlag = false
                carListView.frame.origin.y = bottomY
                visualEffectView.alpha = 0
                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), bottomY: \(bottomY)")
            default:
                break
            }
        default:
            break
        }
    }
    
    // MARK: - SetupNM
    private func setupNM() {
        naverMapView.frame = view.frame
        view.addSubview(naverMapView)
        naverMapView.mapView.touchDelegate = self
        print(defaultCamPosition)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: defaultCamPosition))
        marker.position = defaultMarkerPosition
        marker.mapView = naverMapView.mapView
    }
    
    // MARK: - SetupMarkers
    private func setupMarkers() {
        marker.touchHandler = { (overlay) in
            if let marker = overlay as? NMFMarker {
                marker.iconImage = NMFOverlayImage(name: "mSNormalBlue")
                
                // Car List 팝업 by View
                UIView.animate(withDuration: 0.5, animations: {
                    self.carListView.frame.origin.y = self.view.center.y
                    self.topView.alpha = 0
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
            }
            return true
        }
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        topView.backgroundColor = .systemTeal
        topView.layer.shadowOpacity = 1
        topView.layer.shadowPath = CGPath(rect: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), transform: nil)
        topView.layer.shadowRadius = 10
        view.addSubview(topView)
        
        panGesture.delegate = self
        
        carListView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        carListView.addGestureRecognizer(panGesture)
        
        visualEffectView.frame = view.frame
        visualEffectView.alpha = 0
        
        view.addSubview(visualEffectView)
        view.addSubview(carListView)
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.snp.makeConstraints({
            $0.top.equalTo(safeArea.snp.top).offset(8)
            $0.leading.equalTo(safeArea.snp.leading).offset(10)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(-10)
            $0.height.equalTo(52)
        })
    }
}

extension MainVC: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("마커 탭 델리게이트")
    }
}

extension MainVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        print(#function, "press")
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive event: UIEvent) -> Bool {
        print(#function, "event")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print(#function, "touch")
        return true
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print(#function)
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print(#function, otherGestureRecognizer)
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print(#function, otherGestureRecognizer)
        return false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print(otherGestureRecognizer)
        return false
    }
}
extension MainVC: UINavigationControllerDelegate {
    
}
