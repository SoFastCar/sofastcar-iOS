//
//  CarListView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListView: UIView {
    
    var decoView = UIView()
    var decoBar = UIView()
    let parkingLotInfoButton = UIButton()
    let socarZoneInfoButton = SocarZoneInfoButton()
    let setBookingTimeButton = SetBookingTimeButton(on: .carList)
    let stackView = UIStackView()
    let carListTableView = UITableView()
    let divider1 = UIView()
    let divider2 = UIView()
    
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
        self.layer.shadowOpacity = 0.3
        
        decoBar.backgroundColor = .systemGray6
        decoBar.layer.cornerRadius = 2
        decoView.addSubview(decoBar)
        decoView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        decoView.layer.cornerRadius = 5
        decoView.clipsToBounds = true
        self.addSubview(decoView)
        
        divider1.backgroundColor = .systemGray6
        self.addSubview(divider1)
        
        self.addSubview(socarZoneInfoButton)
        
        divider1.backgroundColor = .systemGray6
        self.addSubview(divider1)
        
        self.addSubview(setBookingTimeButton)
        
        divider2.backgroundColor = .systemGray6
        self.addSubview(divider2)
        
        carListTableView.bounces = false
        
        let visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.frame
        self.addSubview(visualEffectView)
        
        self.addSubview(carListTableView)
    }
    
    private func setupConstraint() {
        [socarZoneInfoButton, setBookingTimeButton, carListTableView, decoBar, decoView, divider1, divider2].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        decoView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        })
        decoBar.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(30)
            $0.height.equalTo(3)
        })
        socarZoneInfoButton.snp.makeConstraints({
            $0.top.equalTo(decoView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo((UIScreen.main.bounds.height / 2) * 0.25)
        })
        divider1.snp.makeConstraints({
            $0.top.equalTo(socarZoneInfoButton.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        })
        setBookingTimeButton.snp.makeConstraints({
            $0.top.equalTo(divider1.snp.bottom)
            $0.leading.equalToSuperview().offset(-1)
            $0.trailing.equalToSuperview().offset(1)
            $0.height.equalTo((UIScreen.main.bounds.height / 2) * 0.15)
        })
        divider2.snp.makeConstraints({
            $0.top.equalTo(setBookingTimeButton.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        })
        
        carListTableView.snp.makeConstraints({
            $0.top.equalTo(divider2.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
}
