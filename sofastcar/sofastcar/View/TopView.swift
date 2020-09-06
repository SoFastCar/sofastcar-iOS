//
//  TopSearchView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class TopView: UIView {
    
//    var shadowLayout: CAShapeLayer!
    let shadowContainer = UIView()
    let stackView = UIStackView()
    let sideBarButton = UIButton()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        if shadowLayout == nil {
//            shadowLayout = CAShapeLayer()
//            shadowLayout.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
//            shadowLayout.fillColor = UIColor.black.cgColor
//            shadowLayout.shadowColor = UIColor.black.cgColor
//            shadowLayout.shadowOffset = CGSize(width: 0, height: 1)
//            shadowLayout.shadowPath = shadowLayout.path
//            shadowLayout.shadowOpacity = 0.5
//            shadowLayout.shadowRadius = 3
//            
//            layer.insertSublayer(shadowLayout, at: 0)
//        }
//    }
    
    private func setupUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        
        shadowContainer.layer.cornerRadius = 5
        shadowContainer.clipsToBounds = true
        self.addSubview(shadowContainer)
        
        sideBarButton.backgroundColor = .systemGreen
//        sideBarButton.setImage(UIImage(named: "icons8-menu-24"), for: .normal)
        sideBarButton.setImage(UIImage(systemName: "flame"), for: .normal)
//        sideBarButton.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        sideBarButton.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        stackView.addArrangedSubview(sideBarButton)
        
        searchButton.backgroundColor = .white
        searchButton.titleLabel?.textAlignment = .center
//        searchButton.setTitle("주소가 들어감", for: .normal) // 네이버 Reverse Geocoding 완성 시 삭제
        searchButton.setTitleColor(.systemGray, for: .normal)
        searchButton.tintColor = .systemBlue
        stackView.addArrangedSubview(searchButton)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        shadowContainer.addSubview(stackView)
//        self.addSubview(stackView)
    }
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
    }
}
