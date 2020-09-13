//
//  ResultData.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

//struct SocarZoneData {
//    let distance = [100, 200, 300, 400, 500]
//    let symbols = ["mappin.circle.fill", "mappin.circle"]
//    let imageName = ["무악재역", "당산역", "서초역", "잠실새내"]
//    let name = ["패스트 캠퍼스 강남점", "패스트 캠퍼스 성수점"]
//    let groundLevel = ["지상", "지하"]
//    let discription = ["2호선 성수역 2번 출구 앞"]
//    let addr = ["서울시 강남구 강남로 111번길 8", "서울시 성동구 성수로 3가 123번길 90"]
//}

//{
//  "id": 240,
//  "zone_id": "X0000108",
//  "name": "복정역 공영주차장",
//  "address": "서울 송파구 장지동 561-55",
//  "region": "seoul",
//  "latitude": 37.469361,
//  "longitude": 127.1259747,
//  "sub_info": "복정역",
//  "detail_info": "지상 1층",
//  "type": "지상",
//  "operating_time": "24시간"
//}
//{
//  "id": 240,
//  "name": "복정역 공영주차장",
//  "address": "서울 송파구 장지동 561-55",
//  "region": "SEOUL",
//  "latitude": 37.469361,
//  "longitude": 127.1259747,
//  "sub_info": "복정역",
//  "detail_info": "지상 1층",
//  "type": "지상",
//  "operating_time": "24시간"
//}
struct SocarZoneData: Decodable {
    let id: Int
    let name: String
    let address: String
    let region: String
    let lat: Double
    let lng: Double
    let subInfo: String
    let detailInfo: String
    let type: String
    let operTime: String
    
    enum CodingKeys: String, CodingKey {
        case lat = "latitude"
        case lng = "longitude"
        case subInfo = "sub_info"
        case detailInfo = "detail_info"
        case operTime = "operating_time"
        case id
        case name
        case address
        case region
        case type
    }
}

//{
//  "id": 255,
//  "zone_id": "SN0000014",
//  "name": "강변건영아파트 101동",
//  "address": "서울 성동구 성수동1가 710 강변 건영아파트 101동 지하2층 44~46번 구역",
//  "region": "seoul",
//  "latitude": 37.540323,
//  "longitude": 127.042847,
//  "sub_info": "강변건영아파트",
//  "detail_info": "지하 2층 44~46번 구역",
//  "type": "지하",
//  "operating_time": "24시간"
//},

struct SocarZoneData2: Decodable {
    let id: Int
    let zoneId: String
    let name: String
    let address: String
    let region: String
    let lat: Double
    let lng: Double
    let subInfo: String
    let detailInfo: String
    let type: String
    let operTime: String
    
    enum CodingKeys: String, CodingKey {
        case zoneId = "zone_id"
        case lat = "latitude"
        case lng = "longitude"
        case subInfo = "sub_info"
        case detailInfo = "detail_info"
        case operTime = "operating_time"
        case id
        case name
        case address
        case region
        case type
    }
}
