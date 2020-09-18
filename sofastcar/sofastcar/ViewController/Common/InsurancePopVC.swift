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
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .none
    view.addSubview(insuranceMainView)
    insuranceMainView.frame = CGRect(x: 0, y: 350,
                                     width: UIScreen.main.bounds.width,
                                     height: 490)
    insuranceMainView.confirmButton.addTarget(self, action: #selector(tapCompleteButton), for: .touchUpInside)
    
    insuranceMainView.special.tag = 0
    insuranceMainView.special.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
    insuranceMainView.standard.tag = 1
    insuranceMainView.standard.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
    insuranceMainView.light.tag = 2
    insuranceMainView.light.addTarget(self, action: #selector(didTapInsuranceItem(_:)), for: .touchUpInside)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    dismissThisViewContoller()
  }
  
  private func dismissThisViewContoller() {
    if let navi = presentingViewController as? UINavigationController {
      guard let presentVC = navi.viewControllers.last as? ReservationConfirmTableVC else { return }
      UIView.animate(withDuration: 0.4) {
        presentVC.blurView.alpha = 0
      }
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  // MARK: - Button Action
  @objc private func tapCompleteButton() {
    dismissThisViewContoller()
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
    // Standard
    case 1:
      sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
      sender.itemCostLabel.textColor = .systemBlue
      insuranceMainView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.special.itemCostLabel.textColor = .gray
      insuranceMainView.light.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.light.itemCostLabel.textColor = .gray
    // Light
    case 2:
      sender.selectSymbolImageView.image = UIImage(systemName: "circle.fill", withConfiguration: sender.symbolConfig)
      sender.itemCostLabel.textColor = .systemBlue
      insuranceMainView.special.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.special.itemCostLabel.textColor = .gray
      insuranceMainView.standard.selectSymbolImageView.image = UIImage(systemName: "circle", withConfiguration: sender.symbolConfig)
      insuranceMainView.standard.itemCostLabel.textColor = .gray
    default:
      break
    }
  }
}
