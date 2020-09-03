//
//  CarListTableViewHeader.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListTableViewHeader: UITableViewHeaderFooterView {

    static let identifier = "CarListTableViewHeader"
    
    let stackView = UIStackView()
    let parkingLotInfoButton = UIButton()
    let setDateButton = UIButton()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        parkingLotInfoButton.setTitle("주차장 정보", for: .normal)
        parkingLotInfoButton.backgroundColor = .systemRed
        stackView.addArrangedSubview(parkingLotInfoButton)
        
        setDateButton.setTitle("예약일 변경", for: .normal)
        setDateButton.backgroundColor = .systemBlue
        stackView.addArrangedSubview(setDateButton)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
