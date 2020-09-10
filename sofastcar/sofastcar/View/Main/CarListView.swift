//
//  CarListView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListView: UIView {
    
    let socarZoneData = SocarZoneData()
    
    var decoView = UIView()
    var decoBar = UIView()
    let parkingLotInfoButton = UIButton()
    let socarZoneInfoButton = SocarZoneInfoButton()
    let setBookingTimeButton = SetBookingTimeButton()
    let stackView = UIStackView()
    let carListTableView = UITableView()
    
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
    
        socarZoneInfoButton.configuration(socarZoneData.name.randomElement() ?? "이름 없음", socarZoneData.groundLevel.randomElement() ?? "모름", socarZoneData.discription.randomElement() ?? "설명 없음", socarZoneData.imageName.randomElement() ?? "사진 없음")
        self.addSubview(socarZoneInfoButton)
        
//        setBookingTimeButton.addBorder(toSide: .top, withColor: UIColor.lightGray.cgColor, andThickness: 1)
//        setBookingTimeButton.addBorder(toSide: .bottom, withColor: UIColor.lightGray.cgColor, andThickness: 1)
        self.addSubview(setBookingTimeButton)
        
        carListTableView.bounces = false
        
        let visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.frame
        self.addSubview(visualEffectView)
        
        self.addSubview(carListTableView)
    }
    
    private func setupConstraint() {
        [socarZoneInfoButton, setBookingTimeButton, carListTableView, decoBar, decoView].forEach({
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
        setBookingTimeButton.snp.makeConstraints({
            $0.top.equalTo(socarZoneInfoButton.snp.bottom)
            $0.leading.equalToSuperview().offset(-1)
            $0.trailing.equalToSuperview().offset(1)
            $0.height.equalTo((UIScreen.main.bounds.height / 2) * 0.15)
        })
        
        carListTableView.snp.makeConstraints({
            $0.top.equalTo(setBookingTimeButton.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
}
