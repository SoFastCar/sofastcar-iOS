//
//  BookingTimeView.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class BookingTimeView: UIView {

    var tapRentButtonFlag = false
    var tapReturnButtonFlag = false
    let dismissButton = UIButton()
    let titleLabel = UILabel()
    let bookingTimeLabel = UILabel()
    let rentTimeButton = RentReturnTimeButton(buttonType: .rentT)
    let returnTimeButton = RentReturnTimeButton(buttonType: .returnT)
    let rentDatePicker = UIDatePicker()
    let returnDatePicker = UIDatePicker()
    let confirmButton = UIButton()
    let divider1 = UIView()
    let divider2 = UIView()
    let rentStackView = UIStackView()
    let returnStackView = UIStackView()
    let dayUnitButton = UIButton()
    let hourUnitButton = UIButton()
    let thirtyMinUnitButton = UIButton()
    let timeUnitStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .systemBackground
        
        dismissButton.setImage(UIImage(systemName: "multiply", withConfiguration: self.symbolConfiguration(pointSize: 20, weight: .regular)), for: .normal)
        self.addSubview(dismissButton)
        
        titleLabel.text = "이용시간 설정하기"
        self.addSubview(titleLabel)
        
        bookingTimeLabel.text = "오늘 18:00 - 21:00"
        self.addSubview(bookingTimeLabel)
        
        divider1.backgroundColor = .systemGray6
        rentStackView.addArrangedSubview(divider1)
        
        rentTimeButton.tag = 0
        rentStackView.addArrangedSubview(rentTimeButton)
        
        [rentDatePicker, returnDatePicker].forEach({
            $0.datePickerMode = .dateAndTime
            $0.locale = Locale(identifier: "ko-KR")
            $0.minuteInterval = 10
        })
        rentStackView.addArrangedSubview(rentDatePicker)
        
        rentStackView.axis = .vertical
        rentStackView.distribution = .fillProportionally
        self.addSubview(rentStackView)
        
        divider2.backgroundColor = .systemGray6
        returnStackView.addArrangedSubview(divider2)
        
        returnTimeButton.tag = 1
        returnTimeButton.backgroundColor = .white
        returnStackView.addArrangedSubview(returnTimeButton)
        
        dayUnitButton.setTitle("+1일", for: .normal)
        hourUnitButton.setTitle("+1시간", for: .normal)
        thirtyMinUnitButton.setTitle("+30분", for: .normal)
        [dayUnitButton, hourUnitButton, thirtyMinUnitButton].forEach({
            timeUnitStackView.addArrangedSubview($0)
//            $0.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
//            $0.titleLabel?.textColor = .lightGray
        })
        timeUnitStackView.axis = .horizontal
        timeUnitStackView.distribution = .fillEqually
        returnStackView.addArrangedSubview(timeUnitStackView)
        
        returnDatePicker.backgroundColor = .white
        returnStackView.addArrangedSubview(returnDatePicker)
        
        returnStackView.axis = .vertical
        returnStackView.distribution = .fillProportionally
        self.addSubview(returnStackView)
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.backgroundColor = CommonUI.mainBlue
        self.addSubview(confirmButton)
    }
    
    private func setupConstraint() {
        [dismissButton, titleLabel, bookingTimeLabel, rentTimeButton, returnTimeButton,
            rentDatePicker, returnDatePicker, confirmButton, divider1, divider2, rentStackView, returnStackView, timeUnitStackView].forEach({
                $0.translatesAutoresizingMaskIntoConstraints = false
            })
        dismissButton.snp.makeConstraints({
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(dismissButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        })
        bookingTimeLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        })
        divider1.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        })
        rentTimeButton.snp.makeConstraints({
            $0.top.equalTo(divider1.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        })
        rentDatePicker.snp.makeConstraints({
            $0.top.equalTo(rentTimeButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(0)
        })
        rentStackView.snp.makeConstraints({
            $0.top.equalTo(bookingTimeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        })
        divider2.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        })
        returnTimeButton.snp.makeConstraints({
            $0.top.equalTo(divider2.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(60)
        })
        timeUnitStackView.snp.makeConstraints({
            $0.top.equalTo(returnTimeButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(100)
        })
        returnDatePicker.snp.makeConstraints({
            $0.top.equalTo(timeUnitStackView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(100)
        })
        returnStackView.snp.makeConstraints({
            $0.top.equalTo(rentStackView.snp.bottom)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        })
        confirmButton.snp.makeConstraints({
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(15)
        })
    }
}
