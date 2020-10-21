//
//  SideBarViewModel.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

enum SideBarMenuType: String {
  case eventBannerCell = ""
  case usingHistocyCell = "이용내역"
  case socarPassCell = "쏘카패스"
  case couponCell = "쿠폰"
  case evnetWithBenigitCell = "이벤트/해택"
  case socarPlusCell = "쏘카플러스"
  case inviteFriendCell = "친구 초대하기"
  case customerCenterCell = "고객센터"
  case mainBoardCell = "공지사항"
  
  static func allcase() -> [SideBarMenuType] {
    return [eventBannerCell, usingHistocyCell, socarPassCell, couponCell, evnetWithBenigitCell,
    socarPlusCell, inviteFriendCell, customerCenterCell, mainBoardCell]
  }
}

struct SideBarViewModel {
  // MARK: - Properties
  let user: User
  
  var sideBarCellTypes = SideBarMenuType.allcase()
  
  init(_ user: User) {
    self.user = user
  }
}

extension SideBarViewModel {
  
  var name: Observable<String> {
    return Observable<String>.just(user.name)
  }
  
  var email: Observable<String> {
    return Observable<String>.just(user.email)
  }
  
  var creditPoint: Observable<String> {
    let creditPointToString = user.creditPoint.priceWithDots()
    return Observable<String>.just(creditPointToString)
  }
  
}
