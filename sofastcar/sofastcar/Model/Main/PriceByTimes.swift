//
//  PriceByTimes.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/10/03.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct PriceByTimes: Decodable {
    let id: Int
    let name: String
    let subInfo: String
    let type: String
    let cars: [Cars]
    let timeTables: [TimeTables]
    
    enum CodingKeys: String, CodingKey {
        case subInfo = "sub_info"
        case id
        case name
        case type
        case cars
        case timeTables = "time_tables"
    }
}

struct Cars: Decodable {
    let id: Int
    let name: String
    let termPrice: Int
    let insurancePrices: InsurancePrice
    
    enum CodingKeys: String, CodingKey {
        case termPrice = "term_price"
        case insurancePrices = "insurance_prices"
        case id
        case name
    }
}

struct InsurancePrice: Decodable {
    let special: Int
    let standard: Int
    let light: Int
}

struct TimeTables: Decodable {
    let id: Int
    let zone: Int
    let car: Int
    let dateTimeStart: String
    let dateTimeEnd: String

    enum CodingKeys: String, CodingKey {
        case dateTimeStart = "date_time_start"
        case dateTimeEnd = "date_time_end"
        case id
        case zone
        case car
    }
}
