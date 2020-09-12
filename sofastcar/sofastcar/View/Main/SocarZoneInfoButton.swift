//
//  SocarZoneInfoButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SocarZoneInfoButton: UIButton {

    var socarZoneData = SocarZoneData()
    var socarZoneNameLabel = UILabel()
    var socarZoneGroundLevelLabel = UILabel()
    var socarZoneDiscripitionLabel = UILabel()
    let stackView = UIStackView()
    var socarZoneImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        socarZoneNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        socarZoneNameLabel.textColor = CommonUI.mainDark
        self.addSubview(socarZoneNameLabel)
        
        socarZoneGroundLevelLabel.layer.cornerRadius = 3
        socarZoneGroundLevelLabel.clipsToBounds = true
        socarZoneGroundLevelLabel.backgroundColor = .systemGray6
        socarZoneGroundLevelLabel.textAlignment = .center
        socarZoneGroundLevelLabel.font = .systemFont(ofSize: 12, weight: .regular)
        socarZoneGroundLevelLabel.textColor = .lightGray
        self.addSubview(socarZoneGroundLevelLabel)
        
        socarZoneDiscripitionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        socarZoneDiscripitionLabel.textColor = .gray
        self.addSubview(socarZoneDiscripitionLabel)
        
        socarZoneImageView.contentMode = .scaleToFill
        self.addSubview(socarZoneImageView)
    }
    
    private func setupConstraint() {
        [socarZoneImageView, stackView, socarZoneNameLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        socarZoneNameLabel.snp.makeConstraints({
            $0.centerY.equalTo(self).offset(-15)
            $0.leading.equalTo(self).offset(20)
        })
        socarZoneGroundLevelLabel.snp.makeConstraints({
//            $0.top.equalTo(socarZoneNameLabel.snp.bottom).offset(10)
            $0.centerY.equalTo(self).offset(15)
            $0.leading.equalTo(self).offset(20)
            $0.width.equalTo(40)
            $0.height.equalTo(25)
        })
        socarZoneDiscripitionLabel.snp.makeConstraints({
            $0.centerY.equalTo(socarZoneGroundLevelLabel)
            $0.leading.equalTo(socarZoneGroundLevelLabel.snp.trailing).offset(10)
        })
        socarZoneImageView.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-20)
            $0.width.equalTo(65)
            $0.height.equalTo(50)
        })
    }
    
    func configuration(_ name: String, _ level: String, _ discription: String, _ image: String) {
        socarZoneNameLabel.text = name
        socarZoneGroundLevelLabel.text = level
        socarZoneDiscripitionLabel.text = discription
        socarZoneImageView.image = UIImage(named: image)
    }
    
}
