//
//  SearchItems.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

protocol SearchItemsProtocol {
  func execute(query: String) async throws -> [ItemModel]
}

struct SearchItems: SearchItemsProtocol {
  let netWorking: NetworkingMainFile
  func execute(query: String) async throws -> [ItemModel] {
    return try await netWorking.searchMercadoLibre(siteID: "MLC", query: query).results.map { item in
          ItemModel(id: item.id,
                    title: item.title,
                    thumbnail: item.thumbnail,
                    price: item.price,
                    acceptsMercadoPago: item.accepts_mercadopago,
                    seller: item.seller)
    }
  }
}
