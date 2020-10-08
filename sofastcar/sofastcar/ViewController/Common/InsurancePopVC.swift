//
//  InsurancePopVC.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/17.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class InsurancePopVC: UIViewController {
  // MARK: - Properties
  var insuranceMainView = InsuranceMenuView()
  var selectedInsurance: Insurance?
    var updatedInsuranceData: [Insurance]?
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureLayout()
    configureButtonAction()
  }
  
  private func configureLayout() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0)
    view.addSubview(insuranceMainView)
    insuranceMainView.special.configuration(symbol: "circle", name: "스페셜", guarantee: 10, cost: updatedInsuranceData?[0].cost ?? 0)
    insuranceMainView.standard.configuration(symbol: "circle", name: "스탠다드", guarantee: 30, cost: updatedInsuranceData?[1].cost ?? 0)
    insuranceMainView.light.configuration(symbol: "circle", name: "라이트", guarantee: 50, cost: updatedInsuranceData?[2].cost ?? 0)
    insuranceMainView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height,
                                     width: UIScreen.main.bounds.width,
                                     height: 490)
  }
  
  private func configureButtonAction() {
    insuranceMainView.confirmButton.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
    
    insuranceMainView.special.tag = 0
    insuranceMainView.special.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
    insuranceMainView.standard.tag = 1
    insuranceMainView.standard.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
    insuranceMainView.light.tag = 2
    insuranceMainView.light.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    dismissWithAnimate()
  }
  
  func presnetWithAnimate() {
    UIView.animate(withDuration: 0.3) {
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    UIView.animate(withDuration: 0.3) {
      self.insuranceMainView.center.y -= self.insuranceMainView.frame.height
    }
  }
  
  private func dismissWithAnimate() {
    guard let navi = self.presentingViewController as? UINavigationController else { return }
    if let presentingVC = navi.viewControllers.last as? ReservationConfirmTableVC {
        presentingVC.insuranceData = selectedInsurance
        presentingVC.reloadUsingTimeCell()
    }
    UIView.animate(withDuration: 0.3) {
      self.view.backgroundColor = UIColor.black.withAlphaComponent(0)
    }
    
    UIView.animate(withDuration: 0.3, animations: {
      self.insuranceMainView.center.y += self.insuranceMainView.frame.height
    }, completion: {_ in
      self.dismiss(animated: true)
    })
  }
  
  // MARK: - Button Action
  @objc private func tapCompleteButton() {
    dismissWithAnimate()
  }
  
  @objc func didTapInsuranceItem(_ sender: InsuranceMenuItemButton) {
    switch sender.tag {
    // Specail
    case 0:
      sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
      sender.itemCostLabel.textColor = .systemBlue
      insuranceMainView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.standard.itemCostLabel.textColor = .gray
      insuranceMainView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.light.itemCostLabel.textColor = .gray
      selectedInsurance = updatedInsuranceData?[0]
    // Standard
    case 1:
      sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
      sender.itemCostLabel.textColor = .systemBlue
      insuranceMainView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.special.itemCostLabel.textColor = .gray
      insuranceMainView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.light.itemCostLabel.textColor = .gray
        selectedInsurance = updatedInsuranceData?[1]
    // Light
    case 2:
      sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
      sender.itemCostLabel.textColor = .systemBlue
      insuranceMainView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.special.itemCostLabel.textColor = .gray
      insuranceMainView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.standard.itemCostLabel.textColor = .gray
        selectedInsurance = updatedInsuranceData?[2]
    default:
      break
    }
  }
}
