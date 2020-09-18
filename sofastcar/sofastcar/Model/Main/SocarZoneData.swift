//
//  ResultData.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/08.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

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
    let image: String?
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
        case image
        case type
    }
}
