//
//  LeftAlignedCollectionViewFlowLayout.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let attributes = super.layoutAttributesForElements(in: rect)
    
    var leftMargin: CGFloat = sectionInset.left
    var maxY: CGFloat = -1.0
    attributes?.forEach { layoutAttribute in
      if layoutAttribute.frame.origin.y >= maxY {
        leftMargin = sectionInset.left
      }
      
      layoutAttribute.frame.origin.x = leftMargin
      
      leftMargin += layoutAttribute.frame.width + 3
      maxY = max(layoutAttribute.frame.maxY, maxY)
    }
    return attributes
  }
}
