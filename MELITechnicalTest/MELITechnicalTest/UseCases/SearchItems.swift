//
//  SearchItems.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

protocol SearchItemsProtocol {
  func execute(query: String) async -> [String]
}

struct SearchItems: SearchItemsProtocol {
  let netWorking: NetworkingMainFile
  func execute(query: String) async -> [String] {
    var array: [String] = []
    do {
      array = try await netWorking.searchMercadoLibre(siteID: "MLA", query: query).results.map({ item in
        item.title
      })
    } catch {
      print("error: \(error)")
    }
    return array
  }
}