//
//  ItemModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

struct Item: Codable {
  let id: String
  let title: String
  let thumbnail: String
  let price: Double
  let officialStoreName: String
  let acceptsMercadoPago: Bool
  let seller: Seller
}
