//
//  ReservationConfirmCustomCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/04.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

private let titleTextFontSize: CGFloat = 15
private let contentsTextFontSize: CGFloat = 13

class ReservationConfirmCustomCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "CustomCell"
  let padding: CGFloat = 10

  let sectionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "주행요금 130 ~ 170원 /km"
    label.font = .boldSystemFont(ofSize: titleTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let carDrivingCostInfoWebViewButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "questionmark.circle"), for: .normal)
    button.imageView?.tintColor = .darkGray
    return button
  }()
  
  let carDrivingCostInfoLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.text = "주행요금은 반납 후 등록하신 결제카드로 자동 결제됩니다.\n주행요금은 거리에 따라 구간별 차등 적용하여 계산됩니다."
    label.font = .systemFont(ofSize: contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let showCarDrivingCostInfoButton: UIButton = {
    let button = UIButton()
    button.setTitle("주행거리 별 상세 요금 보기", for: .normal)
    button.setTitleColor(.systemGray, for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: 13)
    return button
  }()
  
  let carDrivingCostInfoTextView: UITextView = {
    let textView = UITextView()
    textView.text = """
    - 주행거리 30km 이하: (km 당 주행요금) 170원
    - 주행거리 30 초과 ~ 100km 이하: (km 당 주행요금)
    - 주행거리 100km 초과: (km 당 주행요금) 130원
    """
    textView.font = .systemFont(ofSize: contentsTextFontSize)
    textView.textColor = .systemGray
    return textView
  }()
  
//  let sectionTitleLabel: UILabel = {
//    let label = UILabel()
//    label.text = "이용시간"
//    label.font = .boldSystemFont(ofSize: 15)
//    return label
//  }()
  
  let sectionSubtitleLabel: UILabel = {
    let label = UILabel()
    label.text = "라이트"
    label.font = .systemFont(ofSize: 13)
    return label
  }()
  
  let contentsLabel: UILabel = {
    let label = UILabel()
    label.text = "자기 부담금 최대 60 만원"
    label.font = .boldSystemFont(ofSize: 13)
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .white
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
    let guide = contentView.layoutMarginsGuide
    configureSectionTitle(guide)
    
    configureCarDriverCosrUI(guide)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureSectionTitle(_ guide: UILayoutGuide) {
    contentView.addSubview(sectionTitleLabel)
    sectionTitleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
  }
  
  private func configureCarDriverCosrUI(_ guide: UILayoutGuide) {
      [sectionTitleLabel, carDrivingCostInfoWebViewButton, carDrivingCostInfoLabel,
       showCarDrivingCostInfoButton, carDrivingCostInfoTextView].forEach {
        contentView.addSubview($0)
      }
      
      sectionTitleLabel.snp.makeConstraints {
        $0.top.equalTo(guide).offset(padding)
        $0.leading.equalTo(guide)
      }
      
      carDrivingCostInfoWebViewButton.snp.makeConstraints {
        $0.centerY.equalTo(sectionTitleLabel.snp.centerY)
        $0.trailing.equalTo(guide)
      }
      
      carDrivingCostInfoLabel.snp.makeConstraints {
        $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(padding)
        $0.leading.trailing.equalTo(guide)
      }
      
      showCarDrivingCostInfoButton.snp.makeConstraints {
        $0.top.equalTo(carDrivingCostInfoLabel.snp.bottom).offset(padding)
        $0.trailing.equalTo(guide)
        $0.bottom.equalTo(guide)
      }
      
      carDrivingCostInfoTextView.snp.makeConstraints {
        $0.top.equalTo(showCarDrivingCostInfoButton.snp.bottom).offset(padding)
        $0.leading.trailing.equalTo(guide)
        $0.height.equalTo(0)
        $0.bottom.equalTo(guide)
      }
    }
  
}
