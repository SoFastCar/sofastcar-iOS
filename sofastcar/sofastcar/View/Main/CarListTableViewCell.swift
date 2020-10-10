//
//  CarListTableViewCell.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Kingfisher

class CarListTableViewCell: UITableViewCell {
    let carImageView = UIImageView()
    let carNameLabel = UILabel()
    let carPriceLabel = UILabel()
    let discountSignLabel = UILabel()
    let availableTimeSlotView = UIView()
    let timeSlotUnitView = UIView()
    let dateStackView = UIStackView()
    let firstDateLabel = UILabel()
    let middleDateLabel = UILabel()
    let lastDateLabel = UILabel()
    let blockView = UIView()
    let numberFormatter = NumberFormatter()
    let dateFormatter = DateFormatter()
    var calendar = Calendar.current

    static let identifier = "CarListCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    private func setupUI() {
        numberFormatter.numberStyle = .decimal
        
        calendar.locale = Locale(identifier: "ko-KR")
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        carImageView.contentMode = .scaleAspectFit
        contentView.addSubview(carImageView)
        
        carNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        carNameLabel.textColor = .gray
        contentView.addSubview(carNameLabel)
        
        carPriceLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        carNameLabel.textColor = .black
        contentView.addSubview(carPriceLabel)
        
        discountSignLabel.font = .systemFont(ofSize: 11, weight: .thin)
        discountSignLabel.textColor = CommonUI.mainBlue
        contentView.addSubview(discountSignLabel)
        
        availableTimeSlotView.layer.borderWidth = 0.3
        availableTimeSlotView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(availableTimeSlotView)
        
        timeSlotUnitView.backgroundColor = CommonUI.mainBlue
        availableTimeSlotView.addSubview(timeSlotUnitView)
        
        dateStackView.axis = .horizontal
        dateStackView.distribution = .equalCentering
        [firstDateLabel, middleDateLabel, lastDateLabel].forEach({
            $0.font = .systemFont(ofSize: 10, weight: .regular)
            self.dateStackView.addArrangedSubview($0)
        })
        contentView.addSubview(dateStackView)
        
        contentView.addSubview(blockView)
    }
    
    private func setupConstraint() {
        [carImageView, carNameLabel, carPriceLabel, discountSignLabel, availableTimeSlotView,
         timeSlotUnitView, dateStackView, firstDateLabel, middleDateLabel, lastDateLabel, blockView].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false   
        })
        carImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(-15)
            $0.leading.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(55)
        })
        carNameLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(-28)
            $0.leading.equalTo(carImageView.snp.trailing).offset(10)
        })
        carPriceLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(-5)
            $0.leading.equalTo(carImageView.snp.trailing).offset(10)
        })
        discountSignLabel.snp.makeConstraints({
            $0.centerY.equalTo(carPriceLabel)
            $0.leading.equalTo(carPriceLabel.snp.trailing).offset(5)
        })
        availableTimeSlotView.snp.makeConstraints({
            $0.centerY.equalToSuperview().offset(30)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(4)
        })
        timeSlotUnitView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(100)
            $0.trailing.equalToSuperview().offset(-100)
            $0.bottom.equalToSuperview()
        })
        dateStackView.snp.makeConstraints({
            $0.top.equalTo(availableTimeSlotView.snp.bottom).offset(5)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(10)
        })
        blockView.snp.makeConstraints({
            $0.top.bottom.leading.trailing.equalToSuperview()
        })
    }
    
    func carInfoConfiguration(carImage image: String, carName name: String, carPrice price: Int, availableDiscount discount: Bool) {
        let url = URL(string: image)
        carImageView.kf.setImage(with: url)
        carNameLabel.text = name
        carPriceLabel.text = numberFormatter.string(from: NSNumber(value: price))
        discountSignLabel.text = discount ? "할인가" : ""
    }
    
    func timeInfoConfiguration(listIndex index: Int, startTime sTime: Date, endTime eTime: Date, reserveStartTime rsTime: [Date], reserveEndTime reTime: [Date]) {
        if rsTime.count != 0 {
            for index in 0...(rsTime.count - 1) {
                if rsTime[index] > sTime || reTime[index] < eTime {
                    print("겹침")
                    
                } else {
                    print("안겹침")
                }
            }
        } else {
            
        }
//        var reserveDict: [Date: Date] = [:]
//        var reserveDictArry: [[Date: Date]] = [[:]]
//        print(rsTime, rsTime.count)
//        if rsTime.count != 0 {
//            for index in 0...(rsTime.count - 1) {
//                let dateTimeStart = Time.toUTCString(changeForString: rsTime[index].dateTimeStart)
//                let dateTimeEnd = Time.toUTCString(changeForString: rsTime[index].dateTimeEnd)
//                reserveDict[dateTimeStart] = dateTimeEnd
//            }
//            reserveDictArry.append(reserveDict)
//        } else {
////            reserveDictArry.append([:])
//            // do nothing
//        }
//        print(reserveDictArry)
////        Time.toUTCString(changeForString: <#T##String#>)

        var startDateOfTimeSlot = sTime
        var endDateOfTimeSlot = Date(timeInterval: 86400, since: eTime)
        startDateOfTimeSlot = calendar.startOfDay(for: startDateOfTimeSlot)
        endDateOfTimeSlot = calendar.startOfDay(for: endDateOfTimeSlot)
        
        let timeSlotPeriodByDate = calendar.dateComponents([.second], from: startDateOfTimeSlot, to: endDateOfTimeSlot)
        let timeSlotPeriod = CGFloat(timeSlotPeriodByDate.second ?? 1)
        let rentalPeriodByDate = calendar.dateComponents([.second], from: sTime, to: eTime)
        let rentalPeriod = CGFloat(rentalPeriodByDate.second ?? 1)
        let leadingPeriodByDate = calendar.dateComponents([.second], from: startDateOfTimeSlot, to: sTime)
        let leadingPeriod = CGFloat(leadingPeriodByDate.second ?? 1)
        let trailingPeriodByDate = calendar.dateComponents([.second], from: eTime, to: endDateOfTimeSlot)
        let trailingPeriod = CGFloat(trailingPeriodByDate.second ?? 1)
        
        let middleDate = Date(timeInterval: TimeInterval(timeSlotPeriod / 2), since: startDateOfTimeSlot)
        let newLeadingConst = (UIScreen.main.bounds.width - 40) * (leadingPeriod / timeSlotPeriod)
        let newTrailingConst = (UIScreen.main.bounds.width - 40) * (trailingPeriod / timeSlotPeriod)
//        print("slot width: \(availableTimeSlotView.frame.width), newLeading: \(newLeadingConst), newTrailing: \(newTrailingConst)")
        timeSlotUnitView.snp.updateConstraints({
            $0.leading.equalToSuperview().offset(newLeadingConst)
            $0.trailing.equalToSuperview().offset(-newTrailingConst)
        })
        firstDateLabel.text = Time.getTimeString(type: .castMMd, date: startDateOfTimeSlot)
        lastDateLabel.text = Time.getTimeString(type: .castMMd, date: endDateOfTimeSlot)
        if timeSlotPeriod <= 86400 {
            middleDateLabel.text = "12:00" 
        } else {
            middleDateLabel.text = Time.getTimeString(type: .castMMd, date: middleDate)
        }
    }
}
