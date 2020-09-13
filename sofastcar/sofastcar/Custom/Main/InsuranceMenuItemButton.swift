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
    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 25)
    let itemNameLabel = UILabel()
    let itemDiscriptionLabel = UILabel()
    let itemPriceLabel = UILabel()
    let axaButton = AxaButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupUI()
//        setupConstraint()
    }
    
    convenience init(isSpecial: Bool) {
        self.init()        
        setupUI(isSpecial)
        setupConstraint(isSpecial)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(_ isSpecial: Bool) {
        self.backgroundColor = .systemTeal
        self.addSubview(selectSymbolImageView)
//        itemNameLabel.font = .preferredFont(forTextStyle: .title3)
        itemNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        self.addSubview(itemNameLabel)
//        itemDiscriptionLabel.font = .preferredFont(forTextStyle: .body)
        itemDiscriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        self.addSubview(itemDiscriptionLabel)
//        itemPriceLabel.font = .preferredFont(forTextStyle: .title2)
        itemPriceLabel.font = .systemFont(ofSize: 17, weight: .regular)
        itemPriceLabel.textColor = .darkGray
        self.addSubview(itemPriceLabel)
        if isSpecial {
            self.addSubview(axaButton)
        }
    }
    
    private func setupConstraint(_ isSpecial: Bool) {
        [selectSymbolImageView, itemNameLabel, itemDiscriptionLabel, itemPriceLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        selectSymbolImageView.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
        })
        itemNameLabel.snp.makeConstraints({
            $0.top.equalTo(self).offset(5)
            $0.leading.equalTo(selectSymbolImageView.snp.trailing).offset(5)
        })
        itemDiscriptionLabel.snp.makeConstraints({
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(selectSymbolImageView.snp.trailing).offset(5)
        })
        itemPriceLabel.snp.makeConstraints({
            $0.top.equalTo(self).offset(5)
            $0.trailing.equalTo(self).offset(-10)
        })
        if isSpecial {
            axaButton.translatesAutoresizingMaskIntoConstraints = false
            axaButton.snp.makeConstraints({
                $0.top.equalTo(itemDiscriptionLabel.snp.bottom)
                $0.leading.equalTo(selectSymbolImageView.snp.trailing).offset(5)
            })
        }
    }
    
    func configuration(symbol selectSymbol: String, name itemName: String, discription itemDiscription: String, price itemPrice: String) {
        selectSymbolImageView.image = UIImage(systemName: selectSymbol, withConfiguration: symbolConfig)
        itemNameLabel.text = itemName
        itemDiscriptionLabel.text = itemDiscription
        itemPriceLabel.text = itemPrice
    }
}
