//
//  reservationStateView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class ReservationStateView: UIScrollView {
  
  var reservationCarImageString: String? {
    didSet {
      self.reservationCarImage.loadImage(with: reservationCarImageString ?? "empty")
    }
  }
  
  var numberPlateString: String? {
    didSet {
      self.numberPlateLabel.text = numberPlateString
    }
  }
  
  var carTypeString: String? {
    didSet {
      carTypeLabel.text = carTypeString
    }
  }
  
  var carOilTypeString: String? {
    didSet {
      carOilTypeLabel.text = carOilTypeString
    }
  }
  
  // MARK: - Attribute
  
  lazy var leftNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      image: UIImage(systemName: CommonUI.SFSymbolKey.hamburger.rawValue),
      style: .plain,
      target: self,
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return barButtonItem
  }()
  
  lazy var rightNavigationButton: UIBarButtonItem = {
    let barButtonItem = UIBarButtonItem(
      title: "고객센터",
      style: .plain,
      target: self,
      action: #selector(didTapButton(_:))
    )
    barButtonItem.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return barButtonItem
  }()
  
  fileprivate let contentView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  let reservationCarImage: CustomImageView = {
    let imageView = CustomImageView()
    imageView.contentMode = .scaleAspectFit
    
    return imageView
  }()
  
  let numberPlateLabel: UILabel = {
    let label = UILabel()
    label.text = "57하4455"
    label.font = UIFont.preferredFont(forTextStyle: .title1)
    label.textColor = .white
    
    return label
  }()
  
  fileprivate let carInfomationButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return button
  }()
  
  let carTypeLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let firstDelimiterLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  let carOilTypeLabel: UILabel = {
    let label = UILabel()
    label.text = ""
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let secondDelimiterLabel: UILabel = {
    let label = UILabel()
    label.text = "|"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate let gasStationImage: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "GasStation")
    imageView.contentMode = .scaleAspectFit
    imageView.snp.makeConstraints { $0.width.height.equalTo(10) }
    imageView.alpha = 0.55
    
    return imageView
  }()
  
  fileprivate let carOilLevelLabel: UILabel = {
    let label = UILabel()
    label.text = "25%"
    label.font = UIFont.preferredFont(forTextStyle: .body)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  
  fileprivate lazy var carInfoAndOilStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        carTypeLabel,
        firstDelimiterLabel,
        carOilTypeLabel,
        secondDelimiterLabel,
        gasStationImage,
        carOilLevelLabel
      ]
    )
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.spacing = 10
    
    return stackView
  }()
  
  fileprivate let reservationRemainingTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 이용 10분 전"
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate let reservationTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "8/15 (토) 14:00"
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    label.textColor = CommonUI.mainBlue
    
    return label
  }()
  
  fileprivate lazy var reservationTimeStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        reservationRemainingTimeLabel,
        reservationTimeLabel
      ]
    )
    stackView.axis = .horizontal
    
    return stackView
  }()
  
  fileprivate lazy var reservationProgressView: UIProgressView = {
    let progressView = UIProgressView()
    progressView.progressTintColor = CommonUI.mainBlue
    progressView.trackTintColor = UIColor.white.withAlphaComponent(0.15)
    progressView.transform = CGAffineTransform(rotationAngle: .pi)
    progressView.progress = 0.3
    
    return progressView
  }()
  
  fileprivate let reservationCommentLabel: UILabel = {
    let label = UILabel()
    label.text = "곧 예약 시작 시간입니다."
    label.font = UIFont.preferredFont(forTextStyle: .title2)
    label.textColor = .white
    
    return label
  }()
  
  fileprivate let reservationStateView: UIView = {
    let view = UIView()
    
    return view
  }()
  // reservation
  let vehiclePictureViewButton: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.mainBlue
    view.layer.cornerRadius = 5
    //    view.isHidden = true
    
    return view
  }()
  fileprivate let reservationStateLabel: UILabel = {
    let label = UILabel()
    label.text = "차량 확인"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    
    return label
  }()
  fileprivate let reservationStateSubLabel: UILabel = {
    let label = UILabel()
    label.text = "사진을 등록해 주세요"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    
    return label
  }()
  fileprivate let reservationStatsWarningIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.warning.rawValue)
    imageView.tintColor = .yellow
    imageView.snp.makeConstraints { $0.width.height.equalTo(10) }
    
    return imageView
  }()
  fileprivate let reservationStateMessageLabel: UILabel = {
    let label = UILabel()
    label.text = "수리비 청구 받기 위해 필수 !!"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = .yellow
    
    return label
  }()
  
  fileprivate let reservationPlaceWrapView: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.mainDark
    view.layer.cornerRadius = 5
    //    view.isHidden = true
    
    return view
  }()
  fileprivate let reservationPlaceStateLabel: UILabel = {
    let label = UILabel()
    label.text = "대여 장소"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  fileprivate let reservationPlaceStateSubLabel: UILabel = {
    let label = UILabel()
    label.text = "송파동 공영주차장 지상 4층"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    label.alpha = 0.55
    
    return label
  }()
  fileprivate let reservationPlaceButton: UIButton = {
    let button = UIButton()
    button.setImage(
      UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue),
      for: .normal
    )
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    button.tintColor = UIColor.white.withAlphaComponent(0.55)
    
    return button
  }()
  
  fileprivate let returnStateView: UIView = {
    let view = UIView()
    view.isHidden = true
    view.backgroundColor = .clear
    
    return view
  }()
  let returnPlaceViewButton: UIView = {
    let view = UIView()
    view.backgroundColor = CommonUI.mainBlue
    view.layer.cornerRadius = 5
    //    view.isHidden = true
    
    return view
  }()
  fileprivate let returnPlaceTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "반납 장소"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    
    return label
  }()
  fileprivate let returnPlaceLabel: UILabel = {
    let label = UILabel()
    label.text = "송파구 공영주차장 지상 4층"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = .white
    
    return label
  }()
  
  fileprivate let returnTimeView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  fileprivate let returnTimeBorderView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    
    return view
  }()
  fileprivate let returnTimeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.time.rawValue)
    imageView.tintColor = UIColor.white.withAlphaComponent(0.55)
    imageView.snp.makeConstraints { $0.width.height.equalTo(20) }
    
    return imageView
  }()
  fileprivate let returnTimeTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "반납 시각"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.white.withAlphaComponent(0.55)
    
    return label
  }()
  fileprivate let returnTimeLabel: UILabel = {
    let label = UILabel()
    label.text = "8/15 (토) 14:00"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.white.withAlphaComponent(0.55)
    
    return label
  }()
  fileprivate let returnTimeDelayButton: UIButton = {
    let button = UIButton()
    button.setTitle("연장하기", for: .normal)
    button.setTitleColor(UIColor.white.withAlphaComponent(0.55), for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .subheadline)
    button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
    
    return button
  }()
  
  fileprivate let fillUpUseView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  fileprivate let fillUpUseBorderView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
    
    return view
  }()
  fileprivate let fillUpUseIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "GasStation")
    imageView.contentMode = .scaleAspectFit
    imageView.alpha = 0.55
    imageView.snp.makeConstraints { $0.width.height.equalTo(20) }
    
    return imageView
  }()
  fileprivate let fillUpUseLabel: UILabel = {
    let label = UILabel()
    label.text = "주유 방법 안내"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.white.withAlphaComponent(0.55)
    
    return label
  }()
  
  fileprivate let cancelFeeView: UIView = {
    let view = UIView()
    view.backgroundColor = .clear
    
    return view
  }()
  fileprivate let cancelFeeBorderView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
    
    return view
  }()
  fileprivate let cancelFeeIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: CommonUI.SFSymbolKey.warning.rawValue)
    imageView.tintColor = UIColor.white.withAlphaComponent(0.55)
    imageView.snp.makeConstraints { $0.width.height.equalTo(20) }
    
    return imageView
  }()
  fileprivate let cancelFeeLabel: UILabel = {
    let label = UILabel()
    label.text = "수수료 및 패널티 안내"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.white.withAlphaComponent(0.55)
    
    return label
  }()
  
  fileprivate let reservationDetail: UILabel = {
    let label = UILabel()
    label.text = "수수료 및 패널티 안내"
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = UIColor.white.withAlphaComponent(0.55)
    
    return label
  }()
  
  // MARK: - LifeCycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UI
  fileprivate func setUI() {
    self.contentSize = CGSize(width: self.frame.width, height: contentView.frame.height)
    
    setConstraints()
  }
  
  fileprivate func setConstraints() {
    let guid = contentView.safeAreaLayoutGuide
    self.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
    )
    self.addSubview(contentView)
    
    var heightPadding: CGFloat = 200
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    
    self.contentSize = .init(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+heightPadding-44)
    contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+heightPadding-144)
    
    if UserDefaults.getVehicleCheck() == true {
      reservationStateView.isHidden = true
      returnStateView.isHidden = false
    } else {
      reservationStateView.isHidden = false
      returnStateView.isHidden = true
    }
    
    [reservationCarImage, numberPlateLabel, carInfomationButton, carInfoAndOilStackView, reservationTimeStackView, reservationProgressView, reservationCommentLabel, reservationStateView, returnStateView].forEach {
      contentView.addSubview($0)
    }
    
    reservationCarImage.snp.makeConstraints {
      $0.top.equalTo(guid).offset(40)
      $0.centerX.equalTo(guid)
      $0.height.equalTo(130)
    }
    
    numberPlateLabel.snp.makeConstraints {
      $0.top.equalTo(reservationCarImage.snp.bottom)
      $0.centerX.equalTo(guid)
    }
    
    carInfomationButton.snp.makeConstraints {
      $0.top.equalTo(reservationCarImage.snp.bottom).offset(5)
      $0.leading.equalTo(numberPlateLabel.snp.trailing).offset(10)
    }
    
    carInfoAndOilStackView.snp.makeConstraints {
      $0.top.equalTo(numberPlateLabel.snp.bottom).offset(10)
      $0.centerX.equalTo(guid)
    }
    
    reservationTimeStackView.snp.makeConstraints {
      $0.top.equalTo(carInfoAndOilStackView.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(30)
      $0.trailing.equalTo(guid).offset(-30)
    }
    
    reservationProgressView.snp.makeConstraints {
      $0.top.equalTo(reservationTimeStackView.snp.bottom).offset(10)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid)
    }
    
    reservationCommentLabel.snp.makeConstraints {
      $0.top.equalTo(reservationProgressView.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(30)
    }
    
    reservationStateView.snp.makeConstraints {
      $0.top.equalTo(reservationCommentLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(240)
    }
    
    [vehiclePictureViewButton, reservationPlaceWrapView].forEach {
      reservationStateView.addSubview($0)
    }
    
    // vehiclePictureViewButton
    vehiclePictureViewButton.snp.makeConstraints {
      $0.top.equalTo(reservationCommentLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(120)
    }
    
    [reservationStateLabel, reservationStateSubLabel, reservationStatsWarningIcon, reservationStateMessageLabel].forEach {
      vehiclePictureViewButton.addSubview($0)
    }
    
    reservationStateLabel.snp.makeConstraints {
      $0.top.equalTo(vehiclePictureViewButton.snp.top).offset(30)
      $0.leading.equalTo(vehiclePictureViewButton.snp.leading).offset(20)
    }
    
    reservationStateSubLabel.snp.makeConstraints {
      $0.top.equalTo(vehiclePictureViewButton.snp.top).offset(30)
      $0.leading.equalTo(reservationStateLabel.snp.trailing).offset(20)
    }
    
    reservationStatsWarningIcon.snp.makeConstraints {
      $0.top.equalTo(reservationStateSubLabel.snp.bottom).offset(22.5)
      $0.leading.equalTo(reservationStateLabel.snp.trailing).offset(20)
    }
    
    reservationStateMessageLabel.snp.makeConstraints {
      $0.top.equalTo(reservationStateSubLabel.snp.bottom).offset(20)
      $0.leading.equalTo(reservationStatsWarningIcon.snp.trailing).offset(5)
    }
    // end vehiclePictureViewButton
    
    // reservationPlaceWrapView
    reservationPlaceWrapView.snp.makeConstraints {
      $0.top.equalTo(vehiclePictureViewButton.snp.bottom).offset(10)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(80)
    }
    
    [reservationPlaceStateLabel, reservationPlaceStateSubLabel, reservationPlaceButton].forEach {
      reservationPlaceWrapView.addSubview($0)
    }
    
    reservationPlaceStateLabel.snp.makeConstraints {
      $0.top.equalTo(reservationPlaceWrapView.snp.top).offset(30)
      $0.leading.equalTo(reservationPlaceWrapView.snp.leading).offset(20)
    }
    
    reservationPlaceStateSubLabel.snp.makeConstraints {
      $0.top.equalTo(reservationPlaceWrapView.snp.top).offset(30)
      $0.leading.equalTo(reservationPlaceStateLabel.snp.trailing).offset(20)
    }
    
    reservationPlaceButton.snp.makeConstraints {
      $0.top.equalTo(reservationPlaceWrapView.snp.top).offset(30)
      $0.leading.equalTo(reservationPlaceWrapView.snp.trailing).offset(-30)
    }
    
    returnStateView.snp.makeConstraints {
      $0.top.equalTo(reservationCommentLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(240)
    }
    
    [returnPlaceViewButton, returnTimeView, returnTimeBorderView, fillUpUseView, fillUpUseBorderView, cancelFeeView, cancelFeeBorderView, reservationDetail].forEach {
      returnStateView.addSubview($0)
    }
    
    returnPlaceViewButton.snp.makeConstraints {
      $0.top.equalTo(reservationCommentLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(80)
    }
    
    [returnPlaceTitleLabel, returnPlaceLabel].forEach {
      returnPlaceViewButton.addSubview($0)
    }
    
    returnPlaceTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.leading.equalToSuperview().offset(20)
    }
    
    returnPlaceLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(30)
      $0.leading.equalTo(returnPlaceTitleLabel.snp.trailing).offset(20)
    }
    
    returnTimeView.snp.makeConstraints {
      $0.top.equalTo(returnPlaceViewButton.snp.bottom)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(80)
    }
    
    returnTimeBorderView.snp.makeConstraints {
      $0.top.equalTo(returnTimeView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
    [returnTimeIcon, returnTimeTitleLabel, returnTimeLabel, returnTimeDelayButton].forEach {
      returnTimeView.addSubview($0)
    }
    
    returnTimeIcon.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    returnTimeTitleLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(returnTimeIcon.snp.trailing).offset(15)
    }
    
    returnTimeLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(returnTimeTitleLabel.snp.trailing).offset(15)
    }
    
    returnTimeDelayButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview()
    }
    
    fillUpUseView.snp.makeConstraints {
      $0.top.equalTo(returnTimeBorderView.snp.bottom)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(80)
    }
    
    fillUpUseBorderView.snp.makeConstraints {
      $0.top.equalTo(fillUpUseView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
    [fillUpUseIcon, fillUpUseLabel].forEach {
      fillUpUseView.addSubview($0)
    }
    
    fillUpUseIcon.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    fillUpUseLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(fillUpUseIcon.snp.trailing).offset(15)
    }
    
    cancelFeeView.snp.makeConstraints {
      $0.top.equalTo(fillUpUseBorderView.snp.bottom)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
      $0.height.equalTo(80)
    }
    
    cancelFeeBorderView.snp.makeConstraints {
      $0.top.equalTo(cancelFeeView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(0.5)
    }
    
    [cancelFeeIcon, cancelFeeLabel].forEach {
      cancelFeeView.addSubview($0)
    }
    
    cancelFeeIcon.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(15)
    }
    
    cancelFeeLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalTo(cancelFeeIcon.snp.trailing).offset(15)
    }
    
    reservationDetail.snp.makeConstraints {
      $0.top.equalTo(cancelFeeBorderView.snp.bottom).offset(40)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    switch sender {
    case leftNavigationButton:
      print("lef navigation button press")
    case rightNavigationButton:
      print("right navigation button press")
    case carInfomationButton:
      print("right chevron button press")
    case reservationPlaceButton:
      print("reservation place button")
    default:
      print("error")
    }
  }
}
