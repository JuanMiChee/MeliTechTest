//
//  NetworkingMock.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
import UIKit

class NetworkingMainFileMock {
  
  var error: Error? = nil
  var image: UIImage? = nil
  var searchResult: SearchResult? = nil
  var query: String? = nil
  var siteID: String? = nil
  
  func searchMercadoLibre(siteID: String, query: String) async throws -> SearchResult {
    self.query = query
    self.siteID = siteID
    
    if let error {
      throw error
    } else {
      return searchResult ?? .init(siteID: "",
                                   query: "",
                                   results: [])
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
