//
//  InsuranceData.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/16.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct InsuranceDataList: Decodable {
    let items: [InsuranceData]
}

struct InsuranceData: Decodable {
    let name: String
    let guarantee: Int
    let cost: Int
}
