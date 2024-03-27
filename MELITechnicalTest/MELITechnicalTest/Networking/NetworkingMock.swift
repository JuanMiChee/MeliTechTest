//
//  NetworkingMock.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
import UIKit

struct NetworkingMainFileMock {
  
  let error: Error?
  let image: UIImage?
  let searchResult: SearchResult?
  
  func searchMercadoLibre(siteID: String, query: String) async throws -> SearchResult {
    if let error {
      throw error
    } else {
      return searchResult ?? .init(siteID: "",
                                   query: "",
                                   results: [ItemJSON(id: "",
                                                  title: "",
                                                  thumbnail: "",
                                                  price: 0,
                                                  accepts_mercadopago: false,
                                                  seller: Seller(id: 0,
                                                                 nickname: ""))])
    }
  }
  
  func downloadImage(url: URL) async throws -> UIImage {
    if let error {
      throw error
    } else {
      return image ?? .init()
    }
  }
}
