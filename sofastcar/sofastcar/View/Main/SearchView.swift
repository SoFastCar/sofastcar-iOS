//
//  SearchView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let backButton = UIButton()
    let shadowContainer = UIView()
    let searchController = UISearchController(searchResultsController: nil)
    let searchTextField = UITextField()
    let searchResultTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: - Setup UI
    private func setupUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        
        backButton.backgroundColor = .white
        backButton.setImage(UIImage(systemName: "arrow.left", withConfiguration: self.symbolConfiguration(pointSize: 20, weight: .regular)), for: .normal)
        backButton.tintColor = CommonUI.mainDark
        shadowContainer.addSubview(backButton)
        
        searchTextField.backgroundColor = .white
        searchTextField.clearButtonMode = .whileEditing
        searchTextField.attributedPlaceholder = NSAttributedString(string: "주소 또는 건물명 검색",
                                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                                                                                NSAttributedString.Key.backgroundColor: UIColor.white])
        searchTextField.tintColor = .systemGray
        searchTextField.borderStyle = .none
        shadowContainer.addSubview(searchTextField)
        
        shadowContainer.backgroundColor = .white
        self.addSubview(shadowContainer)
        
        searchResultTableView.layer.shadowColor = UIColor.black.cgColor
        searchResultTableView.layer.shadowOffset = CGSize(width: 0, height: 1)
        searchResultTableView.layer.shadowOpacity = 0.5
        self.addSubview(searchResultTableView)
    }
    
    // MARK: - Setup Constraint
    private func setupConstraint() {
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(50)
            $0.bottom.equalToSuperview()
        })
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalTo(backButton.snp.trailing).offset(0)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        })
        
        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(60)
        })
        
        searchResultTableView.translatesAutoresizingMaskIntoConstraints = false
        searchResultTableView.snp.makeConstraints({
            $0.top.equalTo(shadowContainer.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
}
