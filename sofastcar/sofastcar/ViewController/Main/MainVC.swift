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
                                                  zoom: 16, tilt: 0, heading: 0)
public let defaultMarkerPosition = NMGLatLng(lat: 37.545303, lng: 127.057221)

class MainVC: UIViewController {
    
    var socarZoneProvider: SocarZoneProvidable!
    
    // Flags
    var topAreaFlag = false
    var markerTapFlag = false
    var carListOnTopFlag = false
    var searchVCDismissFlag = false
    var insuranceMenuViewFlag = false
    var bookingButtonDownFlag = false
    
    // Naver Map Framework
//    let marker = NMFMarker()
    lazy var markers: [NMFMarker] = []
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
    
    var socarZoneDataList: [SocarZoneData2] = []
    // side bar Presenting
    var presentTransition: UIViewControllerAnimatedTransitioning?
    var dismissTransition: UIViewControllerAnimatedTransitioning?
    
    // MARK: - View Life Cycle        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNM()
        setupUI()
        setupConstraint()
//        setupMarkers()
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
         
    }
    
    func nmfGeocoding() {
//        guard let url = URL(string: "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=분당구 불정로 6&coordinate=127.1054328,37.3595963") else {
//            return print("Geocoding URL Error")
//        }
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error == nil else { return print(error?.localizedDescription)}
//            guard let responseCode = response as? HTTPURLResponse,
//                (200...400).contains(responseCode.statusCode) else { return print(response)}
//            guard let responseData = data else { return print("No data")}
//            
////            do {
////                let decodedData = try JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
////            } catch {
////                
////            }
//        }
//        task.resume()
//        
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
                    self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.frame.height - self.view.frame.height * 0.82, right: 0)
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
        topView.sideBarButton.addTarget(self, action: #selector(didTapSideBarButton(_:)), for: .touchUpInside)
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
            
            self.searchView.shadowContainer.translatesAutoresizingMaskIntoConstraints = false
            self.searchView.shadowContainer.snp.updateConstraints({
                $0.height.equalTo(60)
            })
            
            self.setBookingTimeButton.frame = CGRect(x: self.view.frame.width * 0.03, y: self.view.frame.height,
                                                     width: self.view.frame.width * 0.94, height: self.view.frame.height * 0.16)
            
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
  
    @objc func didTapSideBarButton(_ sender: UIButton) {
      let sideBarVC = SideBarVC()
      sideBarVC.modalPresentationStyle = .overFullScreen
      presentDetail(sideBarVC)
    }
    
    // MARK: - Selector(Booking Time Button)
    @objc func didTapBookingTime(_ sender: SetBookingTimeButton) {
        let presentedVC = BookingTimeVC()
        presentedVC.modalPresentationStyle = .automatic
        presentedVC.startDate = sender.startTime
        presentedVC.endDate = sender.endTime
        present(presentedVC, animated: true)
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
        markerTapFlag = false
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
        callPositionMarker.mapView = naverMapView.mapView
    }
    
    // MARK: - SetupMarkers
    private func setupMarkers(zoneData data: [SocarZoneData2]?) {
        guard data?.count != 0 else { fatalError()}
        for index in 0...((data?.count ?? 1) - 1) {
            markers.append(NMFMarker(position: NMGLatLng(lat: data?[index].lat ?? 0, lng: data?[index].lng ?? 0)))
            markers[index].touchHandler = { (overlay) in
                        self.markerTapFlag = true
                        if let marker = overlay as? NMFMarker {
                            marker.iconImage = NMFOverlayImage(name: "mSNormalBlue")
                            self.callPositionMarker.mapView = nil
                            // Socar Zone Info Update
                            self.carListView.socarZoneInfoButton.configuration(data?[index].name ?? "", data?[index].type ?? "", 
                                                                               data?[index].subInfo ?? "", data?[index].image ?? "")
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
                            let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(marker.position, zoom: 16))
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
                    print("makers[\(index)].position.lat = \(markers[index].position.lat)")
                    markers[index].mapView = naverMapView.mapView
        }
//        callPositionMarker.mapView = naverMapView.mapView
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        whiteView.frame = view.frame
        whiteView.backgroundColor = .white
        whiteView.alpha = 0
        view.addSubview(whiteView)
        
        backCircleButton.layer.cornerRadius = 26
        backCircleButton.layer.shadowOpacity = 0.2
        backCircleButton.backgroundColor = .white
        backCircleButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: backCircleButton.symbolConfiguration(pointSize: 17, weight: .regular)), for: .normal)
        backCircleButton.addTarget(self, action: #selector(didTapCircleBack(_:)), for: .touchUpInside)
        backCircleButton.tintColor = CommonUI.mainDark
        backCircleButton.isHidden = true
        view.addSubview(backCircleButton)
        
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
        
        searchView.shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        searchView.shadowContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
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
        callPositionMarker.position = camPosition
        topView.searchButton.setTitle("Geocoding", for: .normal)
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let camPosition = mapView.cameraPosition.target
        let camZoom = mapView.cameraPosition.zoom
        let meterPerPixel = mapView.projection.metersPerPixel(atLatitude: camPosition.lat, zoom: camZoom)
        
        // 반경 쏘카존
        let endPoint = EndPoint(path: .distance, query: [.lat: "\(camPosition.lat)", .lon: "\(camPosition.lng)", .distance: "\(meterPerPixel)"])
    
        // 레퍼런스
        socarZoneProvider.fetchSocarZoneData(endpoint: endPoint, completionHandler: { [weak self] (result: Result<[SocarZoneData2], ServiceError>) in
            switch result {
            case .success(let value): 
                self?.socarZoneDataList = value; print("쏘카존 데이터 가져오기 성공")
                self?.setupMarkers(zoneData: self?.socarZoneDataList)
            case .failure(let error): print("기상 예보 가져오기 실패. \(error)")
            }
        })
        
        // 내꺼
//        var request2 = URLRequest(url: url2)
//        request2.httpMethod = "GET"
//        request2.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request2.addValue("JWT eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxMiwidXNlcm5hbWUiOiJnaG9zdEBleGFtcGxlLmNvbSIsImV4cCI6MTYwMDE2ODc1NywiZW1haWwiOiJnaG9zdEBleGFtcGxlLmNvbSIsIm9yaWdfaWF0IjoxNTk5NTYzOTU3fQ.zjJwe8Dx-NP1pQygSEevvAjLD39dqQm2cU-HDq5vHcw", forHTTPHeaderField: "Authorization")
//        
//        let task2 = URLSession.shared.dataTask(with: request2) {(data, response, error) in
//            guard error == nil else { return print("error2: \(error!.localizedDescription)")}
//            guard let responseCode = response as? HTTPURLResponse,
//                (200...400).contains(responseCode.statusCode) else { return print("response2: \(response ?? URLResponse())") }
//            guard let responseData = data else { return print("No data")}
//            
//            let jsonDecoder = JSONDecoder()
//            do {
//                let decodedData = try jsonDecoder.decode([SocarZoneData2].self, from: responseData)
//                self.socarZoneDataList = decodedData
//            } catch {
//                print("docode2 error")
//            }
//        }
//        task2.resume()
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
