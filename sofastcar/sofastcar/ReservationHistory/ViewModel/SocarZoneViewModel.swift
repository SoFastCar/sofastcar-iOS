//
//  SocarZoneViewModel.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct SocarZoneListViewModel {
  
  let socarZoneList: [SocarZoneViewModel]
  
  init(_ socarZoneDataList: [SocarZoneData]) {
    self.socarZoneList = socarZoneDataList.compactMap(SocarZoneViewModel.init)
  }
}

extension SocarZoneListViewModel {
  func socarZoneAt(_ index: Int) -> SocarZoneViewModel {
    return self.socarZoneList[index]
  }
}

struct SocarZoneViewModel {
  var socarZone: SocarZoneData
  
  init(_ socarZone: SocarZoneData) {
    self.socarZone = socarZone
  }
}

extension SocarZoneViewModel {
  
  var name: Observable<String> {
    return Observable<String>.just(self.socarZone.name)
  }
  
}
