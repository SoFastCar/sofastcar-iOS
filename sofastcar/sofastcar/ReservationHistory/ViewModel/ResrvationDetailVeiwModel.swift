//
//  ResrvationDetailVeiwModel.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum RentalCellType: String {
  case usingTime = "이용시간"
  case rentCarInfo = "차량정보"
  case socarZone = "이용장소"
  case otherDriver = "동승운전자"
  case insurance = "차량손해면책 상품"
  case cancelWarning = "취소수수로 및 패털티 안내"
  case cancel = "예약 취소하기"
  
  static func displayList() -> [RentalCellType] {
    return [.usingTime, .rentCarInfo, .socarZone, .otherDriver, .insurance, .cancelWarning, .cancel]
  }
}

enum PaymentCellType: String {
  case serviceTotalCost = "서비스 이용 총 금액"
  case beforeCost = "운행 전 요금"
  case afterCost = "운행 후 요금"
  
  static func displayList() -> [PaymentCellType] {
    return [.serviceTotalCost, .beforeCost, .afterCost]
  }
}

enum EtcCellType: String {
  case usingPdfDownLoad = "이용내역서(pdf) 다운로드"
  case washingCarHistory = "세차 기록 보기"
  case contectCustomerCenter = "이 예약 고객센터 문의하기"
  
  static func displayList() -> [EtcCellType] {
    return [.usingPdfDownLoad, .washingCarHistory, .contectCustomerCenter]
  }
}

struct ReservationDetailViewModel {
  let payments: [PaymentViewModel]
  
  var rentalTypeTitleArray = RentalCellType.displayList()
  var paymentTypeTitleArray = PaymentCellType.displayList()
  var etcTypeTitleArray = EtcCellType.displayList()

  init(_ paymentList: [PaymentBefore]) {
    self.payments = paymentList.compactMap(PaymentViewModel.init)
  }
}

struct PaymentViewModel {
  let payment: PaymentBefore
  
  init(_ payment: PaymentBefore) {
    self.payment = payment
  }
}

extension PaymentViewModel {
  var rentalFee: Observable<Int> {
    return Observable<Int>.just(self.payment.rentalFee)
  }
  
  var totalFee: Observable<Int> {
    return Observable<Int>.just(self.payment.totalFee)
  }
  
  var insuranceFee: Observable<Int> {
    return Observable<Int>.just(self.payment.insuranceFee)
  }
  
  var etcDiscount: Observable<Int> {
    return Observable<Int>.just(self.payment.etcDiscount)
  }
  
  var extensionFee: Observable<Int> {
    return Observable<Int>.just(self.payment.extensionFee)
  }
}
