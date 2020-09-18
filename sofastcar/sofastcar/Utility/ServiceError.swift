//
//  ServiceError.swift
//  sofastcar
//
//  Created by Woobin Cheon on 2020/09/14.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

enum ServiceError: Error {
  case invalidURL
  case clientError(Error)
  case invalidStatusCode
  case noData
  case decodingError(Error)
}
