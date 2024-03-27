//
//  ItemModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

struct ItemModel: Codable, Equatable {
  static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
    return lhs.id == rhs.id &&
    lhs.title == rhs.title &&
    lhs.thumbnail == rhs.thumbnail &&
    lhs.price == rhs.price &&
    lhs.acceptsMercadoPago == rhs.acceptsMercadoPago &&
    lhs.seller == rhs.seller
  }
  
  let id: String
  let title: String
  let thumbnail: String
  let price: Double
  let acceptsMercadoPago: Bool
  let seller: Seller
}
