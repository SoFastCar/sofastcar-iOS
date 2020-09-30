//
//  FriendsInviteView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class FriendsInviteView: UIScrollView {
  // MARK: - Properties
  lazy var guide = contentView.layoutMarginsGuide
  let myBlueAttributedes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: CommonUI.mainBlue.cgColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
  let myGrayAttributedes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.foregroundColor: UIColor.darkGray.cgColor, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.layoutMargins = UIEdgeInsets(top: 30, left: 15, bottom: 0, right: 15)
    return view
  }()
  
  // MARK: - First Section Properties
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = .boldSystemFont(ofSize: 25)
    label.text = "친구 초대하기"
    return label
  }()
  
  lazy var couponLabel: UILabel = {
    let label = UILabel()
    let attributedText = NSMutableAttributedString(string: "10,000원 할인 쿠폰", attributes: myBlueAttributedes)
    attributedText.append(NSAttributedString(string: "과", attributes: myGrayAttributedes))
    label.attributedText = attributedText
    return label
  }()
  
  lazy var creditLabel: UILabel = {
    let label = UILabel()
    let attributedText = NSMutableAttributedString(string: "1,000크레딧", attributes: myBlueAttributedes)
    attributedText.append(NSAttributedString(string: "을 드려요!", attributes: myGrayAttributedes))
    label.attributedText = attributedText
    return label
  }()
  
  let friendsMissonInfo: UILabel = {
    let label = UILabel()
    label.text = "초대 받은 친구가 미션을 완료하면\n다양한 혜택을 받을 수 있어요."
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .darkGray
    return label
  }()
  
  let couponDetailLabel: UILabel = {
    let label = UILabel()
    label.text = "- 1만원 쿠폰 x 2장\n운전면허증과 결제카드 승인 완료시"
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let creditDetailLabel: UILabel = {
    let label = UILabel()
    label.text = "- 1천 크레딧 추가 지급\n첫 드라이브 후 반납 완료시"
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let seperateDotsView1 = DotsLineView()
  
  // MARK: - Second Section Properties
  let inviteCodeLabel: UILabel = {
    let label = UILabel()
    label.text = "초대 코드(내 쏘카 ID)"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray2
    return label
  }()
  
  let inviteCodeValueLabel: UILabel = {
    let label = UILabel()
    label.text = "aaa@naver.com"
    label.font = .boldSystemFont(ofSize: CommonUI.titleTextFontSize)
    label.textColor = .black
    return label
  }()
  
  let kakaoInviteImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "kakao_Invite")
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let kakaoInviteLabel: UILabel = {
    let label = UILabel()
    label.text = "카카오톡"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()

  let shareInviteImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "share_Invite")
    imageView.clipsToBounds = true
    return imageView
  }()
  
  let shareInviteLabel: UILabel = {
    let label = UILabel()
    label.text = "공유하기"
    label.font = .systemFont(ofSize: CommonUI.contentsTextFontSize)
    label.textColor = .systemGray
    return label
  }()
  
  let seperateDotsView2 = DotsLineView()
  
  // MARK: - Third Section Properties
  let seperateDotsView3 = DotsLineView()
  
  lazy var giveCouponToFriendLabel: UILabel = {
    let label = UILabel()
    let attributed = NSMutableAttributedString(string: "친구에게 ", attributes: myGrayAttributedes)
    attributed.append(NSAttributedString(string: "쿠폰 선물", attributes: myBlueAttributedes))
    attributed.append(NSAttributedString(string: "하기!", attributes: myGrayAttributedes))
    label.attributedText = attributed
    return label
  }()
  
  let rightImageView: UIImageView = {
    let imageView = UIImageView()
    let configure = UIImage.SymbolConfiguration(pointSize: 15)
    imageView.image = UIImage(systemName: "chevron.right", withConfiguration: configure)
    imageView.tintColor = .darkGray
    return imageView
  }()
  
  let couponSendButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .none
    return button
  }()
  
  // MARK: - Life cycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    configureScrollView()
    configureFirstSection()
    configureSecondSection()
    configureThirdSection()
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
    backgroundColor = .white
    self.contentSize = .init(width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.frame = CGRect(x: 0, y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.height+heightPadding+44)
    contentView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    self.addSubview(contentView)
  }
  
  private func configureFirstSection() {
    [titleLabel, couponLabel, creditLabel, friendsMissonInfo, couponDetailLabel, creditDetailLabel, seperateDotsView1].forEach {
      contentView.addSubview($0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.top.leading.equalTo(guide)
    }
    
    couponLabel.snp.makeConstraints {
      $0.top.equalTo(titleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    creditLabel.snp.makeConstraints {
      $0.top.equalTo(couponLabel.snp.bottom)
      $0.leading.equalTo(guide)
    }
    
    friendsMissonInfo.snp.makeConstraints {
      $0.top.equalTo(creditLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    couponDetailLabel.snp.makeConstraints {
      $0.top.equalTo(friendsMissonInfo.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    creditDetailLabel.snp.makeConstraints {
      $0.top.equalTo(couponDetailLabel.snp.bottom).offset(20)
      $0.leading.equalTo(guide)
    }
    
    seperateDotsView1.backgroundColor = .systemGray6
    seperateDotsView1.snp.makeConstraints {
      $0.top.equalTo(creditDetailLabel.snp.bottom).offset(30)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
  }
  
  private func configureSecondSection() {
    [inviteCodeLabel, inviteCodeValueLabel, kakaoInviteImageView, kakaoInviteLabel, shareInviteImageView, shareInviteLabel, seperateDotsView2].forEach {
      contentView.addSubview($0)
    }
    
    inviteCodeLabel.snp.makeConstraints {
      $0.top.equalTo(seperateDotsView1.snp.bottom).offset(20)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    inviteCodeValueLabel.snp.makeConstraints {
      $0.top.equalTo(inviteCodeLabel.snp.bottom).offset(3)
      $0.centerX.equalTo(guide.snp.centerX)
    }
    
    kakaoInviteImageView.snp.makeConstraints {
      $0.top.equalTo(inviteCodeValueLabel.snp.bottom).offset(40)
      $0.centerX.equalTo(guide.snp.centerX).offset(-60)
      $0.height.width.equalTo(60)
    }
    
    kakaoInviteLabel.snp.makeConstraints {
      $0.top.equalTo(kakaoInviteImageView.snp.bottom).offset(3)
      $0.centerX.equalTo(kakaoInviteImageView.snp.centerX)
    }
    
    shareInviteImageView.snp.makeConstraints {
      $0.top.equalTo(inviteCodeValueLabel.snp.bottom).offset(40)
      $0.centerX.equalTo(guide.snp.centerX).offset(60)
      $0.height.width.equalTo(60)
    }
    
    shareInviteLabel.snp.makeConstraints {
      $0.top.equalTo(shareInviteImageView.snp.bottom).offset(3)
      $0.centerX.equalTo(shareInviteImageView.snp.centerX)
    }
    
    seperateDotsView2.backgroundColor = .systemGray6
    seperateDotsView2.snp.makeConstraints {
      $0.top.equalTo(kakaoInviteLabel.snp.bottom).offset(20)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
  }
  
  private func configureThirdSection() {
    [giveCouponToFriendLabel, rightImageView, couponSendButton, seperateDotsView3].forEach {
      contentView.addSubview($0)
    }
    
    couponSendButton.snp.makeConstraints {
      $0.top.equalTo(seperateDotsView2.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(80)
    }
    
    giveCouponToFriendLabel.snp.makeConstraints {
      $0.centerY.equalTo(couponSendButton.snp.centerY)
      $0.leading.equalTo(guide)
    }
    
    rightImageView.snp.makeConstraints {
      $0.centerY.equalTo(couponSendButton.snp.centerY)
      $0.trailing.equalTo(guide)
    }
  
    seperateDotsView3.backgroundColor = .systemGray6
    seperateDotsView3.snp.makeConstraints {
      $0.top.equalTo(couponSendButton.snp.bottom)
      $0.leading.trailing.equalTo(guide)
      $0.height.equalTo(1)
    }
  }
}
