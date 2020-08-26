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
    fullString.append(NSAttributedString(string: " "))
    fullString.append(NSAttributedString(string: setText))
    
    return fullString
  }
}
