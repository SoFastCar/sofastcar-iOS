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
    let special = InsuranceMenuItemButton()
    let standard = InsuranceMenuItemButton()
    let light = InsuranceMenuItemButton()
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
        
        itemStackView.backgroundColor = .systemOrange
        itemStackView.axis = .vertical
        itemStackView.distribution = .fillProportionally
        special.configuration(symbol: "circle", name: "스페셜", discription: "자기부담금 최대 5만원", price: "+ 7,750원")
        itemStackView.addArrangedSubview(special)
        standard.configuration(symbol: "circle", name: "스탠다드", discription: "자기부담금 최대 30만원", price: "+ 5,750원")
        itemStackView.addArrangedSubview(standard)
        light.configuration(symbol: "circle", name: "라이트", discription: "자기부담금 최대 70만원", price: "+ 3,750원")
        itemStackView.addArrangedSubview(light)
        self.addSubview(itemStackView)
        
        confirmButton.backgroundColor = .systemBlue
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
            $0.height.equalTo(100)            
        })
        
        itemStackView.snp.makeConstraints({
            $0.top.equalTo(insuranceMenuHeaderView.snp.bottom)
            $0.leading.equalTo(self).offset(10)
            $0.trailing.equalTo(self).offset(-10)
            $0.height.equalTo(250)            
        })
        
        confirmButton.snp.makeConstraints({
            $0.top.equalTo(itemStackView.snp.bottom)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.height.equalTo(100)            
        })
    }
}
