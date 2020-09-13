//
//  BookingTimeVC.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/11.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class BookingTimeVC: UIViewController {
    
    let bookingTimeView = BookingTimeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
    }
    
    private func setupUI() {
        bookingTimeView.rentTimeButton.addTarget(self, action: #selector(didTapTimeButton(_:)), for: .touchUpInside)
        bookingTimeView.returnTimeButton.addTarget(self, action: #selector(didTapTimeButton(_:)), for: .touchUpInside)
        
        
        bookingTimeView.dismissButton.addTarget(self, action: #selector(tapDismiss(_:)), for: .touchUpInside)
        view.addSubview(bookingTimeView)
    }
    
    private func setupConstraint() {
        bookingTimeView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
    
    // MARK: - Selector
    @objc func didTapTimeButton(_ sender: RentReturnTimeButton) {
        switch sender.tag {
        case 0:
//            UIView.animate(withDuration: 0.5, animations: {
//                self.bookingTimeView.rentDatePicker.snp.updateConstraints({
//                    $0.height.equalTo(100)
//                })
//                self.view.layoutIfNeeded()
//            })
//        self.bookingTimeView.returnDatePicker.isHidden = false
//        self.bookingTimeView.rentDatePicker.alpha = 1
//            UIView.animate(withDuration: 0.5, animations: {
//
//                if self.bookingTimeView.rentDatePicker.isHidden {
//                    self.bookingTimeView.rentDatePicker.isHidden.toggle()
//                } else {
//                    self.bookingTimeView.rentDatePicker.isHidden.toggle()
//                }
//                self.view.layoutIfNeeded()
//            })
            self.bookingTimeView.tapRentButtonFlag = !self.bookingTimeView.tapRentButtonFlag
            if self.bookingTimeView.tapRentButtonFlag {
                UIView.animate(withDuration: 0.5, animations: {
                    self.bookingTimeView.rentDatePicker.snp.updateConstraints({
                        $0.height.equalTo(100)
                    })
                    self.view.layoutIfNeeded()
                })
                
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.bookingTimeView.rentDatePicker.snp.updateConstraints({
                        $0.height.equalTo(0)
                    })
                    self.view.layoutIfNeeded()
                })
            }
            
        case 1:
            self.bookingTimeView.tapReturnButtonFlag = !self.bookingTimeView.tapReturnButtonFlag
            if self.bookingTimeView.tapReturnButtonFlag {
                UIView.animate(withDuration: 0.5, animations: {
                    self.bookingTimeView.returnDatePicker.snp.updateConstraints({
                        $0.height.equalTo(100)
                    })
                    self.view.layoutIfNeeded()
                })
                
            } else {
                UIView.animate(withDuration: 0.5, animations: {
                    self.bookingTimeView.returnDatePicker.snp.updateConstraints({
                        $0.height.equalTo(0)
                    })
                    self.view.layoutIfNeeded()
                })
            }
        default:
            break
        }
    }
    @objc func tapDismiss(_ sender: UIButton) {
        guard let presentingVC = self.presentingViewController as? MainVC else { return }
        presentingVC.dismiss(animated: true)
    }
}
