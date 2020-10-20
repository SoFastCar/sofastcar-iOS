//
//  SocarViewModel.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct SocarListViewModel {
  let socars: [SocarViewModel]
  
  init(_ socarList: [Socar]) {
    self.socars = socarList.compactMap(SocarViewModel.init)
  }
}

extension SocarListViewModel {
  func socarAt(_ index: Int) -> SocarViewModel {
    return self.socars[index]
  }
}

struct SocarViewModel {
  let socar: Socar
  
  init(_ socar: Socar) {
    self.socar = socar
  }
}

extension SocarViewModel {
  var name: Observable<String> {
    return Observable<String>.just(self.socar.name)
  }
  
  var number: Observable<String> {
    return Observable<String>.just(self.socar.number)
  }
  
  var imageUrl: Observable<String> {
    return Observable<String>.just(self.socar.image)
  }
}
