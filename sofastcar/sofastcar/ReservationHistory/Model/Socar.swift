//
//  Socar.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct Socar: Decodable {
    let socarUid: Double
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
    var carPrices: CarPrices
  
    enum CodingKeys: String, CodingKey {
        case fuelType = "fuel_type"
        case typeOfVehicle = "type_of_vehicle"
        case shiftType = "shift_type"
        case ridingCapa = "riding_capacity"
        case isEvent = "is_event_model"
        case manualPage = "manual_page"
        case safetyOpt = "safety_option"
        case convenienceOpt = "convenience_option"
        case carPrices = "car_prices"
        case socarUid = "id"
        case number
        case name
        case zone
        case image
        case manufacturer
    }
}

extension Socar {
  
  static func getSocar(_ socarID: Int, _ socarZoneID: Int) -> Resource<Socar> {
    let carUrl = URL(string: "https://sofastcar.moorekwon.xyz/carzones/\(socarZoneID)/cars/\(socarID)/info")!
    return Resource(url: carUrl)
  }
  
}
