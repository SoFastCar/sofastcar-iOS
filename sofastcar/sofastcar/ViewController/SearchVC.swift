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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupConstraint()
    }
    
    // MARK: - Selector
    @objc func didTapBackButton(_ sender: UIButton) {
        guard let presentingVC = self.presentingViewController as? MainVC else { return }
//        let safeArea = presentingVC.view.safeAreaLayoutGuide
//        UIView.animate(withDuration: 1, animations: {
//            
//        })
//        presentingVC.searchView.alpha = 0
//        presentingVC.topView.snp.updateConstraints({
//            $0.top.equalTo(safeArea.snp.top).offset(8)
//            $0.leading.equalTo(safeArea.snp.leading).offset(10)
//            $0.trailing.equalTo(safeArea.snp.trailing).offset(-10)
//            $0.height.equalTo(52)
//        })
//        presentingVC.topView.alpha = 1
        presentingVC.dismiss(animated: true, completion: {
            // do nothing
        })
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        searchView.backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
        searchView.searchTextField.delegate = self
        searchView.searchTextField.becomeFirstResponder()
        searchView.searchResultTableView.dataSource = self
        searchView.searchResultTableView.delegate = self
//        let searchContainerVC = UISearchContainerViewController(searchController: searchView.searchController)
        view.addSubview(searchView)
        
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.snp.makeConstraints({
            $0.top.equalTo(safeArea.snp.top)
            $0.leading.equalTo(safeArea.snp.leading)
            $0.trailing.equalTo(safeArea.snp.trailing)
            $0.bottom.equalTo(safeArea.snp.bottom)
            
//            $0.centerY.equalTo(safeArea.snp.centerY).offset(-333)
//            $0.leading.equalTo(safeArea.snp.leading).offset(0)
//            $0.trailing.equalTo(safeArea.snp.trailing).offset(0)
//            $0.height.equalTo(60)
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
        return UITableViewCell()
    }    
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

extension SearchVC: UITextFieldDelegate {
    
}
