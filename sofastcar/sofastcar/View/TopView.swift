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
    
    private func setupUI() {
        sideBarButton.setImage(UIImage(systemName: "flame.fill"), for: .normal)
        sideBarButton.backgroundColor = .systemYellow
        stackView.addArrangedSubview(sideBarButton)
        
        searchButton.setTitle("주소가 들어감", for: .normal)
        searchButton.backgroundColor = .systemOrange
        stackView.addArrangedSubview(searchButton)
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        self.addSubview(stackView)
    }
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
    }
}
