//
//  VehicleTakePictureView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class VehicleTakePictureView: UIScrollView {
  
  fileprivate let contentView: UIView = {
    let view = UIView()
    
    return view
  }()
  
  fileprivate let descriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량의 여섯 면을 가이드에 맞춰 촬영해주세요.\n사진 전송 후에는 수정할 수 없습니다."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
    return label
  }()
  
  fileprivate let vehicleTakePictureMenuView: VehicleTakePictureMenuView = {
    let view = VehicleTakePictureMenuView()
    
    return view
  }()
  
  fileprivate let vehicleTakePictureFrontView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "전면"
    view.vehiclePositionString = "전면"
    
    return view
  }()
  
  fileprivate let vehicleTakePicturePassengerFrontSeatView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "보조석앞면"
    view.vehiclePositionString = "보조석 앞면"
    
    return view
  }()
  
  fileprivate let vehicleTakePicturePassengerBackSeatView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "보조석뒷면"
    view.vehiclePositionString = "보조석 뒷면"
    
    return view
  }()
  
  fileprivate let vehicleTakePictureBackView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "후면"
    view.vehiclePositionString = "후면"
    
    return view
  }()
  
  fileprivate let vehicleTakePictureDriveBackSeatView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "운전석뒷면"
    view.vehiclePositionString = "운전석 뒷면"
    
    return view
  }()
  
  fileprivate let vehicleTakePictureDriveFrontSeatView: VehicleTakePictureImageView = {
    let view = VehicleTakePictureImageView()
    view.vehicleImageStirng = "운전석앞면"
    view.vehiclePositionString = "운전석 앞면"
    
    return view
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
    
    setScrollView()
    setConstraints()
  }

  fileprivate func setScrollView() {
    
    self.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height
    )
    
    [contentView].forEach {
      self.addSubview($0)
    }
    
    var heightPadding: CGFloat = 1200
    if UIScreen.main.bounds.height < 670 {
      heightPadding = UIScreen.main.bounds.height * 0.2
    }
    
    self.contentSize = .init(
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 44
    )
    
    contentView.frame = CGRect(
      x: 0,
      y: 0,
      width: UIScreen.main.bounds.width,
      height: UIScreen.main.bounds.height + heightPadding - 144
    )
  }
  
  fileprivate func setConstraints() {
//    let guid = contentView.safeAreaLayoutGuide
    
    [descriptionLabel, vehicleTakePictureMenuView, vehicleTakePictureFrontView, vehicleTakePicturePassengerFrontSeatView, vehicleTakePicturePassengerBackSeatView, vehicleTakePictureBackView, vehicleTakePictureDriveBackSeatView, vehicleTakePictureDriveFrontSeatView].forEach {
      contentView.addSubview($0)
    }
    
    descriptionLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview().offset(20)
    }
    
    vehicleTakePictureMenuView.snp.makeConstraints {
      $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(60)
    }
    
    vehicleTakePictureFrontView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePictureMenuView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
    
    vehicleTakePicturePassengerFrontSeatView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePictureFrontView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
    
    vehicleTakePicturePassengerBackSeatView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePicturePassengerFrontSeatView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
    
    vehicleTakePictureBackView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePicturePassengerBackSeatView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
    
    vehicleTakePictureDriveBackSeatView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePictureBackView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
    
    vehicleTakePictureDriveFrontSeatView.snp.makeConstraints {
      $0.top.equalTo(vehicleTakePictureDriveBackSeatView.snp.bottom).offset(20)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(275)
    }
  }
  
  // MARK: - Action
  
  @objc func buttonAction(_ sender: UIButton) {
    print("\(sender) button press")
  }
}
