//
//  SearchItems.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

protocol SearchItemsProtocol {
  func execute() async -> [String]
}

struct SearchItems: SearchItemsProtocol {
  let netWorking: NetworkingMainFile
  func execute() async -> [String] {
    var array: [String] = []
    do {
      array = try await netWorking.searchMercadoLibre(siteID: "MLA", query: "motorola").results.map({ item in
        item.title
      })
    } catch {
      print("error: \(error)")
    }
    return array
  }
}
