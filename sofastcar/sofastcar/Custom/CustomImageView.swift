//
//  CustomImageView.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
  
  var lastImageUsedToLoadImage: String?
  
  //set image nil
  func loadImage(with urlString: String) {
    
    self.image = nil
    
    lastImageUsedToLoadImage = urlString
    
    // 이미지가 케쉬 영역에 있는지 확인
    if let cachedImage = imageCache[urlString] {
      self.image = cachedImage
      return
    }
    // 이미지가 케쉬 영역에 존제하지 않는 경우
    guard let url = URL(string: urlString) else { return }
    // 이미지 컨텐츠의 위치 얻기
    URLSession.shared.dataTask(with: url) { (data, _, error ) in
      
      if let error = error {
        print("Failed to load image with error", error.localizedDescription)
      }
      
      if self.lastImageUsedToLoadImage != url.absoluteString {
        return
      }
      
      // 이미지 데이터 (NSData 타입)
      guard let imageData = data else {return}
      // 이미지 데이터를 통해서 이미지 생성 (Data -> image)
      let photoImage = UIImage(data: imageData)
      
      //URL -> String값으로 변경하여 케쉬 변수에 저장
      imageCache[url.absoluteString] = photoImage
      DispatchQueue.main.sync {
        self.image = photoImage
      }
    }.resume()
  }
}
