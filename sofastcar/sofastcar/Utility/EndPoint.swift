//
//  EndPoint.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/13.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

struct EndPoint {
    let baseURL = "https://sofastcar.moorekwon.xyz/carzones"
    let path: Path
    let query: QueryItems
    
    init(path: Path, query: QueryItems) {
        self.path = path
        self.query = query
    }
    
    func combineURL() -> URL? {
        guard var components = URLComponents(string: baseURL) else { fatalError() }
        components.path = "/carzones/\(path.rawValue)"
        components.queryItems = query.map({ (queryItem) -> URLQueryItem in
            let (key, value) = queryItem
            return URLQueryItem(name: key.rawValue, value: value)
        })
//        print("endpoint components: \(components)")
        return components.url
    }
    
}

extension EndPoint {
    enum Path: String {
        case distance
    }
    enum Querykey: String {
        case lat
        case lon
        case distance
    }
    typealias QueryItems = [Querykey: String]
}
