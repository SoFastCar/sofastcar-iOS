//
//  SocaZoneProvidable.swift
//  
//
//  Created by Woobin Cheon on 2020/09/14.
//

import Foundation

protocol SocarZoneProvidable {
  func fetchSocarZoneData<T>( // T는 Decodable 프로토콜을 채택하기만 하면 어떤 타입이든 상관없다 => 제네릭
    endpoint: EndPoint,
    completionHandler: @escaping (Result<T, ServiceError>) -> Void
  ) where T: Decodable
}
