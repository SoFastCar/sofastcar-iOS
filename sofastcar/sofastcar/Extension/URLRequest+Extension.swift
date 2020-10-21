//
//  URLRequest+Extension.swift
//  sofastcar
//
//  Created by 김광수 on 2020/10/20.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct Resource<T: Decodable> {
  let url: URL
}

extension URLRequest {
  
  static func load<T>(resource: Resource<T>) -> Observable<T?> {
    
    return Observable.from([resource.url])
      .flatMap { url -> Observable<Data> in
        guard let request = try? URLRequest(url: url, method: .get, headers: ["Content-Type": "application/json", "Authorization": "JWT \(UserDefaults.getUserAuthTocken()!)"]) else { fatalError("Error Load In URLRequest") }
        return URLSession.shared.rx.data(request: request)
      }.map { data -> T? in
        return try? JSONDecoder().decode(T.self, from: data)
      }.asObservable()
  }
  
}
