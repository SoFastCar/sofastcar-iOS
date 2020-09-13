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
import Foundation
import NMapsMap

public let defaultCamPosition = NMFCameraPosition(NMGLatLng(lat: 37.549303, lng: 127.057221),
                                                  zoom: 14, tilt: 0, heading: 0)
public let defaultMarkerPosition = NMGLatLng(lat: 37.545303, lng: 127.057221)

class MainVC: UIViewController {
    
    // Flags
    var topAreaFlag = false
    var markerTapFlag = false
    var carListOnTopFlag = false
    var searchVCDismissFlag = false
    var insuranceMenuViewFlag = false
    var bookingButtonDownFlag = false
    
    // Naver Map Framework
    let marker = NMFMarker()
    let naverMapView = NMFNaverMapView()
    lazy var callPositionMarker = NMFMarker(position: defaultMarkerPosition, iconImage: NMF_MARKER_IMAGE_YELLOW)
    
    // Views
    lazy var safeArea = self.view.safeAreaLayoutGuide
    let topView = TopView()
    let searchView = SearchView()
    let whiteView = UIView()
    let carListView = CarListView()
    let insuranceMenuView = InsuranceMenuView()
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
    lazy var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    lazy var visualEffectView2 = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) 
    let setBookingTimeButton = SetBookingTimeButton(on: .mainVC)
    let backCircleButton = UIButton()
    
    // MARK: - View Life Cycle        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNM()
        setupUI()
        setupConstraint()
        setupMarkers()
        activateSearchView()
        networking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.setBookingTimeButton.frame.origin.y = self.view.frame.height - self.setBookingTimeButton.frame.height
        })
        
    }
    // MARK: - Network
    func networking() {
        
        
        // 특정 쏘카 존
        guard let url = URL(string: "https://sofastcar.moorekwon.xyz/carzones/240") else {
            return print("URL error")
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJnaG9zdEBleGFtcGxlLmNvbSIsImV4cCI6MTYwMDE2ODc1NywiZW1haWwiOiJnaG9zdEBleGFtcGxlLmNvbSIsIm9yaWdfaWF0IjoxNTk5NTYzOTU3fQ.zjJwe8Dx-NP1pQygSEevvAjLD39dqQm2cU-HDq5vHcw", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard error == nil else { return print("error: \(error!.localizedDescription)")}
            guard let responseCode = response as? HTTPURLResponse,
                (200...400).contains(responseCode.statusCode) else { return print("response: \(response)") }
            print(responseCode.statusCode)
            guard let responseData = data else { return print("No data")}
            print(responseData)
            let jsonDecoder = JSONDecoder()
            do {
                let decodedData = try jsonDecoder.decode(SocarZoneData.self, from: responseData)
                print(decodedData)
                
            } catch {
                print("docode error")
            }
        }
        task.resume()
        
        // 반경 쏘카 존
        guard let url2 = URL(string: "https://sofastcar.moorekwon.xyz/carzones/list_by_distance?lat=37.54&lon=127.04&distance=1") else {
            return print("URL2 error")
        }
        var request2 = URLRequest(url: url2)
        request2.httpMethod = "GET"
        request2.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request2.addValue("JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJnaG9zdEBleGFtcGxlLmNvbSIsImV4cCI6MTYwMDE2ODc1NywiZW1haWwiOiJnaG9zdEBleGFtcGxlLmNvbSIsIm9yaWdfaWF0IjoxNTk5NTYzOTU3fQ.zjJwe8Dx-NP1pQygSEevvAjLD39dqQm2cU-HDq5vHcw", forHTTPHeaderField: "Authorization")
        
        let task2 = URLSession.shared.dataTask(with: request2) {(data, response, error) in
            guard error == nil else { return print("error2: \(error!.localizedDescription)")}
            guard let responseCode = response as? HTTPURLResponse,
                (200...400).contains(responseCode.statusCode) else { return print("response2: \(response)") }
            print("response2: \(responseCode.statusCode)")
            guard let responseData = data else { return print("No data")}
            print("data2: \(responseData)")
            let jsonDecoder = JSONDecoder()
            do {
                let decodedData = try jsonDecoder.decode([SocarZoneData2].self, from: responseData)
                print(decodedData)
                
            } catch {
                print("docode2 error")
            }
        }
        task2.resume()
    }
    
    // MARK: - Touch Methods
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if insuranceMenuViewFlag {
            UIView.animate(withDuration: 0.3, animations: {
                self.visualEffectView2.alpha = 0
                self.insuranceMenuView.frame.origin.y = self.view.frame.height
            })
            insuranceMenuViewFlag.toggle()
        } else {
            if !topAreaFlag,
                markerTapFlag {
                UIView.animate(withDuration: 0.3, animations: {
                    self.carListView.frame.origin.y = self.view.frame.height * 0.82
                })
            } else {
                // do nothing
            }
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
    
    @objc func didTapZoneInfo(_ sender: UIButton) {
        
    }
    
    // MARK: - Selector(Insurance Item)
    @objc func didTapInsuranceItem(_ sender: InsuranceMenuItemButton) {
        switch sender.tag {
        case 0:
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemPriceLabel.textColor = .systemBlue
            insuranceMenuView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.standard.itemPriceLabel.textColor = .gray
            insuranceMenuView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.light.itemPriceLabel.textColor = .gray
        case 1:
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemPriceLabel.textColor = .systemBlue
            insuranceMenuView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.special.itemPriceLabel.textColor = .gray
            insuranceMenuView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.light.itemPriceLabel.textColor = .gray
        case 2:
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemPriceLabel.textColor = .systemBlue
            insuranceMenuView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.special.itemPriceLabel.textColor = .gray
            insuranceMenuView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.standard.itemPriceLabel.textColor = .gray
        default:
            break
        }
    }
    
    // MARK: - Selector(Search Button)
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
            searchVC.modalPresentationStyle = .overFullScreen
            searchVC.modalTransitionStyle = .crossDissolve
            self.searchVCDismissFlag = false
            self.present(searchVC, animated: true)
        })
    }
    
    // MARK: - Selector(Booking Time Button)
    @objc func didTapBookingTime(_ sender: SetBookingTimeButton) {
        let presentedVC = BookingTimeVC()
        presentedVC.modalPresentationStyle = .automatic
        present(presentedVC, animated: true)
//        bookingButtonDownFlag.toggle()
//        if bookingButtonDownFlag {
//        UIView.animate(withDuration: 0.5, animations: {
//            sender.backgroundColor = .lightGray
//        })
//        } else {
//            UIView.animate(withDuration: 0.5, animations: {
//                sender.backgroundColor = .white
//            })
//        }
    }
    
    // MARK: - Selector(Circle Back Button)
    @objc func didTapCircleBack(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.topView.alpha = 1
            self.backCircleButton.isHidden = true
            self.carListView.frame.origin.y = self.view.frame.height
            self.setBookingTimeButton.frame.origin.y = self.view.frame.height - self.setBookingTimeButton.frame.height
            self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.callPositionMarker.position = self.naverMapView.mapView.cameraPosition.target
            self.callPositionMarker.mapView = self.naverMapView.mapView
        })
    }
    
    // MARK: - Selector(Pan)
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
            carListOnTopFlag = false
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
        naverMapView.showZoomControls = false
        naverMapView.showLocationButton = false
        naverMapView.showScaleBar = true
        
//        let southWest = NMGLatLng(lat: 31.43, lng: 122.37)
//        let northEast = NMGLatLng(lat: 44.35, lng: 132)
//        let bounds = NMGLatLngBounds(southWest: southWest, northEast: northEast)
        
//        let southWestCoord = naverMapView.mapView.projection.latlng(from: CGPoint(x: 0, y: 0))
//        let northEastCoord = naverMapView.mapView.projection.latlng(from: CGPoint(x: view.frame.width, y: view.frame.height))
//        let bounds = NMGLatLngBounds(southWest: southWestCoord, northEast: northEastCoord)
        
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
                // Socar Zone Info Update
                self.carListView.socarZoneInfoButton.configuration(["한국집","삼성집"].randomElement() ?? "아무집", ["지하","지상"].randomElement() ?? "공중", ["조용함","시끄러움"].randomElement() ?? "후...", ["서초역-2","무악재역-1"].randomElement() ?? "사진없음")
                // Car List 팝업 by View
                UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                        self.setBookingTimeButton.frame.origin.y = self.view.frame.height
                        self.carListView.frame.origin.y = self.view.center.y
                        self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.center.y, right: 0)
                        self.topView.alpha = 0
                        self.backCircleButton.isHidden = false
                    })
                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                        self.carListView.frame.origin.y = self.view.center.y
                    })
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
        whiteView.frame = view.frame
        whiteView.backgroundColor = .white
        whiteView.alpha = 0
        view.addSubview(whiteView)
        
        visualEffectView.frame = view.frame
        visualEffectView.alpha = 0
        view.addSubview(visualEffectView)
        
        searchView.alpha = 0
        view.addSubview(searchView)
        
        view.addSubview(topView)
        
        carListView.socarZoneInfoButton.addTarget(self, action: #selector(didTapZoneInfo(_:)), for: .touchUpInside)
        carListView.setBookingTimeButton.addTarget(self, action: #selector(didTapBookingTime(_:)), for: .touchUpInside)
        carListView.carListTableView.delegate = self
        carListView.carListTableView.dataSource = self
        carListView.carListTableView.register(CarListTableViewCell.self, forCellReuseIdentifier: CarListTableViewCell.identifier)
        carListView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height)
        carListView.layer.cornerRadius = 10
        panGesture.delegate = self
        carListView.addGestureRecognizer(panGesture)
        view.addSubview(carListView)
        
        visualEffectView2.frame = view.frame
        visualEffectView2.alpha = 0
        view.addSubview(visualEffectView2)
        
        insuranceMenuView.special.tag = 0
        insuranceMenuView.special.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
        insuranceMenuView.standard.tag = 1
        insuranceMenuView.standard.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
        insuranceMenuView.light.tag = 2
        insuranceMenuView.light.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
        
        insuranceMenuView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: view.frame.height / 2 + 50 )
        view.addSubview(insuranceMenuView)
        
        setBookingTimeButton.addTarget(self, action: #selector(didTapBookingTime(_:)), for: .touchUpInside)
        setBookingTimeButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        setBookingTimeButton.layer.cornerRadius = 8
        setBookingTimeButton.layer.shadowOpacity = 0.1
        setBookingTimeButton.frame = CGRect(x: view.frame.width * 0.03, y: view.frame.height, width: view.frame.width * 0.94, height: view.frame.height * 0.16)
        view.addSubview(setBookingTimeButton)
        
        backCircleButton.layer.cornerRadius = 26
        backCircleButton.layer.shadowOpacity = 0.2
        backCircleButton.backgroundColor = .white
        backCircleButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: backCircleButton.symbolConfiguration(pointSize: 17, weight: .regular)), for: .normal)
        backCircleButton.addTarget(self, action: #selector(didTapCircleBack(_:)), for: .touchUpInside)
        backCircleButton.tintColor = CommonUI.mainDark
        backCircleButton.isHidden = true
        view.addSubview(backCircleButton)
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
        
        backCircleButton.translatesAutoresizingMaskIntoConstraints = false
        backCircleButton.snp.makeConstraints({
            $0.centerY.equalTo(topView)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.width.equalTo(52)
            $0.height.equalTo(52)
        })
    }
}

// MARK: - Extension(NMF)
extension MainVC: NMFMapViewTouchDelegate {
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("didTapMap")
        UIView.animate(withDuration: 0.3, animations: {
            self.topView.alpha = 1
            self.backCircleButton.isHidden = true
            self.carListView.frame.origin.y = self.view.frame.height
            self.setBookingTimeButton.frame.origin.y = self.view.frame.height - self.setBookingTimeButton.frame.height
            self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            self.callPositionMarker.position = mapView.cameraPosition.target
            self.callPositionMarker.mapView = mapView
        })
        markerTapFlag = false
    }
}

extension MainVC: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        let camPosition = mapView.cameraPosition.target
        let viewHeight = view.frame.height
        
        let meterPerPixel = mapView.projection.metersPerPixel(atLatitude: mapView.cameraPosition.target.lat, zoom: mapView.cameraPosition.zoom)
        print("lat: \(mapView.cameraPosition.target.lat), zoom: \(mapView.cameraPosition.zoom), mpp: \(meterPerPixel)")
        let asdf = CGFloat(meterPerPixel)
        print(viewHeight * asdf)
//        print(viewHeight * CGFloat(meterPerPixel / 1000))
//        let southWestCoord = naverMapView.mapView.projection.latlng(from: CGPoint(x: view.frame.width, y: 0))
//        let northEastCoord = naverMapView.mapView.projection.latlng(from: CGPoint(x: 0, y: view.frame.height))
//        let bounds = NMGLatLngBounds(southWest: southWestCoord, northEast: northEastCoord)
//        print("축적도: \(meterPerPixel), 북동 위경도: \(southWestCoord), 남서 위경도: \(northEastCoord), 바운즈: \(bounds)")
        
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
            !carListOnTopFlag {
            carListView.carListTableView.isScrollEnabled = true
            return true
        } else {
            carListView.carListTableView.isScrollEnabled = false
            return true
        }
    }
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(#function)
//        if topAreaFlag,
//        !carListOnTopFlag {
//            print("3")
//            carListView.carListTableView.isScrollEnabled = true
//            return false
//        } else {
//            print("4")
//            carListView.carListTableView.isScrollEnabled = false
//            return true
//        }
//    }
    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//
//        if topAreaFlag,
//            !carListOnTopFlag {
//            otherGestureRecognizer.
//            return false
//        } else {
//            print("2")
//            return true
//        }
//    }
//    
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if topAreaFlag,
//            !carListOnTopFlag {
//            print("3")
//            return false
//        } else {
//            print("4")
//            return true
//        }
//    }
}

// MARK: - Extension(TableView)
extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableViewCell.identifier, for: indexPath) as? CarListTableViewCell else { return UITableViewCell() }
        let date1 = Date()
        let date2 = Date(timeInterval: 36000, since: date1)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        cell.carInfoConfiguration(carImage: "SampleCar", carName: "더뉴아반떼", carPrice: 25000, availableDiscount: true)
        cell.timeInfoConfiguration(startTime: date1, finishTime: date2)
        return cell
    }

}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (UIScreen.main.bounds.height / 2) * 0.15
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            carListOnTopFlag = true
        } else {
            carListOnTopFlag = false
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print(#function)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        insuranceMenuViewFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            self.insuranceMenuView.frame.origin.y = (self.view.frame.height / 2 ) - 50
            self.visualEffectView2.alpha = 1
        })
    }
    
}
