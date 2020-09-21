//
//  DetailSocarZoneInfoCell.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class DetailSocarZoneInfoCell: UITableViewCell {
  // MARK: - Properties
  static let identifier = "DetailSocarZoneCell"
  lazy var guide = contentView.layoutMarginsGuide
  let subTextColor = UIColor.systemGray2
  let padding: CGFloat = 20
  var socarZoneData: SocarZoneData?
  
  // MARK: - MainTitleCell Properties
  lazy var closeButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: CommonUI.SFSymbolKey.close.rawValue), for: .normal)
    button.imageView?.tintColor = .black
    return button
  }()
  
  let socarZoneTitleNameLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중..."
    label.font = .boldSystemFont(ofSize: 30)
    label.textColor = .black
    return label
  }()
  
  let rentPlaceMarkImageView: UIImageView = {
    let imageview = UIImageView()
    imageview.image = UIImage(named: "socarZoneMarker")
    imageview.tintColor = .systemGray2
    imageview.contentMode = .scaleAspectFit
    return imageview
  }()
  
  let socarZoneLocationLabel: UILabel = {
    let label = UILabel()
    label.text = "로딩중..."
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray4
    return label
  }()
  
  let showSocarZoneLocationInMapButton: UIButton = {
    let button = UIButton()
    button.setTitle("지도보기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    button.setTitleColor(.darkGray, for: .normal)
    button.backgroundColor = .white
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray6.cgColor
    return button
  }()
  
  let findSocarZoneHowToGoButton: UIButton = {
    let button = UIButton()
    button.setTitle("길찾기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    button.setTitleColor(.darkGray, for: .normal)
    button.backgroundColor = .white
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray6.cgColor
    return button
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.text = "주소"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray2
    return label
  }()
  
  let addressValeuLabel: UILabel = {
    let label = UILabel()
    label.text = "서울 송파구 송파동 129"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let detailAddressLabel: UILabel = {
    let label = UILabel()
    label.text = "주차장 상세 정보"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray2
    return label
  }()
  
  let detailAddressValeuLabel: UILabel = {
    let label = UILabel()
    label.text = "지상 4층"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let parkingTypeLabel: UILabel = {
    let label = UILabel()
    label.text = "주차장 타입"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray2
    return label
  }()
  
  let parkingTypeValeuLabel: UILabel = {
    let label = UILabel()
    label.text = "지상"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.backgroundColor = .systemGray6
    label.textAlignment = .center
    label.textColor = .darkGray
    return label
  }()
  
  let parkingUsableTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "주차장 운영시간"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray2
    return label
  }()
  
  let parkingUsableTimeValeuLabel: UILabel = {
    let label = UILabel()
    label.text = "24시간"
    label.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  // MARK: - Sub content Cell Properties
  let socarMenerTitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.text = "쏘카 이용 매너"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  let socarMenerContentLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 3
    label.text = """
    - 지정된 반납 장소에 주차선을 맞춰주세요.
    - 스레기는 쓰래기통에 버려주세요.
    - 쏘카는 절대 금연! 흡연 시 페널티가 부과될 수 있어요.
    """
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .black
    return label
  }()
  
  // MARK: - Detail Info Button Cell
  let showDetailInfoButton: UIButton = {
    let button = UIButton()
    button.setTitle("상세안내 더보기", for: .normal)
    button.titleLabel?.font = .systemFont(ofSize: CommonUI.titleTextFontSize)
    button.setTitleColor(.darkGray, for: .normal)
    button.backgroundColor = .white
    button.layer.borderWidth = 1
    button.layer.borderColor = UIColor.systemGray6.cgColor
    return button
  }()
  
  // MARK: - Life cycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureCellUI(cellType: DetailSocarZoneInfoCellType) {
    switch cellType {
    case .mainTitle:
      configureMainTitleCellUI()
      configureMainTitleCellContents()
    case .subTitle:
      configureSubTitleCellUI()
      configureSubTitleCellContents()
    case .detailInfoButton:
      configureDetailInfoCellUI()
      configureDetailInfoCellContents()
    }
  }
  
  // MARK: - Configure Cell UI
  private func configureMainTitleCellUI() {
    addSubview(closeButton)
    closeButton.snp.makeConstraints {
      $0.top.equalTo(self).offset(-30)
      $0.leading.equalTo(self).offset(10)
      $0.width.height.equalTo(30)
    }
    
    [socarZoneTitleNameLabel, rentPlaceMarkImageView, socarZoneLocationLabel, showSocarZoneLocationInMapButton, findSocarZoneHowToGoButton, addressLabel, addressValeuLabel, detailAddressLabel, detailAddressValeuLabel, parkingTypeLabel, parkingTypeValeuLabel, parkingUsableTimeLabel, parkingUsableTimeValeuLabel].forEach {
      contentView.addSubview($0)
    }
    
    socarZoneTitleNameLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    rentPlaceMarkImageView.snp.makeConstraints {
      $0.top.equalTo(socarZoneTitleNameLabel.snp.bottom)
      $0.leading.equalTo(guide)
      $0.width.height.equalTo(30)
    }
    
    socarZoneLocationLabel.snp.makeConstraints {
      $0.centerY.equalTo(rentPlaceMarkImageView)
      $0.leading.equalTo(rentPlaceMarkImageView.snp.trailing).offset(5)
    }
    
    showSocarZoneLocationInMapButton.snp.makeConstraints {
      $0.top.equalTo(socarZoneLocationLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.height.equalTo(60)
    }
    
    findSocarZoneHowToGoButton.snp.makeConstraints {
      $0.top.equalTo(showSocarZoneLocationInMapButton)
      $0.leading.equalTo(showSocarZoneLocationInMapButton.snp.trailing).offset(-1)
      $0.trailing.equalTo(guide)
      $0.width.equalTo(showSocarZoneLocationInMapButton).multipliedBy(1)
      $0.height.equalTo(showSocarZoneLocationInMapButton)
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalTo(showSocarZoneLocationInMapButton.snp.bottom).offset(padding*2)
      $0.leading.equalTo(guide)
      $0.width.equalTo(120)
    }
    
    addressValeuLabel.snp.makeConstraints {
      $0.top.equalTo(addressLabel)
      $0.leading.equalTo(addressLabel.snp.trailing).offset(padding)
    }
    
    detailAddressLabel.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.width.equalTo(addressLabel)
    }
    
    detailAddressValeuLabel.snp.makeConstraints {
      $0.top.equalTo(detailAddressLabel)
      $0.leading.equalTo(detailAddressLabel.snp.trailing).offset(padding)
    }
    
    parkingTypeLabel.snp.makeConstraints {
      $0.top.equalTo(detailAddressLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.width.equalTo(addressLabel)
    }
    
    parkingTypeValeuLabel.snp.makeConstraints {
      $0.top.equalTo(parkingTypeLabel)
      $0.leading.equalTo(parkingTypeLabel.snp.trailing).offset(padding)
      $0.width.equalTo((parkingTypeValeuLabel.text?.count ?? 0)*8+20)
      $0.height.equalTo(25)
    }
    
    parkingUsableTimeLabel.snp.makeConstraints {
      $0.top.equalTo(parkingTypeLabel.snp.bottom).offset(padding)
      $0.leading.equalTo(guide)
      $0.width.equalTo(addressLabel)
      $0.bottom.equalTo(guide).offset(-padding)
    }
    
    parkingUsableTimeValeuLabel.snp.makeConstraints {
      $0.top.equalTo(parkingUsableTimeLabel)
      $0.leading.equalTo(parkingUsableTimeLabel.snp.trailing).offset(padding)
    }
  }
  
  private func configureSubTitleCellUI() {
    
  }
  
  private func configureDetailInfoCellUI() {
    
  }
  
  // MARK: - configure Cell Contents
  
  private func configureMainTitleCellContents() {
    guard let socarZone = socarZoneData else { return }
    socarZoneTitleNameLabel.text = socarZone.name
//    socarZoneLocationLabel.text = socarZoneData
  }
  
  private func configureSubTitleCellContents() {
    
  }
  
  private func configureDetailInfoCellContents() {
    
  }
}
