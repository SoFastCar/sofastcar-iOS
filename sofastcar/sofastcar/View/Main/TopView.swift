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
    
    let shadowContainer = UIView()
    let sideBarButton = UIButton()
//    let searchButton = UIButton()
    let searchButton = SearchCustomButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        
        shadowContainer.layer.cornerRadius = 5
        shadowContainer.clipsToBounds = true
        self.addSubview(shadowContainer)
        
//        searchButton.imageView?.contentMode = .scaleAspectFit
//        searchButton.imageView?.backgroundColor = .red
//        searchButton.imageView?.frame.size = CGSize(width: 10, height: 10)
//        searchButton.imageView?.clipsToBounds = true
//        searchButton.setImage(UIImage(named: "callPointMarker-circle"), for: .normal)
//        searchButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 20), forImageIn: .normal)
//        searchButton.titleLabel?.textAlignment = .center
//        searchButton.setTitleColor(.systemGray, for: .normal)
//        searchButton.tintColor = .systemBlue
        searchButton.backgroundColor = .white
        shadowContainer.addSubview(searchButton)
        
        sideBarButton.backgroundColor = .white
        sideBarButton.setImage(UIImage(systemName: "text.justify"), for: .normal)
        sideBarButton.setContentCompressionResistancePriority(UILayoutPriority(751), for: .horizontal)
        sideBarButton.tintColor = CommonUI.mainDark
        searchButton.addSubview(sideBarButton)
    }
    
    private func setupConstraint() {
        shadowContainer.translatesAutoresizingMaskIntoConstraints = false
        shadowContainer.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
        
        searchButton.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        
        sideBarButton.snp.makeConstraints({
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(20)
        })
    }
}
