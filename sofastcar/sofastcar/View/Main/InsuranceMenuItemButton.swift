//
//  InsuranceMenuItemButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class InsuranceMenuItemButton: UIButton {

    let selectSymbolImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemDiscriptionLabel = UILabel()
    let itemPriceLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemTeal
        selectSymbolImageView.image = UIImage(systemName: "circle")
        self.addSubview(selectSymbolImageView)
        itemNameLabel.font = .preferredFont(forTextStyle: .title3)
        self.addSubview(itemNameLabel)
        itemDiscriptionLabel.font = .preferredFont(forTextStyle: .body)
        self.addSubview(itemDiscriptionLabel)
        itemPriceLabel.font = .preferredFont(forTextStyle: .title2)
        self.addSubview(itemPriceLabel)
    }
    
    private func setupConstraint() {
        [selectSymbolImageView, itemNameLabel, itemDiscriptionLabel, itemPriceLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        selectSymbolImageView.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
        })
        itemNameLabel.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(selectSymbolImageView.snp.trailing)
        })
        itemDiscriptionLabel.snp.makeConstraints({
            $0.top.equalTo(itemNameLabel.snp.bottom)
            $0.leading.equalTo(selectSymbolImageView.snp.trailing)
        })
        itemPriceLabel.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.trailing.equalTo(self)
        })
    }
    
    func configuration(symbol selectSymbol: String, name itemName: String, discription itemDiscription: String, price itemPrice: String) {
        selectSymbolImageView.image = UIImage(systemName: selectSymbol)
        itemNameLabel.text = itemName
        itemDiscriptionLabel.text = itemDiscription
        itemPriceLabel.text = itemPrice
    }
}
