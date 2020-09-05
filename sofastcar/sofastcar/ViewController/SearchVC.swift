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
        print(self.presentingViewController)
        guard let presentingVC = self.presentingViewController as? MainVC else { return }
        presentingVC.dismiss(animated: true, completion: {
            print(#function)
            // do nothing
        })
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        searchView.backButton.addTarget(self, action: #selector(didTapBackButton(_:)), for: .touchUpInside)
//        let searchContainerVC = UISearchContainerViewController(searchController: searchView.searchController)
        view.addSubview(searchView)
        
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.snp.makeConstraints({
            $0.top.equalTo(safeArea.snp.top).offset(0)
            $0.leading.equalTo(safeArea.snp.leading).offset(0)
            $0.trailing.equalTo(safeArea.snp.trailing).offset(0)
            $0.height.equalTo(60)
        })
    }
    
    

}
