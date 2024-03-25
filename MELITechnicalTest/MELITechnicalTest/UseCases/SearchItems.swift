//
//  SearchItems.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

protocol SearchItemsProtocol {
  func execute(query: String) async -> [ItemForViewModel]
}

struct SearchItems: SearchItemsProtocol {
  let netWorking: NetworkingMainFile
  func execute(query: String) async -> [ItemForViewModel] {
    var array: [ItemForViewModel] = []
    do {
      array = try await netWorking.searchMercadoLibre(siteID: "MLA", query: query).results.map({ item in
        ItemForViewModel(id: item.id,
                         title: item.title,
                         thumbnail: item.thumbnail,
                         price: item.price,
                         officialStoreName: item.officialStoreName,
                         acceptsMercadoPago: item.acceptsMercadoPago,
                         seller: item.seller)
      })
    } catch {
      print("error: \(error)")
    }
    return array
  }
}
