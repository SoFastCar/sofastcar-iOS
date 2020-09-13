//
//  RentReturnTimeButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

public enum TimeType {
    case rentT
    case returnT
}

class RentReturnTimeButton: UIButton {
    
    let timeTypeLabel = UILabel()
    let timeLabel = UILabel()
    let symbolImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(buttonType type: TimeType) {
        self.init()
        setupUI(buttonType: type)
        setupConstraint()
    }
    
    func setupUI(buttonType type: TimeType) {
        switch type {
        case .rentT:
            timeTypeLabel.text = "대여 시각"
        case .returnT:
            timeTypeLabel.text = "반납 시각"
        }
        timeTypeLabel.font = .systemFont(ofSize: 15, weight: .regular)
        timeTypeLabel.textColor = .lightGray
        self.addSubview(timeTypeLabel)
        
        timeLabel.text = "오늘 18:00"
        timeLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        timeLabel.textColor = CommonUI.mainDark
        self.addSubview(timeLabel)
        
        symbolImageView.image = UIImage(systemName: "chevron.down", withConfiguration: self.symbolConfiguration(pointSize: 15, weight: .regular))
        self.addSubview(symbolImageView)
    }
    
    func setupConstraint() {
        [timeTypeLabel, timeLabel, symbolImageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        timeTypeLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        })
        
        timeLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(symbolImageView.snp.leading)
        })
        
        symbolImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        })
    }
    
    func setupTime(with time: String) {
        titleLabel?.text = time
    }
}
