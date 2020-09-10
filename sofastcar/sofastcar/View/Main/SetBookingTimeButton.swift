//
//  SetBookingTimeButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/10.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SetBookingTimeButton: UIButton {

    let symbolConfig = UIImage.SymbolConfiguration(pointSize: 20)
    let clockSymbolImageView = UIImageView()
    let setTimeLabel = UILabel()
    let timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        setupTime(with: "오늘 16:30")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .white
//        self.layer.borderColor = UIColor.systemGray6.cgColor
//        self.layer.borderWidth = 1
        
        clockSymbolImageView.tintColor = CommonUI.mainBlue
        clockSymbolImageView.image = UIImage(systemName: "clock", withConfiguration: symbolConfig)
        self.addSubview(clockSymbolImageView)
        
        setTimeLabel.text = "이용시간 설정하기"
        setTimeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        self.addSubview(setTimeLabel)
        
        timeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        timeLabel.textColor = .gray
        self.addSubview(timeLabel)
        
//        self.layer.addBorder(toSide: .top, withColor: UIColor.lightGray.cgColor, andThickness: 5)
//        self.layer.addBorder(toSide: .bottom, withColor: UIColor.lightGray.cgColor, andThickness: 5)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("1")
        self.addBorder(toSide: .top, withColor: UIColor.lightGray.cgColor, andThickness: 5)
        self.addBorder(toSide: .bottom, withColor: UIColor.lightGray.cgColor, andThickness: 5)
    }
    
    private func setupConstraint() {
        [clockSymbolImageView, setTimeLabel, timeLabel].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        clockSymbolImageView.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(20)
        })
        
        setTimeLabel.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.leading.equalTo(clockSymbolImageView.snp.trailing).offset(10)
        })
        
        timeLabel.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-20)
        })
    }
    
    func setupTime(with time: String?) {
        timeLabel.text = time ?? "설정된 시간 없음"
    }
}
