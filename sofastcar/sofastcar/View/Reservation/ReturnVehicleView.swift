//
//  ReturnVehicleView.swift
//  sofastcar
//
//  Created by 요한 on 2020/09/22.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import SnapKit

protocol ReturnVehicleViewDelegate: class {
    func didTapButton(_ sender: UIButton)
}

class ReturnVehicleView: UIView {
  
  weak var delegate: ReturnVehicleViewDelegate?
  
  fileprivate let returnPlaceCheckView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let returnPlaceDescriptionTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "송파동 공영주차장 에 반납하셨나요?"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let returnPlaceCheckTrueButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "네"
    
    return view
  }()
  
  fileprivate let returnPlaceCheckFalseButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "아니요"

    return view
  }()
  
  fileprivate let returnParkingPlaceLabel: UILabel = {
    let label = UILabel()
    label.text = "지상 4층 에 반납하셨나요?"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    label.isHidden = true
    
    return label
  }()
  
  fileprivate let returnParkingPlaceCheckTrueButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "네"
    
    return view
  }()
  
  fileprivate let returnParkingPlaceCheckFalseButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "아니요"

    return view
  }()
  
  fileprivate let returnFinalCheckView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  fileprivate let returnFinalCheckDescriptionLabel: UILabel = {
    let label = UILabel()
    label.text = "반납 전 마지막 확인"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let windowCloseLabel: UILabel = {
    let label = UILabel()
    label.text = "창문은 모두 닫았나요?"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let illuminationOffLabel: UILabel = {
    let label = UILabel()
    label.text = "실내등은 모두 껐나요?"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate let personalItemLabel: UILabel = {
    let label = UILabel()
    label.text = "개인 소지품은 모두 챙겼나요?"
    label.font = UIFont.preferredFont(forTextStyle: .subheadline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  fileprivate lazy var checkLabelStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        windowCloseLabel,
        illuminationOffLabel,
        personalItemLabel
      ]
    )
    stackView.axis = .vertical
    stackView.spacing = 20
    
    return stackView
  }()
  
  fileprivate let windowCloseButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "네"
    view.snp.makeConstraints {
      $0.width.equalTo(50)
      $0.height.equalTo(15)
    }
    
    return view
  }()
  
  fileprivate let illuminationOffButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "네"
    view.snp.makeConstraints {
      $0.width.equalTo(50)
      $0.height.equalTo(15)
    }

    return view
  }()
  
  fileprivate let personalItemButtonView: CheckButtonView = {
    let view = CheckButtonView()
    view.toggle = false
    view.buttonTypeLabel = "네"
    view.snp.makeConstraints {
      $0.width.equalTo(50)
      $0.height.equalTo(15)
    }

    return view
  }()
  
  fileprivate lazy var checkButtonStackView: UIStackView = {
    let stackView = UIStackView(
      arrangedSubviews: [
        windowCloseButtonView,
        illuminationOffButtonView,
        personalItemButtonView
      ]
    )
    stackView.axis = .vertical
    stackView.spacing = 20
    
    return stackView
  }()
  
  fileprivate let returnRuleGuideView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
      
    return view
  }()
  
  fileprivate let socarRuleGuidLabel: UILabel = {
    let label = UILabel()
    label.text = "쏘카 이용규칙 및 패널티 안내"
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    label.textColor = CommonUI.mainDark
    
    return label
  }()
  
  let rightChevronButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: CommonUI.SFSymbolKey.rightChevron.rawValue), for: .normal)
    button.tintColor = CommonUI.mainDark
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    
    return button
  }()
  
  let returnButton: UIButton = {
    let button = UIButton()
    button.setTitle("반납하기", for: .normal)
    button.backgroundColor = CommonUI.mainBlue
    button.contentHorizontalAlignment = .center
    button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    
    return button
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
    let guid = self.safeAreaLayoutGuide
    self.backgroundColor = .cyan
    
    [returnPlaceCheckView, returnFinalCheckView, returnRuleGuideView, returnButton].forEach {
      self.addSubview($0)
    }
    
    returnPlaceCheckView.snp.makeConstraints {
      $0.top.equalTo(guid)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(100)
    }
    
    returnFinalCheckView.snp.makeConstraints {
      $0.top.equalTo(returnPlaceCheckView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(200)
    }
    
    returnRuleGuideView.snp.makeConstraints {
      $0.top.equalTo(returnFinalCheckView.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(80)
    }
    
    returnButton.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(80)
    }
    
    returnPlaceCheck()
    returnFinalCheck()
    returnRuleGuide()
    
    setGesture()
  }
  
  fileprivate func returnPlaceCheck() {
    
    [returnPlaceDescriptionTitleLabel, returnPlaceCheckTrueButtonView, returnPlaceCheckFalseButtonView, returnParkingPlaceLabel, returnParkingPlaceCheckTrueButtonView, returnParkingPlaceCheckFalseButtonView].forEach {
      returnPlaceCheckView.addSubview($0)
    }
    
    returnPlaceDescriptionTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(10)
      $0.leading.equalToSuperview().offset(20)
    }
    
    returnPlaceCheckTrueButtonView.snp.makeConstraints {
      $0.top.equalTo(returnPlaceDescriptionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(150)
      $0.width.equalTo(50)
      $0.height.equalTo(20)
    }
    
    returnPlaceCheckFalseButtonView.snp.makeConstraints {
      $0.top.equalTo(returnPlaceDescriptionTitleLabel.snp.bottom).offset(20)
      $0.leading.equalTo(returnPlaceCheckTrueButtonView.snp.trailing).offset(40)
      $0.width.equalTo(50)
      $0.height.equalTo(20)
    }
    
    returnParkingPlaceLabel.snp.makeConstraints {
      $0.top.equalTo(returnPlaceCheckTrueButtonView.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    returnParkingPlaceCheckTrueButtonView.snp.makeConstraints {
      $0.top.equalTo(returnParkingPlaceLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(150)
      $0.width.equalTo(50)
      $0.height.equalTo(20)
    }
    
    returnParkingPlaceCheckFalseButtonView.snp.makeConstraints {
      $0.top.equalTo(returnParkingPlaceLabel.snp.bottom).offset(20)
      $0.leading.equalTo(returnParkingPlaceCheckTrueButtonView.snp.trailing).offset(40)
      $0.width.equalTo(50)
      $0.height.equalTo(20)
    }
  }
  fileprivate func returnFinalCheck() {
    
    [returnFinalCheckDescriptionLabel, checkLabelStackView, checkButtonStackView].forEach {
      returnFinalCheckView.addSubview($0)
    }
    
    returnFinalCheckDescriptionLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    checkLabelStackView.snp.makeConstraints {
      $0.top.equalTo(returnFinalCheckDescriptionLabel.snp.bottom).offset(20)
      $0.leading.equalToSuperview().offset(20)
    }
    
    checkButtonStackView.snp.makeConstraints {
      $0.top.equalTo(returnFinalCheckDescriptionLabel.snp.bottom).offset(20)
      $0.trailing.equalToSuperview().offset(-20)
    }
  }
  fileprivate func returnRuleGuide() {
    
    [socarRuleGuidLabel, rightChevronButton].forEach {
      returnRuleGuideView.addSubview($0)
    }
    
    socarRuleGuidLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(20)
    }
    
    rightChevronButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-20)
    }
  }
  
  fileprivate func setGesture() {
    let returnPlaceCheckTrueButtonGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    let returnPlaceCheckFalseButtonGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    let returnParkingPlaceCheckTrueGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    let returnParkingPlaceCheckFalseGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    
    let windowCloseesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    let illuminationOffGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    let personalItemBGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(checkAction)
    )
    
    returnPlaceCheckTrueButtonView.addGestureRecognizer(returnPlaceCheckTrueButtonGesture)
    returnPlaceCheckFalseButtonView.addGestureRecognizer(returnPlaceCheckFalseButtonGesture)
    
    returnParkingPlaceCheckTrueButtonView.addGestureRecognizer(returnParkingPlaceCheckTrueGesture)
    
    returnParkingPlaceCheckFalseButtonView.addGestureRecognizer(returnParkingPlaceCheckFalseGesture)
    
    windowCloseButtonView.addGestureRecognizer(windowCloseesture)
    
    illuminationOffButtonView.addGestureRecognizer(illuminationOffGesture)
    
    personalItemButtonView.addGestureRecognizer(personalItemBGesture)
  }
  
  // MARK: - Action
  
  @objc func didTapButton(_ sender: UIButton) {
    delegate?.didTapButton(sender)
  }
  
  @objc func checkAction(_ sender: UITapGestureRecognizer) {
    
    switch sender.view {
    case returnPlaceCheckTrueButtonView:
      returnPlaceCheckTrueButtonView.toggle.toggle()
      
      if returnPlaceCheckTrueButtonView.toggle == true && returnPlaceCheckFalseButtonView.toggle == true {
        returnPlaceCheckFalseButtonView.toggle.toggle()
        returnPlaceCheckView.snp.remakeConstraints {
          $0.top.equalTo(self.safeAreaLayoutGuide)
          $0.leading.trailing.equalToSuperview()
          $0.height.equalTo(180)
          returnParkingPlaceLabel.isHidden = false
        }
      } else if returnPlaceCheckTrueButtonView.toggle == true {
        returnPlaceCheckView.snp.remakeConstraints {
          $0.top.equalTo(self.safeAreaLayoutGuide)
          $0.leading.trailing.equalToSuperview()
          $0.height.equalTo(180)
          returnParkingPlaceLabel.isHidden = false
        }
      } else {
        returnPlaceCheckView.snp.remakeConstraints {
          $0.top.equalTo(self.safeAreaLayoutGuide)
          $0.leading.trailing.equalToSuperview()
          $0.height.equalTo(100)
          returnParkingPlaceLabel.isHidden = true
          returnParkingPlaceCheckTrueButtonView.toggle = false
          returnParkingPlaceCheckFalseButtonView.toggle = false
        }
      }

    case returnPlaceCheckFalseButtonView:
      returnPlaceCheckFalseButtonView.toggle.toggle()
      
      if returnPlaceCheckTrueButtonView.toggle == true && returnPlaceCheckFalseButtonView.toggle == true {
        returnPlaceCheckTrueButtonView.toggle.toggle()
        returnPlaceCheckView.snp.remakeConstraints {
          $0.top.equalTo(self.safeAreaLayoutGuide)
          $0.leading.trailing.equalToSuperview()
          $0.height.equalTo(100)
          returnParkingPlaceLabel.isHidden = true
          returnParkingPlaceCheckTrueButtonView.toggle = false
          returnParkingPlaceCheckFalseButtonView.toggle = false
        }
      }
      
    case returnParkingPlaceCheckTrueButtonView:
      returnParkingPlaceCheckTrueButtonView.toggle.toggle()
      
      if returnParkingPlaceCheckTrueButtonView.toggle == true && returnParkingPlaceCheckFalseButtonView.toggle == true {
        returnParkingPlaceCheckFalseButtonView.toggle.toggle()
      }
      
    case returnParkingPlaceCheckFalseButtonView:
      returnParkingPlaceCheckFalseButtonView.toggle.toggle()
      
      if returnParkingPlaceCheckTrueButtonView.toggle == true && returnParkingPlaceCheckFalseButtonView.toggle == true {
        returnParkingPlaceCheckTrueButtonView.toggle.toggle()
      }
      
    case windowCloseButtonView:
      windowCloseButtonView.toggle.toggle()
    case illuminationOffButtonView:
      illuminationOffButtonView.toggle.toggle()
    case personalItemButtonView:
      personalItemButtonView.toggle.toggle()
    default:
      break
    }
  }
}
