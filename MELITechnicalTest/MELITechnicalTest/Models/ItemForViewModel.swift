//
//  ItemForViewModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

struct ItemForViewModel: Codable, Equatable {
  static func == (lhs: ItemForViewModel, rhs: ItemForViewModel) -> Bool {
    return lhs.id == rhs.id &&
    lhs.title == rhs.title &&
    lhs.thumbnail == rhs.thumbnail &&
    lhs.price == rhs.price &&
    lhs.officialStoreName == rhs.officialStoreName &&
    lhs.acceptsMercadoPago == rhs.acceptsMercadoPago &&
    lhs.seller == rhs.seller
  }
  
  let id: String
  let title: String
  let thumbnail: String
  let price: Double
  let officialStoreName: String
  let acceptsMercadoPago: Bool
  let seller: Seller
}
