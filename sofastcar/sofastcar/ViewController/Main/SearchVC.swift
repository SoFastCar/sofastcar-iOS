//
//  SearchVC.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    
    let searchView = SearchView()
    let socarZoneData = SocarZoneData()
    lazy var safeArea = self.view.safeAreaLayoutGuide
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraint()
    }
    
    // MARK: - Selector
    @objc func didTapBackButton(_ sender: UIButton) {
        guard let presentingVC = self.presentingViewController as? MainVC else { return }
        presentingVC.searchVCDismissFlag = true
        presentingVC.dismiss(animated: true, completion: nil)
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
    }
    
    deinit {
        searchView.searchTextField.resignFirstResponder()
    }
}

// MARK: - Extension
extension SearchVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.setupConfiguration(symbol: socarZoneData.symbols.randomElement() ?? "flame.fill", placeName: socarZoneData.name.randomElement() ?? "이름 없음", placeAddr: socarZoneData.addr.randomElement() ?? "주소 없음", distanceFromMe: socarZoneData.distance.randomElement() ?? 0)
        
        return cell
    }    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension SearchVC: UITextFieldDelegate {
    
}
