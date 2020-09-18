//
//  SearchCustomButton.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SearchCustomButton: UIButton {

//    let stackView = UIStackView()
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
//        circleImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 0), for: .horizontal)
//        circleImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 0), for: .vertical)
        circleImageView.contentMode = .scaleAspectFill
//        circleImageView.frame.size = CGSize(width: 10, height: 10)
        circleImageView.image = UIImage(named: "callPointMarker-circle")
//        stackView.addArrangedSubview(circleImageView)
        self.addSubview(circleImageView)
        
        addrLabel.text = "주소 출력"
        addrLabel.font = .systemFont(ofSize: CommonUI.titleTextFontSize, weight: .regular)
        addrLabel.textColor = CommonUI.mainDark
//        stackView.addArrangedSubview(addrLabel)
        self.addSubview(addrLabel)
        
//        stackView.axis = .horizontal
//        stackView.distribution = .fillProportionally
//        self.addSubview(stackView)
    }
    
    func setupConstraint() {
//        stackView.snp.makeConstraints({
//            $0.centerX.centerY.equalToSuperview()
//        })
        circleImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(addrLabel.snp.leading).offset(-5)
            $0.width.height.equalTo(25)
        })
        
        addrLabel.snp.makeConstraints({
            $0.centerX.centerY.equalToSuperview()
        })
    }
    
}
