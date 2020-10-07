//
//  RentHistoryCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class RentHistoryCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "RentHistoryCell"
//  var reservaion: Reservation?
//  var socarZone: SocarZoneData?
  lazy var guide = contentView.layoutMarginsGuide
  
  let reservationStatueLabel: UIButton = {
    let button = UIButton()
    button.setTitle("운행중", for: .normal)
    button.setTitle("반납완료", for: .selected)
    button.setTitleColor(.systemGray5, for: .normal)
    button.setTitleColor(.darkGray, for: .selected)
    button.titleLabel?.font = .systemFont(ofSize: 15)
    button.layer.cornerRadius = 3
    button.isSelected = true
    button.isUserInteractionEnabled = false
    button.backgroundColor = .systemGray5
    return button
  }()
  
  let drivingTotalDistanceLabel: UILabel = {
    let label = UILabel()
    label.text = "170km"
    label.textColor = .darkGray
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let carImage: CustomImageView = {
    let imageview = CustomImageView()
//    imageview.loadImage(with: <#T##String#>)
    imageview.image = UIImage(named: "testCar")
    return imageview
  }()
  
  let carNumber: UILabel = {
    let label = UILabel()
    label.text = "57하4455"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  let carName: UILabel = {
    let label = UILabel()
    label.text = "더뉴레이"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    label.textAlignment = .center
    return label
  }()
  
  let rentPlaceMarkImageView: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "socarZoneMarker")
    imageview.tintColor = CommonUI.mainBlue
    imageview.contentMode = .scaleAspectFit
    return imageview
  }()
  
  let rentPlaceTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "송파동 공영주차장"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let returnPlaceMarkImageView: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "socarZoneMarker")
    imageview.tintColor = .blue
    imageview.contentMode = .scaleAspectFit
    return imageview
  }()
  
  let returnPlaceTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "송파동 공영주차장"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let rentDurtaionLabel: UILabel = {
    let label = UILabel()
    label.text = "8/14 (금) 14:00 - 8/15 (토) 14:00"
    label.font = .systemFont(ofSize: 12)
    label.textColor = .black
    return label
  }()
  
  // MARK: - Properties
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    contentView.backgroundColor = .white
    configureLayout()
    configureContentViewTopBottomLayer()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureLayout() {
    [reservationStatueLabel, drivingTotalDistanceLabel, carImage, carName, carNumber, rentPlaceMarkImageView,
     rentPlaceTitleLabel, returnPlaceMarkImageView, returnPlaceTitleLabel, rentDurtaionLabel].forEach {
      contentView.addSubview($0)
     }
    
    reservationStatueLabel.snp.makeConstraints {
      $0.top.left.equalTo(guide)
      $0.width.equalTo(60)
      $0.height.equalTo(30)
    }
    
    drivingTotalDistanceLabel.snp.makeConstraints {
      $0.centerY.equalTo(reservationStatueLabel.snp.centerY)
      $0.trailing.equalTo(guide)
    }
    
    carImage.snp.makeConstraints {
      $0.top.equalTo(reservationStatueLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide).offset(20)
      $0.width.equalTo(90)
      $0.height.equalTo(60)
    }
    
    carNumber.snp.makeConstraints {
      $0.top.equalTo(carImage.snp.bottom)
      $0.leading.trailing.equalTo(carImage)
      $0.height.equalTo(30)
    }
    
    carName.snp.makeConstraints {
      $0.top.equalTo(carNumber.snp.bottom)
      $0.leading.trailing.equalTo(carImage)
      $0.bottom.equalTo(guide)
      $0.height.equalTo(30)
    }
    
    rentPlaceMarkImageView.snp.makeConstraints {
      $0.top.equalTo(carImage)
      $0.leading.equalTo(carName.snp.trailing).offset(20)
      $0.height.width.equalTo(30)
    }
    
    rentPlaceTitleLabel.snp.makeConstraints {
      $0.centerY.equalTo(rentPlaceMarkImageView)
      $0.leading.equalTo(rentPlaceMarkImageView.snp.trailing).offset(5)
    }
    
    returnPlaceMarkImageView.snp.makeConstraints {
      $0.top.equalTo(rentPlaceTitleLabel.snp.bottom).offset(5)
      $0.leading.equalTo(carName.snp.trailing).offset(20)
      $0.height.width.equalTo(30)
    }
    
    returnPlaceTitleLabel.snp.makeConstraints {
      $0.centerY.equalTo(returnPlaceMarkImageView)
      $0.leading.equalTo(returnPlaceMarkImageView.snp.trailing).offset(5)
    }
    
    rentDurtaionLabel.snp.makeConstraints {
      $0.top.equalTo(returnPlaceTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(rentPlaceMarkImageView).offset(3)
    } 
  }
  
  func configureContent(reservation: Reservation, socarZone: SocarZoneData) {
//    guard let reservation = reservaion else { return }
//    guard let socarZone = socarZone else { return }
    
    rentPlaceTitleLabel.text = socarZone.name
    returnPlaceTitleLabel.text = socarZone.name
    
  }
}
