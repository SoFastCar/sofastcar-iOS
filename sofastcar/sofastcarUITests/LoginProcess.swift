//
//  LoginProcess.swift
//  sofastcarUITests
//
//  Created by 김광수 on 2020/08/31.
//  Copyright © 2020 김광수. All rights reserved.
//

import XCTest

class LoginProcess: XCTestCase {

    override func setUpWithError() throws {

        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
 
    }

    func testExample() throws {
      // MARK: - 회원 가입
      let app = XCUIApplication()
      sleep(1)
      let staticText = app/*@START_MENU_TOKEN@*/.staticTexts["가입하기 "]/*[[".buttons[\"가입하기 \"].staticTexts[\"가입하기 \"]",".staticTexts[\"가입하기 \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      staticText.tap()
      
      let staticText2 = app/*@START_MENU_TOKEN@*/.staticTexts["가입하기 "]/*[[".buttons[\"가입하기 \"].staticTexts[\"가입하기 \"]",".staticTexts[\"가입하기 \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      staticText2.tap()
      
      app/*@START_MENU_TOKEN@*/.staticTexts["  서비스 이용약관 전체 동의"]/*[[".buttons[\"  서비스 이용약관 전체 동의\"].staticTexts[\"  서비스 이용약관 전체 동의\"]",".staticTexts[\"  서비스 이용약관 전체 동의\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app/*@START_MENU_TOKEN@*/.staticTexts["  (선택) 할인쿠폰⋅이벤트등 마케팅 정보 수신 동의"]/*[[".buttons[\"  (선택) 할인쿠폰⋅이벤트등 마케팅 정보 수신 동의\"].staticTexts[\"  (선택) 할인쿠폰⋅이벤트등 마케팅 정보 수신 동의\"]",".staticTexts[\"  (선택) 할인쿠폰⋅이벤트등 마케팅 정보 수신 동의\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app/*@START_MENU_TOKEN@*/.staticTexts["가입 계속하기"]/*[[".buttons[\"가입 계속하기\"].staticTexts[\"가입 계속하기\"]",".staticTexts[\"가입 계속하기\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      // MARK: - 휴대폰 인증
      let scrollViewsQuery = app.scrollViews
      let elementsQuery = scrollViewsQuery.otherElements
      elementsQuery.staticTexts["   본인 확인 서비스 이용약관 전체 동의"].tap()
      elementsQuery.textFields["본인 실명 (통신사 가입 이름)"].tap()
      
      app.typeText("김광수")
      
      app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards.buttons[\"Return\"]",".buttons[\"Return\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
      app.typeText("880724")
      sleep(1)
      app.keys["1"].tap()
      sleep(1)
      app.tables/*@START_MENU_TOKEN@*/.staticTexts["  SKT"]/*[[".cells.staticTexts[\"  SKT\"]",".staticTexts[\"  SKT\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      sleep(1)
      app.typeText("01050367192")
      sleep(1)
      
      app.staticTexts["인증 완료"].tap()
      sleep(1)
      
      // MARK: - 기본 정보
      elementsQuery.textFields["이메일 주소 입력"].tap()
      app.typeText("tootoomaa@naver.com")
      app.keys["more"].tap()
      
      elementsQuery.secureTextFields["영문,숫자 포함 8자리 이상 입력"].tap()
      app.typeText("qweqwe123")
      app.keys["more"].tap()
      
      elementsQuery.secureTextFields["비밀번호 재입력"].tap()
      app.typeText("qweqwe123")
      
      let point = CGPoint(x: 100, y: 100)
      app.tapCoordinate(at: point)
      
      app.buttons["입력 완료"].tap()
      
      app.buttons["확인"].tap()
    }
}

extension XCUIApplication {
    func tapCoordinate(at point: CGPoint) {
        let normalized = coordinate(withNormalizedOffset: .zero)
        let offset = CGVector(dx: point.x, dy: point.y)
        let coordinate = normalized.withOffset(offset)
        coordinate.tap()
    }
}
