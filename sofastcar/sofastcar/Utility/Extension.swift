//
//  SocarButton.swift
//  sofastcar
//
//  Created by 김광수 on 2020/08/26.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

// MARK: - NSAttributedString
extension NSAttributedString {
  static func touStyle(imageAttach: NSTextAttachment, setText: String) -> NSAttributedString? {
    let imageAttachment = imageAttach
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .left
    
    let fullString = NSMutableAttributedString()
    fullString.append(NSAttributedString(attachment: imageAttachment))
    fullString.append(NSAttributedString(string: "  "))
    fullString.append(NSAttributedString(string: setText))
    
    return fullString
  }
  
  static func authStyle(imageAttach: NSTextAttachment, setText: String) -> NSAttributedString? {
    let imageAttachment = imageAttach
    let paragraph = NSMutableParagraphStyle()
    paragraph.alignment = .left
    
    let fullString = NSMutableAttributedString()
    fullString.append(NSAttributedString(string: setText))
    fullString.append(NSAttributedString(string: "  "))
    fullString.append(NSAttributedString(attachment: imageAttachment))
    return fullString
  }
  
  static func attributedStringWithLienSpacing(text: String, font: UIFont) -> NSAttributedString {
    let pragrapphStyle = NSMutableParagraphStyle()
    pragrapphStyle.lineSpacing = 0.25 * (font.lineHeight)
    let attributes = [NSAttributedString.Key.font: font as Any,
                      NSAttributedString.Key.paragraphStyle: pragrapphStyle]
    return NSAttributedString(string: text, attributes: attributes)
  }
}
// MARK: - UITextField
// textField내 왼쪽 padding 넣기
extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

// MARK: - UIViewController
extension UIViewController {
  func setBackButton() {
    let backButtonImage = UIImage(systemName: "arrow.left")
    self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    self.navigationController?.navigationBar.topItem?.title = ""
  }
  
  func presentDetail(_ viewControllerToPresent: UIViewController) {
    let transition = CATransition()
    transition.duration = 0
//    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromLeft
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.view.window!.layer.add(transition, forKey: kCATransition)
    present(viewControllerToPresent, animated: false)
  }
  
  func dismissDetail() {
    let transition = CATransition()
    transition.duration = 0
//    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.view.window!.layer.add(transition, forKey: kCATransition)
    dismiss(animated: false)
  }

}

extension UINavigationController {
  func noTitlePushViewController(_ viewController: UIViewController, animated: Bool) {
    print("add")
    let backButtonImage = UIImage(systemName: "arrow.left")
    self.navigationController?.navigationBar.backIndicatorImage = backButtonImage
    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    self.navigationController?.navigationBar.topItem?.title = ""
    pushViewController(viewController, animated: animated)
  }
  
}

// MARK: - Hide Keyboard

extension UIViewController {
  func hideKeyboard() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(
      target: self,
      action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

extension UIView {
    enum ViewSide {
        case top, left, right, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        
        self.layer.addSublayer(border)
    }
    
    func symbolConfiguration(pointSize bySize: CGFloat, weight byWeight: UIImage.SymbolWeight) -> UIImage.SymbolConfiguration {
        return UIImage.SymbolConfiguration(pointSize: bySize, weight: byWeight)
    }
}
