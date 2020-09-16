//
//  SocarListData.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
//{
//    "id": 4,
//    "number": "232저222",
//    "name": "쏘나타 DN8(휘발유)",
//    "zone": 260,
//    "image": "https://sofastcar.s3.amazonaws.com/sonata-DN8.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIARUSCLZUQZUMFHN4N%2F20200915%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Date=20200915T043031Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=4064f0525fa2b34a9ccafe0abe48d033bba195f51ed1549fb6e7f4dcd09c4501",
//    "manufacturer": "현대자동차",
//    "fuel_type": "휘발유",
//    "type_of_vehicle": "중형",
//    "shift_type": "자동",
//    "riding_capacity": 5,
//    "is_event_model": false,
//    "manual_page": "https://blog.socar.kr/10268?category=724974",
//    "safety_option": "에어백, 후방 감지센서, 블랙박스, 지능형 운전 보조장치, 차선 이탈 방지",
//    "convenience_option": "에어컨,핸들 및 좌석 열선,통풍시트,AUX/USB,하이패스단말기,핸즈프리"
//},

struct SocarListData: Decodable {
    let next: SocarList?
    let previous: SocarList?
    let results: [SocarList]
}
struct SocarList: Decodable {
    let id: Double
    let number: String
    let name: String
    let zone: Double
    let image: String
    let manufacturer: String
    let fuelType: String
    let typeOfVehicle: String
    let shiftType: String
    let ridingCapa: Double
    let isEvent: Bool
    let manualPage: String
    let safetyOpt: String
    let convenienceOpt: String
    
    enum CodingKeys: String, CodingKey {
        case fuelType = "fuel_type"
        case typeOfVehicle = "type_of_vehicle"
        case shiftType = "shift_type"
        case ridingCapa = "riding_capacity"
        case isEvent = "is_event_model"
        case manualPage = "manual_page"
        case safetyOpt = "safety_option"
        case convenienceOpt = "convenience_option"
        case id
        case number
        case name
        case zone
        case image
        case manufacturer
    }
}
