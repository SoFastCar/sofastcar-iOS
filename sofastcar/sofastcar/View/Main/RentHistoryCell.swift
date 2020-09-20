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
  
  let statusLabel: UILabel = {
    let label = UILabel()
    label.text = "운행중.."
    label.backgroundColor = .systemGray4
    label.textColor = .systemGray
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let drivingTotalDistance: UILabel = {
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
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize+3)
    label.textColor = .black
    return label
  }()
  
  let carName: UILabel = {
    let label = UILabel()
    label.text = "더뉴레이"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
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
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
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
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let rentDurtaionLabel: UILabel = {
    let label = UILabel()
    label.text = "8/14 (금) 14:00 - 8/15 (토) 14:00"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
