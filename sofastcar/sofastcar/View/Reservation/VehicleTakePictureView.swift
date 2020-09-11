//
//  VehicleTakePictureView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

class VehicleTakePictureView: UIScrollView {

  fileprivate let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .cyan
    
    return view
  }()
  
  fileprivate let vehicleTakePicturDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "차량의 여섯 면을 가이드에 맞춰 촬영해주세요.\n사진 전송 후에는 수정할 수 없습니다."
    label.font = UIFont.preferredFont(forTextStyle: .callout)
    label.textColor = CommonUI.mainDark
    label.numberOfLines = .max
    
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
    self.addSubview(contentView)
    
    var heightPadding: CGFloat = 0
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
    let guid = contentView.safeAreaLayoutGuide
    
    [vehicleTakePicturDescriptionLabel].forEach {
      contentView.addSubview($0)
    }
    
    vehicleTakePicturDescriptionLabel.snp.makeConstraints {
      $0.top.equalTo(guid)
      $0.leading.equalTo(guid).offset(20)
      $0.trailing.equalTo(guid).offset(-20)
    }
  }
}
