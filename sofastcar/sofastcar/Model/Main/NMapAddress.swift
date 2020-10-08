//
//  NMapAddress.swift
//  sofastcar
//
//  Created by 김광수 on 2020/09/15.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct NMapAddress: Decodable {
    let addresses: [DetailAddress]
}
struct DetailAddress: Decodable {
    let roadAddress: String
    let jibunAddress: String
}

struct SearchResult: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let title: String
    let address: String
}

// 카카오 키워드 장소 검색

struct SearchResultData: Decodable {
    let documents: [Document]
}
struct Document: Decodable {
    let placeName: String
    let distance: String
    let roadAddress: String
    let lat: String
    let lng: String
    
    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case roadAddress = "road_address_name"
        case lat = "y"
        case lng = "x"
        case distance
    }
}
