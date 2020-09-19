//
//  InsuranceMenuView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class InsuranceMenuView: UIView {
    let insuranceMenuHeaderView = InsuranceMenuHeaderView()
    let special = InsuranceMenuItemButton(isSpecial: true)
    let standard = InsuranceMenuItemButton(isSpecial: false)
    let light = InsuranceMenuItemButton(isSpecial: false)
    let itemStackView = UIStackView()
    let confirmButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        self.addSubview(insuranceMenuHeaderView)
        
        itemStackView.axis = .vertical
        itemStackView.distribution = .fillProportionally
        special.configuration(symbol: "circle", name: "스페셜", guarantee: 5, cost: 7500)
        itemStackView.addArrangedSubview(special)
        standard.configuration(symbol: "circle", name: "스탠다드", guarantee: 30, cost: 7500)
        itemStackView.addArrangedSubview(standard)
        light.configuration(symbol: "circle", name: "라이트", guarantee: 70, cost: 7500)
        itemStackView.addArrangedSubview(light)
        self.addSubview(itemStackView)
        
        confirmButton.backgroundColor = CommonUI.mainBlue
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        self.addSubview(confirmButton)
    }
    
    private func setupConstraint() {
        [insuranceMenuHeaderView, itemStackView, confirmButton].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        insuranceMenuHeaderView.snp.makeConstraints({
            $0.top.equalTo(self).offset(10)
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
            $0.height.equalTo((UIScreen.main.bounds.height / 2 + 50) * 0.2)            
        })
        
        itemStackView.snp.makeConstraints({
            $0.top.equalTo(insuranceMenuHeaderView.snp.bottom)
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
            $0.height.equalTo((UIScreen.main.bounds.height / 2 + 50) * 0.56)            
        })
        
        confirmButton.snp.makeConstraints({
            $0.top.equalTo(itemStackView.snp.bottom)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
    }
}
