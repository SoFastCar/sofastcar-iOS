//
//  AxaButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/09.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class AxaButton: UIButton {
    
    let specialImageView = UIImageView()
    let specialDiscriptionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        specialImageView.image = UIImage(named: "axaLogo")
        self.addSubview(specialImageView)
        
        specialDiscriptionLabel.text = "AXA 운전자보험 포함"
        specialDiscriptionLabel.font = .systemFont(ofSize: 12, weight: .regular)
        self.addSubview(specialDiscriptionLabel)
    }
    
    private func setupConstraint() {
        [specialDiscriptionLabel, specialImageView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        
        specialImageView.snp.makeConstraints({
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self)
            $0.width.equalTo(20)
            $0.height.equalTo(20)
        })
        
        specialDiscriptionLabel.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(specialImageView.snp.trailing).offset(5)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
        
    }
    
}
