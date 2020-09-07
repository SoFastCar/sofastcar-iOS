//
//  CarListView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/27.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class CarListView: UIView {
    
    let parkingLotInfoButton = UIButton()
    let setDateButton = UIButton()
    let stackView = UIStackView()
    let carListTableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        // to be moved to MainVC
//        carListTableView.delegate = self
//        carListTableView.dataSource = self
        carListTableView.bounces = false
        
        let visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.frame
        self.addSubview(visualEffectView)
        
        self.addSubview(carListTableView)
    }
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.snp.makeConstraints({
            $0.top.equalTo(self)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
        })
        carListTableView.translatesAutoresizingMaskIntoConstraints = false
        carListTableView.snp.makeConstraints({
            $0.top.equalTo(stackView.snp.bottom)
            $0.leading.equalTo(self)
            $0.trailing.equalTo(self)
            $0.bottom.equalTo(self)
        })
    }
}

// to be moved to MainVC
//extension CarListView: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        30
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//
//}
//
//extension CarListView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        80
//    }
//}
