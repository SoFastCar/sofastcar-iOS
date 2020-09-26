//
//  SocarClubScrollView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/25.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SocarClubScrollView: UIScrollView {
  // MARK: - Properties
  var socarClubLable: Int = 0
  var userTotalDrivingKm: Int = 800
  var userDrivingKm: Int = 200
    
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemGray6
    view.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 0, right: 15)
    return view
  }()
  
  lazy var drivingDistanceInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "지금까지 쏘카와 함께\n \(userTotalDrivingKm)km 드라이브했어요."
    label.numberOfLines = 2
    label.font = .boldSystemFont(ofSize: 40)
    label.textColor = .black
    return label
  }()
  
  lazy var userClubLevelInfoLable: UILabel = {
    let label = UILabel()
    label.text = "다음 레벨까지 남은거리 \(userDrivingKm)km\n레벨 \(socarClubLable)가 되면 탈때마다 차량 손해면책 상품을 10%\n 할인해드려요"
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    return label
  }()
  
  // MARK: - Life Cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    configureScrollView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configureScrollView() {
    // 기기별 스크롤뷰 조절
    var heightPadding: CGFloat = 0
    if UIScreen.main.bounds.height < 670 { // se, Se2...
      heightPadding = UIScreen.main.bounds.height * 0.2
    } else {
      heightPadding = 0
    }
    
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding)
  }
  
  private func configureSocarDrivingUI() {
    
  }
}
