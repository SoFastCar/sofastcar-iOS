//
//  EventBenifits.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/29.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class EventBenifits {
  var title: String
  var duration: String
  var info: String
  
  init(title: String, duration: String, info: String) {
    self.title = title
    self.duration = duration
    self.info = info
  }
}

extension EventBenifits {
  
  static func initialData() -> [EventBenifits] {
    return [
      EventBenifits.init(title: "쏘카마이존 EQC 이벤트", duration: "2020-09-28~2020-10-11", info: "평일엔 벤트 EQC를 내 차처럼"),
      EventBenifits.init(title: "코로나19 대응 안내", duration: "2020-09-28~2020-10-31", info: "안전한 이동이 필요한 순간"),
      EventBenifits.init(title: "추석 연휴에도 안심 이동", duration: "2020-08-09~2020-10-10", info: "스카차-브라이트 살균 소독 티슈 배치"),
      EventBenifits.init(title: "쏘카타고 도미토 픽업", duration: "2020-09-01~2020-09-31", info: "도미도피자 30% 할인!"),
      EventBenifits.init(title: "네이버페이 결제 이벤트", duration: "2020-08-01~2020-09-28", info: "Npay 최대 9,000원 할인"),
      EventBenifits.init(title: "티웨이 할인 쿠폰 이벤트", duration: "2020-08-01~2020-09-28", info: "오직 쏘카에서만 티웨이 특가"),
      EventBenifits.init(title: "초소형 전기차", duration: "2020-08-01~2020-09-28", info: "쏘카에서 만나는 새로운 모빌리티"),
      EventBenifits.init(title: "쏘카 페어링", duration: "2020-08-01~2020-09-28", info: "미리 준비하는 추석"),
      EventBenifits.init(title: "쏘카 이용 족집게 가이드", duration: "2020-08-01~2020-09-28", info: "더 똑똑하게 이용하는 방법"),
      EventBenifits.init(title: "제주에서 만나는 이동의 미래", duration: "쏘카 자율주행 셔틀 운행!", info: "쏘카 스테이션 제주에서 만나보세요"),
      EventBenifits.init(title: "개인 업무용 예약 이벤트", duration: "2020-08-01~2020-09-28", info: "쏘카패스 무료 체험권 받기"),
      EventBenifits.init(title: "쏘카 인스타그램 이벤트", duration: "2020-08-01~2020-09-28", info: "팔로우하고 일상을 파랗게 채우세요!")
    ]
  }
  
}
