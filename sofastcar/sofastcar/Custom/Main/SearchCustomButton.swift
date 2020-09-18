//
//  SearchCustomButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SearchCustomButton: UIButton {

    let circleImageView = UIImageView()
    let addrLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        circleImageView.contentMode = .scaleAspectFill
        circleImageView.image = UIImage(named: "callPointMarker-circle")
        self.addSubview(circleImageView)
        
        addrLabel.text = "주소 출력"
        addrLabel.font = .systemFont(ofSize: CommonUI.titleTextFontSize, weight: .regular)
        addrLabel.textColor = CommonUI.mainDark
        self.addSubview(addrLabel)
        
    }
    
    func setupConstraint() {
        circleImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(addrLabel.snp.leading).offset(-5)
            $0.width.height.equalTo(25)
        })
        
        addrLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview().offset(9)
        })
    }
    
}
