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
    var reservationCompleteFlag = true
    
    // Naver Map Framework
    let testMarker = NMFMarker()
    lazy var markers: [NMFMarker] = []
    let naverMapView = NMFNaverMapView()
    lazy var callPositionMarker = NMFMarker(position: defaultMarkerPosition, iconImage: NMF_MARKER_IMAGE_YELLOW)
//    let setlogoAlign = NMFLogoAlign(rawValue: 100)
    var selectedMarkerIndex = 0
    var prevNumOfMarkers = 0
    
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
    
    // Sub Button
    let carTypeFilterButton = UIButton()
    let setMyPositionButton = UIButton()
    let pairingButton = UIButton()
    
    // Socar Zone, Socar List Data
    var socarZoneDataList: [SocarZoneData] = []
    var selectedSocarZone: SocarZoneData?
    var socarListDataList: SocarListData?
    var socarListData: [SocarList]?
    var selectedSocar: SocarList?
    var calculatedCarPrice: [Int] = []
    var selectedCarPrice: Int = 0
    
    // Insurance Item Data
    var insuranceDataList: InsuranceDataList?
    var insuranceData: [InsuranceData]?
    var selectedInsurance = Insurance(name: "", guarantee: 0, cost: 0)
    
    // New Booking Time Data
    var newStartDate = Date() {
      didSet {
        divideRendTotalTimeByHalfHour = Time.getDivideRentTodalTimeByHalfHour(start: newStartDate, end: newEndDate)
      }
    }
    var newEndDate = Date() {
      didSet {
        divideRendTotalTimeByHalfHour = Time.getDivideRentTodalTimeByHalfHour(start: newStartDate, end: newEndDate)
      }
    }
    var divideRendTotalTimeByHalfHour: Int = 8
    
    // Geocoding Data
    var roadAddrName: String = ""
    var roadAddrNumber1: String = ""
    var admCodeArea3Name: String = ""
    
    // MARK: - View Life Cycle        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNM()
        setupUI()
        setupConstraint()
        #if true
        
        #else
        _ = setupMarkers(zoneData: nil)
        #endif
        
        activateSearchView()
        networking()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        if reservationCompleteFlag {
            UIView.animate(withDuration: 0.5, animations: {
                self.setBookingTimeButton.frame.origin.y = self.view.frame.height - self.setBookingTimeButton.frame.height
            })
        } else {
            
        }
    }
    // MARK: - Network
    func networking() {
         
    }
    
    // MARK: - Naver Reverse Geocoding
    func nmReveseGeocoding(of latlng: String) {
        guard let url = URL(string: "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=\(latlng)&output=json&orders=admcode") else { fatalError() }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("10nhse2dsn", forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
        request.addValue("ZgM6sLboiN7u4kNtFDj0sZeglDjEVtBW3vaLvEg7", forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return print(error?.localizedDescription)}
            guard let responseCode = response as? HTTPURLResponse,
                (200...300).contains(responseCode.statusCode) else { return print("에러 응답: \(response)") }
            guard let responseData = data else { return print("Geocoding 실패") }
            do {
//                let serializedData = try JSONSerialization.jsonObject(with: responseData) as? [String: AnyObject]
//                print(serializedData)
                let decodedData = try JSONDecoder().decode(GeocodingDate.self, from: responseData)
                let results = decodedData.results
//                print(results.count)
                guard !results.isEmpty else { return print("주소 없음")}
                for result in results {
//                    self.roadAddrName = result.land.name
//                    self.roadAddrNumber1 = result.land.number1
                    self.admCodeArea3Name = result.region.area3.name
                    print("Geocoding Result: \(self.admCodeArea3Name)")
                }
                
                if self.roadAddrName.isEmpty {
//                    print("Geocoding Result: \(self.admCodeArea4Name)")
                }
//                print("Geocoding Result: \(self.roadAddrName) \(self.roadAddrNumber1)")
                DispatchQueue.main.async {
//                    self.topView.searchButton.setTitle(self.admCodeArea3Name, for: .normal)
                    print("12312313123123")
                    self.topView.searchButton.addrLabel.text = self.admCodeArea3Name
                }
            } catch {
                print("Geocoding Decode Error")
            }
        }.resume()
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
        // Specail
        case 0: 
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemCostLabel.textColor = .systemBlue
            insuranceMenuView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.standard.itemCostLabel.textColor = .gray
            insuranceMenuView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.light.itemCostLabel.textColor = .gray
            selectedInsurance.name = insuranceData?[0].name
            selectedInsurance.guarantee = insuranceData?[0].guarantee
            selectedInsurance.cost = insuranceData?[0].cost
        // Standard
        case 1:
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemCostLabel.textColor = .systemBlue
            insuranceMenuView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.special.itemCostLabel.textColor = .gray
            insuranceMenuView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.light.itemCostLabel.textColor = .gray
            selectedInsurance.name = insuranceData?[1].name
            selectedInsurance.guarantee = insuranceData?[1].guarantee
            selectedInsurance.cost = insuranceData?[1].cost
        // Light
        case 2:
            sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
            sender.itemCostLabel.textColor = .systemBlue
            insuranceMenuView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.special.itemCostLabel.textColor = .gray
            insuranceMenuView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
            insuranceMenuView.standard.itemCostLabel.textColor = .gray
            selectedInsurance.name = insuranceData?[2].name
            selectedInsurance.guarantee = insuranceData?[2].guarantee
            selectedInsurance.cost = insuranceData?[2].cost
        default:
            break
        }
    }
    
    // MARK: - Selector(Insurance Confirm)
    @objc func didTapInsConfirm(_ sender: UIButton) {
        let presentedVC = ReservationConfirmTableVC()
        presentedVC.socarZoneData = selectedSocarZone // 쏘카존 데이터
        presentedVC.socarData = selectedSocar // 차량 데이터
        presentedVC.insuranceData = selectedInsurance // 보험 데이터
        presentedVC.startDate = newStartDate // 시작 시간
        presentedVC.endDate = newEndDate // 종료 시간
        presentedVC.rentPrice = selectedCarPrice // 차량 렌트 가격
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.pushViewController(presentedVC, animated: true)
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
      present(sideBarVC, animated: false, completion: {
        sideBarVC.animateWithAnimate()
      })
    }
    
    // MARK: - Selector(Booking Time Button)
    @objc func didTapBookingTime(_ sender: SetBookingTimeButton) {
        let presentedVC = BookingTimeVC()
        presentedVC.setBookingTimeMain = setBookingTimeButton
        presentedVC.setBookingTimeCarList = carListView.setBookingTimeButton
        presentedVC.modalPresentationStyle = .automatic
        presentedVC.startDate = sender.startTime
        presentedVC.endDate = sender.endTime
        self.present(presentedVC, animated: true)
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
//                carListOnTopFlag = false
                carListView.frame.origin.y = topY
                carListView.carListTableView.isScrollEnabled = true
//                print("yOffset: \(yOffset), originY: \(carListView.frame.origin.y), topY: \(topY)")
            case topY..<betweenTopCenterY:
                topAreaFlag = true
//                carListOnTopFlag = false
                carListView.frame.origin.y = topY
                carListView.carListTableView.isScrollEnabled = true
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
        naverMapView.showScaleBar = false
        naverMapView.mapView.logoMargin = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height * 0.16, right: 0)
        naverMapView.mapView.moveCamera(NMFCameraUpdate(position: defaultCamPosition))
        callPositionMarker.iconImage = NMFOverlayImage(name: "callPointMarker1")
        callPositionMarker.height = 80
        callPositionMarker.width = 80
        callPositionMarker.mapView = naverMapView.mapView
    }
    
    // MARK: - SetupMarkers
    private func setupMarkers(zoneData data: [SocarZoneData]?) -> Bool {
        if markerTapFlag != true {
            #if true
            guard data?.count != 0 else { fatalError()}
            if prevNumOfMarkers != 0 {
                for index in 0...(prevNumOfMarkers - 1) {
                    markers[index].mapView = nil
                }
            } else {
                
            }
            markers.removeAll()
            prevNumOfMarkers = data?.count ?? 1
            for index in 0...((data?.count ?? 1) - 1) {
                markers.append(NMFMarker(position: NMGLatLng(lat: data?[index].lat ?? 0, lng: data?[index].lng ?? 0)))
                markers[index].iconImage = NMFOverlayImage(name: "socarZoneMarker")
                markers[index].height = 85
                markers[index].width = 85
                markers[index].mapView = naverMapView.mapView
                markers[index].touchHandler = { (overlay) in
                    self.markerTapFlag = true
                    self.reservationCompleteFlag = false
                    if let marker = overlay as? NMFMarker {
                        self.selectedMarkerIndex = index
//                        print("selectedMarker: \(data?[self.selectedMarkerIndex].name)")
                        marker.iconImage = NMFOverlayImage(name: "socarRentMarker")
                        self.callPositionMarker.mapView = nil
                        // Socar Zone Info Update
                        self.selectedSocarZone = data?[index]
                        self.carListView.socarZoneInfoButton.configuration(data?[index].name ?? "", data?[index].type ?? "", 
                                                                           data?[index].subInfo ?? "", data?[index].image ?? "")
                        // Socar List Info Update
                        guard let testUrl = URL(string: "https://sofastcar.moorekwon.xyz/carzones/\(data?[index].id ?? 260)/cars") else { return false }
                        var testRequest = URLRequest(url: testUrl)
                        testRequest.httpMethod = "GET"
                        testRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                        testRequest.addValue("JWT \(UserDefaults.getUserAuthTocken() ?? "")", forHTTPHeaderField: "Authorization")
                        let testTask = URLSession.shared.dataTask(with: testRequest) {(data, response, error) in
                            guard error == nil else { return print("error2: \(error!.localizedDescription)")}
                            guard let responseCode = response as? HTTPURLResponse,
                                (200...400).contains(responseCode.statusCode) else { return print("response: \(response ?? URLResponse())") }
                            guard let responseData = data else { return print("No data")}
                            print(responseData)
                            let jsonDecoder = JSONDecoder()
                            do {
                                let decodedData = try jsonDecoder.decode(SocarListData.self, from: responseData)
                                self.socarListDataList = decodedData
                                self.socarListData = self.socarListDataList?.results
                                print("쏘카 리스트 가져오기 성공")
                                DispatchQueue.main.async {
                                    self.carListView.carListTableView.reloadData()
                                }
                            } catch {
                                print("쏘카 리스트 가져오기 실패")
                            }
                        }
                        testTask.resume()
                        
                        // Car List 팝업 by View
                        UIView.animateKeyframes(withDuration: 1, delay: 0, animations: {
                            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5, animations: {
                                self.setBookingTimeButton.frame.origin.y = self.view.frame.height
                                self.carListView.frame.origin.y = self.view.center.y
                                self.topView.alpha = 0
                                self.backCircleButton.isHidden = false
                            })
                            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 1, animations: {
                                self.naverMapView.mapView.logoMargin = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                                self.naverMapView.mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.view.center.y, right: 0)
                                self.carListView.frame.origin.y = self.view.center.y
                            })
                        })
                        
                        let spotLigtPosition = NMFCameraPosition(NMGLatLng(lat: marker.position.lat + 0.0005, lng: marker.position.lng), zoom: 16)
                        let camUpdate = NMFCameraUpdate(position: spotLigtPosition)
                        camUpdate.animation = .fly
                        camUpdate.animationDuration = 0.5
                        self.naverMapView.mapView.moveCamera(camUpdate)
                    }
                    return true
                }
            }
            
            #else
            testMarker.position = NMGLatLng(lat: defaultMarkerPosition.lat, lng: defaultMarkerPosition.lng)
            testMarker.mapView = naverMapView.mapView
            testMarker.touchHandler = { (overlay) in
                guard let marker = overlay as? NMFMarker else { return false }
                self.markerTapFlag = true
                self.carListOnTopFlag = true
                marker.iconImage = NMFOverlayImage(name: "mSNormalBlue")
                self.callPositionMarker.mapView = nil
                self.carListView.socarZoneInfoButton.configuration(["성수", "강남"].randomElement() ?? "", ["지상", "지하"].randomElement() ?? "", 
                                                                   ["좋음", "나쁨"].randomElement() ?? "", "서초역-1")
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
                let camUpdate = NMFCameraUpdate(position: NMFCameraPosition(marker.position, zoom: 16))
                camUpdate.animation = .fly
                camUpdate.animationDuration = 0.5
                self.naverMapView.mapView.moveCamera(camUpdate)
                return true   
            }
            #endif
        } else {
            
        }
        return true // 무의미한 리턴
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        let date = floor(Date().timeIntervalSince1970)
        let restMinDate = Double(Int(date) % 600)
        newStartDate = Date(timeIntervalSince1970: date-restMinDate)
        newStartDate.addTimeInterval(TimeInterval(20*Time.min))
        newEndDate = newStartDate.addingTimeInterval(TimeInterval(Time.hour*4))
        
        carTypeFilterButton.layer.cornerRadius = 22
        carTypeFilterButton.layer.shadowOpacity = 0.2
        carTypeFilterButton.backgroundColor = .white
        carTypeFilterButton.setImage(UIImage(systemName: "car.fill", withConfiguration: carTypeFilterButton.symbolConfiguration(pointSize: 18, weight: .regular)), for: .normal)
        carTypeFilterButton.tintColor = CommonUI.mainDark
        carTypeFilterButton.isHidden = false
        view.addSubview(carTypeFilterButton)
        
        setMyPositionButton.layer.cornerRadius = 22
        setMyPositionButton.layer.shadowOpacity = 0.2
        setMyPositionButton.backgroundColor = .white
        setMyPositionButton.contentMode = .scaleAspectFill
        setMyPositionButton.setImage(UIImage(named: "icons8-hunt-30"), for: .normal)
        setMyPositionButton.tintColor = CommonUI.mainDark
        setMyPositionButton.isHidden = false
        view.addSubview(setMyPositionButton)
        
        pairingButton.layer.cornerRadius = 27
        pairingButton.layer.shadowOpacity = 0.2
        pairingButton.backgroundColor = .white
        pairingButton.setImage(UIImage(systemName: "arrow.turn.down.right", withConfiguration: pairingButton.symbolConfiguration(pointSize: 17, weight: .heavy)), for: .normal)
        pairingButton.tintColor = .systemOrange
        pairingButton.isHidden = false
        view.addSubview(pairingButton)
        
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
        insuranceMenuView.confirmButton.addTarget(self, action: #selector(didTapInsConfirm(_:)), for: .touchUpInside)
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
        
        carTypeFilterButton.snp.makeConstraints({
            $0.top.equalTo(topView.snp.bottom).offset(17)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.width.height.equalTo(44)
        })
        
        setMyPositionButton.snp.makeConstraints({
            $0.top.equalTo(carTypeFilterButton.snp.bottom).offset(10)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.width.height.equalTo(44)
        })
        
        pairingButton.snp.makeConstraints({
            $0.bottom.equalTo(setBookingTimeButton.snp.top).offset(-20)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.width.equalTo(54)
            $0.height.equalTo(54)
        })
        
        searchView.snp.makeConstraints({
            $0.top.equalTo(self.safeArea).offset(8)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.height.equalTo(52)
        })
        
        searchView.shadowContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(52)
        })
        
        topView.snp.makeConstraints({
            $0.top.equalTo(self.safeArea).offset(8)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.trailing.equalTo(self.safeArea).offset(-10)
            $0.height.equalTo(52)
        })
        
        backCircleButton.snp.makeConstraints({
            $0.centerY.equalTo(topView)
            $0.leading.equalTo(self.safeArea).offset(10)
            $0.width.equalTo(52)
            $0.height.equalTo(52)
        })
    }
    
    // MARK: - Requset Socar Zone Data
    func fetchSocarZone(lat latitude: Double, lng longitude: Double, dist distance: Double) {
        let endPoint = EndPoint(path: .distance, query: [.lat: "\(latitude)", .lon: "\(longitude)", .distance: "\(distance)"])
        socarZoneProvider.fetchSocarData(endpoint: endPoint, completionHandler: { [weak self] (result: Result<[SocarZoneData], ServiceError>) in
            switch result {
            case .success(let value): 
                self?.socarZoneDataList = value; print("쏘카존 데이터 가져오기 성공")
                
               _ = self?.setupMarkers(zoneData: self?.socarZoneDataList)
            case .failure(let error): print("쏘가존 데이터 가져오기 실패. \(error)")
            }
        })
    }
    
    // MARK: - Request Socar List Data
    func fetchSocarList(zone zoneId: Int) {
        let endPoint = EndPoint(path: .cars, query: [.zoneId: "\(zoneId)"])
        socarZoneProvider.fetchSocarData(endpoint: endPoint, completionHandler: { [weak self] (result: Result<[SocarZoneData], ServiceError>) in
            switch result {
            case .success(let value): 
                self?.socarZoneDataList = value; print("쏘카 리스트 가져오기 성공")
               _ = self?.setupMarkers(zoneData: self?.socarZoneDataList)
            case .failure(let error): print("쏘가 리스트 가져오기 실패. \(error)")
            }
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
            self.naverMapView.mapView.logoMargin = UIEdgeInsets(top: 0, left: 0, bottom: self.view.frame.height * 0.16, right: 0)
            self.callPositionMarker.position = mapView.cameraPosition.target
            self.callPositionMarker.mapView = mapView
        })
        markers[selectedMarkerIndex].iconImage = NMFOverlayImage(name: "socarZoneMarker")
        markerTapFlag = false
    }
}

extension MainVC: NMFMapViewCameraDelegate {
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        if !markerTapFlag {
            callPoisition = mapView.cameraPosition.target
            self.callPositionMarker.position = mapView.cameraPosition.target
            self.callPositionMarker.mapView = mapView
        } else {
            
        }
    }
    
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        let camPosition = mapView.cameraPosition.target
        let camZoom = mapView.cameraPosition.zoom
        let meterPerPixel = mapView.projection.metersPerPixel(atLatitude: camPosition.lat, zoom: camZoom)
        
        // 검색 바 Geocoding
        if searchVCDismissFlag {
            
        } else {
            nmReveseGeocoding(of: "\(camPosition.lng),\(camPosition.lat)")
            callPositionMarker.position = camPosition
        }
        searchVCDismissFlag = false
        
        // 반경 쏘카존 요청
        fetchSocarZone(lat: camPosition.lat, lng: camPosition.lng, dist: meterPerPixel)
        
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
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(#function)
//        if topAreaFlag,
//            !carListOnTopFlag {
//            carListView.carListTableView.isScrollEnabled = true
//            return true
//        } else {
//            carListView.carListTableView.isScrollEnabled = false
//            return true
//        }
//    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        print(#function)
        if topAreaFlag {
            if carListOnTopFlag {
                print("1, topAreaFlag : \(topAreaFlag), carListOnTopFlag: \(carListOnTopFlag)")
                carListView.carListTableView.isScrollEnabled = true
                return true
            } else {
                print("2, topAreaFlag : \(topAreaFlag), carListOnTopFlag: \(carListOnTopFlag)")
//              carListView.carListTableView.isScrollEnabled = true
                return false
            }  
        } else {
            print("3, topAreaFlag : \(topAreaFlag), carListOnTopFlag: \(carListOnTopFlag)")
            carListView.carListTableView.isScrollEnabled = false
            return true
        }
    }
    
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
        #if true
        return socarListData?.count ?? 0
        #else
        return 30
        #endif
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CarListTableViewCell.identifier, for: indexPath) as? CarListTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        #if true
        calculatedCarPrice.append(divideRendTotalTimeByHalfHour * (socarListData?[indexPath.row].carPrices.standardPrice ?? 0))
        cell.carInfoConfiguration(carImage: socarListData?[indexPath.row].image ?? "", carName: socarListData?[indexPath.row].name ?? "", carPrice: calculatedCarPrice[indexPath.row], availableDiscount: socarListData?[indexPath.row].isEvent ?? false)
        cell.timeInfoConfiguration(startTime: newStartDate, finishTime: newEndDate)
        #else
        cell.carInfoConfiguration(carImage: "SampleCar", carName: "모닝", carPrice: 30000, availableDiscount: true)
        #endif
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
        print(indexPath.row)
        if indexPath.row == 0 {
            carListOnTopFlag = true
        } else {
            carListOnTopFlag = false
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(#function)
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
//        print(#function)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print(#function)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        insuranceMenuViewFlag = true
        
//        guard let testUrl = URL(string: "https://sofastcar.moorekwon.xyz/reservations/<reservation_id>/insurances/") else { return }
//        var testRequest = URLRequest(url: testUrl)
//        testRequest.httpMethod = "GET"
//        testRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        testRequest.addValue("JWT \(UserDefaults.getUserAuthTocken() ?? "")", forHTTPHeaderField: "Authorization")
//        let testTask = URLSession.shared.dataTask(with: testRequest) {(data, response, error) in
//            guard error == nil else { return print("error2: \(error!.localizedDescription)")}
//            guard let responseCode = response as? HTTPURLResponse,
//                (200...400).contains(responseCode.statusCode) else { return print("response: \(response ?? URLResponse())") }
//            guard let responseData = data else { return print("No data")}
//            print(responseData)
//            let jsonDecoder = JSONDecoder()
//            do {
//                let decodedData = try jsonDecoder.decode(InsuranceDataList.self, from: responseData)
//                self.insuranceDataList = decodedData
//                self.insuranceData = self.insuranceDataList?.items 
//                print("면책 상품 가져오기 성공")
//                DispatchQueue.main.async {
//                    self.carListView.carListTableView.reloadData()
//                }
//            } catch {
//                print("면책 상품 가져오기 실패")
//            }
//        }
//        testTask.resume()
        self.selectedSocar = socarListData?[indexPath.row]
        selectedCarPrice = calculatedCarPrice[indexPath.row]
        self.insuranceData = [InsuranceData(name: "스페셜", guarantee: 10, cost: 10000), InsuranceData(name: "스탠다드", guarantee: 30, cost: 30000), InsuranceData(name: "라이트", guarantee: 50, cost: 50000)]
        insuranceMenuView.special.configuration(symbol: "circle", name: insuranceData?[0].name ?? "불러오기 실패", guarantee: insuranceData?[0].guarantee ?? 0, cost: insuranceData?[0].cost ?? 0)
        insuranceMenuView.standard.configuration(symbol: "circle", name: insuranceData?[1].name ?? "불러오기 실패", guarantee: insuranceData?[1].guarantee ?? 0, cost: insuranceData?[1].cost ?? 0)
        insuranceMenuView.light.configuration(symbol: "circle", name: insuranceData?[2].name ?? "불러오기 실패", guarantee: insuranceData?[2].guarantee ?? 0, cost: insuranceData?[2].cost ?? 0)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.insuranceMenuView.frame.origin.y = (self.view.frame.height / 2 ) - 50
            self.visualEffectView2.alpha = 1
        })
    }
    
}
