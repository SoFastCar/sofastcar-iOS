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
    let itemGuarenteeLabel = UILabel()
    let itemCostLabel = UILabel()
    let axaButton = AxaButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.addSubview(selectSymbolImageView)
        itemNameLabel.font = .systemFont(ofSize: 16, weight: .regular)
        self.addSubview(itemNameLabel)
        itemGuarenteeLabel.font = .systemFont(ofSize: 14, weight: .regular)
        self.addSubview(itemGuarenteeLabel)
        itemCostLabel.font = .systemFont(ofSize: 17, weight: .regular)
        itemCostLabel.textColor = .darkGray
        self.addSubview(itemCostLabel)
        if isSpecial {
            self.addSubview(axaButton)
        }
    }
    
    private func setupConstraint(_ isSpecial: Bool) {
        [selectSymbolImageView, itemNameLabel, itemGuarenteeLabel, itemCostLabel].forEach({
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
        itemGuarenteeLabel.snp.makeConstraints({
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(selectSymbolImageView.snp.trailing).offset(5)
        })
        itemCostLabel.snp.makeConstraints({
            $0.top.equalTo(self).offset(5)
            $0.trailing.equalTo(self).offset(-10)
        })
        if isSpecial {
            axaButton.translatesAutoresizingMaskIntoConstraints = false
            axaButton.snp.makeConstraints({
                $0.top.equalTo(itemGuarenteeLabel.snp.bottom)
                $0.leading.equalTo(selectSymbolImageView.snp.trailing).offset(5)
            })
        }
    }
    
    func configuration(symbol selectSymbol: String, name itemName: String, guarantee itemGuarantee: Int, cost itemCost: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        selectSymbolImageView.image = UIImage(systemName: selectSymbol, withConfiguration: symbolConfig)
        itemNameLabel.text = itemName
        itemGuarenteeLabel.text = "자기부담금 최대 \(itemGuarantee)만원"
        itemCostLabel.text = "+ \(numberFormatter.string(from: NSNumber(value: itemCost)) ?? "0")원"
    }
}
