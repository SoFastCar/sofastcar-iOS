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
    let land: Land
}

struct Land: Decodable {
    let type: String
    let name: String
    let number1: String
}
