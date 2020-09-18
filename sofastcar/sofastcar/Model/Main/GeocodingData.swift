//
//  GeocodingData.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct GeocodingDate: Decodable {
    let status: Status
    let results: [Results]
}

struct Status: Decodable {
    let code: Int
    let name: String
    let message: String
}

struct Results: Decodable {
//    let land: Land
    let region: Region
}

struct Land: Decodable {
    let name: String
    let number1: String
}

struct Region: Decodable {
//    let area0: Area
//    let area1: Area
//    let area2: Area
    let area3: Area
//    let area4: Area
}

struct Area: Decodable {
    let name: String
}
