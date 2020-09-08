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
        socarZoneNameLabel.backgroundColor = .systemYellow
        self.addSubview(socarZoneNameLabel)
        
        socarZoneGroundLevelLabel.backgroundColor = .systemOrange
        stackView.addArrangedSubview(socarZoneGroundLevelLabel)
        
        socarZoneDiscripitionLabel.backgroundColor = .systemRed
        stackView.addArrangedSubview(socarZoneDiscripitionLabel)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
        
        socarZoneImageView.contentMode = .scaleAspectFit
        self.addSubview(socarZoneImageView)
    }
    
    private func setupConstraint() {
        [socarZoneImageView, stackView, socarZoneNameLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        socarZoneNameLabel.snp.makeConstraints({
            $0.top.equalTo(self).offset(20)
            $0.leading.equalTo(self).offset(10)
        })
        stackView.snp.makeConstraints({
            $0.top.equalTo(socarZoneNameLabel.snp.bottom)
            $0.leading.equalTo(self).offset(10)
            $0.bottom.equalTo(self).offset(-20)
        })
        socarZoneImageView.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-10)
            $0.width.equalTo(50)
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
