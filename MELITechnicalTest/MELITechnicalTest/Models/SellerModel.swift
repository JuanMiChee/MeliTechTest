//
//  SellerModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import Foundation

struct Seller: Codable, Equatable {
  let id: Int
  let nickname: String
  
  static func == (lhs: Seller, rhs: Seller) -> Bool {
    return lhs.id == rhs.id && lhs.nickname == rhs.nickname
  }
}
