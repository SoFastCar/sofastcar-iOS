//
//  SearchVC.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit
import NMapsMap

class SearchVC: UIViewController {
    
    let searchView = SearchView()
    //    let socarZoneData = SocarZoneData()
    var nMapAddress: [NMapAddress]?
    var searchResultData: [Document] = []
    var selectedSearchData: Document?
    lazy var safeArea = self.view.safeAreaLayoutGuide
    var tempCnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraint()
    }
    
    // MARK: - Selector
    @objc func didTapBackButton(_ sender: UIButton) {
        dissmissSearchVC(isResult: false)
//        guard let navi = self.presentingViewController as? UINavigationController else { return }
//        guard let presentingVC = navi.viewControllers.last as? MainVC else { return }
//        presentingVC.searchVCDismissFlag = true
//        UIView.animate(withDuration: 0.5, animations: {
//            
//            presentingVC.topView.snp.updateConstraints({
//                $0.top.equalTo(presentingVC.safeArea.snp.top).offset(8)
//                $0.leading.equalTo(presentingVC.safeArea.snp.leading).offset(10)
//                $0.trailing.equalTo(presentingVC.safeArea.snp.trailing).offset(-10)
//                $0.height.equalTo(52)
//            })
//            presentingVC.searchView.snp.updateConstraints({
//                $0.top.equalTo(presentingVC.safeArea.snp.top).offset(8)
//                $0.leading.equalTo(presentingVC.safeArea.snp.leading).offset(0)
//                $0.trailing.equalTo(presentingVC.safeArea.snp.trailing).offset(0)
//                $0.height.equalTo(52)
//            })
//            
//            presentingVC.searchView.shadowContainer.translatesAutoresizingMaskIntoConstraints = false
//            presentingVC.searchView.shadowContainer.snp.updateConstraints({
//                $0.height.equalTo(52)
//            })
//            
//            self.searchView.alpha = 0
//            self.view.backgroundColor = .clear
//            presentingVC.whiteView.alpha = 0
//            presentingVC.topView.alpha = 1
//            presentingVC.searchView.alpha = 0
//            presentingVC.setBookingTimeButton.frame.origin.y = presentingVC.view.frame.height - presentingVC.setBookingTimeButton.frame.height
//            presentingVC.view.layoutIfNeeded()
//        })
//        presentingVC.dismiss(animated: true)
        
    }
    
    // MARK: - Dissmiss func
    private func dissmissSearchVC(isResult flag: Bool) {
        guard let navi = self.presentingViewController as? UINavigationController else { return }
        guard let presentingVC = navi.viewControllers.last as? MainVC else { return }
        presentingVC.searchVCDismissFlag = true
        UIView.animate(withDuration: 0.5, animations: {
            
            presentingVC.topView.snp.updateConstraints({
                $0.top.equalTo(presentingVC.safeArea.snp.top).offset(8)
                $0.leading.equalTo(presentingVC.safeArea.snp.leading).offset(10)
                $0.trailing.equalTo(presentingVC.safeArea.snp.trailing).offset(-10)
                $0.height.equalTo(52)
            })
            presentingVC.searchView.snp.updateConstraints({
                $0.top.equalTo(presentingVC.safeArea.snp.top).offset(8)
                $0.leading.equalTo(presentingVC.safeArea.snp.leading).offset(0)
                $0.trailing.equalTo(presentingVC.safeArea.snp.trailing).offset(0)
                $0.height.equalTo(52)
            })
            
            presentingVC.searchView.shadowContainer.translatesAutoresizingMaskIntoConstraints = false
            presentingVC.searchView.shadowContainer.snp.updateConstraints({
                $0.height.equalTo(52)
            })
            
            self.searchView.alpha = 0
            self.view.backgroundColor = .clear
            presentingVC.whiteView.alpha = 0
            presentingVC.topView.alpha = 1
            presentingVC.searchView.alpha = 0
            presentingVC.setBookingTimeButton.frame.origin.y = presentingVC.view.frame.height - presentingVC.setBookingTimeButton.frame.height
            presentingVC.view.layoutIfNeeded()
        })
        if flag {
            presentingVC.callPositionMarker.position = NMGLatLng(lat: Double(selectedSearchData?.lat ?? "0") ?? 0, lng: Double(selectedSearchData?.lng ?? "0") ?? 0)
            presentingVC.topView.searchButton.addrLabel.text = selectedSearchData?.placeName ?? "검색 결과 없음"
            presentingVC.naverMapView.mapView.moveCamera(NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: Double(selectedSearchData?.lat ?? "0") ?? 0, 
                                                                                                               lng: Double(selectedSearchData?.lng ?? "0") ?? 0),
                                                                                                     zoom: 16)))
        } else {
            
        }
        
        presentingVC.dismiss(animated: true)
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        searchView.layer.shadowOpacity = 0
        
        searchView.backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        
        searchView.searchTextField.delegate = self
        searchView.searchTextField.becomeFirstResponder()
        
        searchView.searchResultTableView.dataSource = self
        searchView.searchResultTableView.delegate = self
        searchView.searchResultTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        view.addSubview(searchView)        
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.snp.makeConstraints({
            $0.top.equalTo(self.safeArea)
            $0.leading.equalTo(self.safeArea)
            $0.trailing.equalTo(self.safeArea)
            $0.bottom.equalTo(self.safeArea)
        })
        
        searchView.shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        searchView.shadowContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        })
    }
    
    deinit {
        searchView.searchTextField.resignFirstResponder()
    }
}

// MARK: - Extension
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResultData.count == 0 {
            let noDataView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            let noDataLabel = UILabel()
            noDataLabel.text = "검색한 기록이 없습니다."
            noDataLabel.textColor = UIColor.systemGray2
            noDataView.addSubview(noDataLabel)
            tableView.backgroundView = noDataView
            tableView.separatorStyle = .none
            noDataLabel.translatesAutoresizingMaskIntoConstraints = false
            noDataLabel.snp.makeConstraints({
                $0.centerX.equalToSuperview()
                $0.centerY.equalToSuperview().dividedBy(3)
            })
        } else {
            
        }
        return searchResultData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.separatorInset = UIEdgeInsets(top: 20, left: 10, bottom: 0, right: 20)
        cell.setupConfiguration(placeName: searchResultData[indexPath.row].placeName, placeAddr: searchResultData[indexPath.row].roadAddress, distanceFromMe: searchResultData[indexPath.row].distance)
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSearchData = searchResultData[indexPath.row]
        dissmissSearchVC(isResult: true)        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

extension SearchVC: UITextFieldDelegate {    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print(#function)
        guard let inputText = textField.text else { return }
        searchKeyword = inputText
        
        // 카카오 키워드 장소 검색
        let url = "https://dapi.kakao.com/v2/local/search/keyword.json?query=\(inputText)&y=\(callPoisition.lat)&x=\(callPoisition.lng)&radius=10000"
        if let percentageEncodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let urlTobeRequested = URL(string: percentageEncodedUrl) {
            print(urlTobeRequested)
            var urlRequest = URLRequest(url: urlTobeRequested)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("KakaoAK d1fabe4b77743a0a3fe77e60fdd0279c", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else { return print(error)}
                guard let responseCode = response as? HTTPURLResponse,
                      responseCode.statusCode == 200 else { return print(response!) }
                guard let responseData = data else { return print("No data")}
                do {
                    let decodedData = try JSONDecoder().decode(SearchResultData.self, from: responseData)
                    print(decodedData)
                    self.searchResultData = decodedData.documents
                    DispatchQueue.main.async {
                        self.searchView.searchResultTableView.reloadData()
                    }                
                } catch {
                    print("Decode Error")
                }
            }.resume()
        }    
    }
}
