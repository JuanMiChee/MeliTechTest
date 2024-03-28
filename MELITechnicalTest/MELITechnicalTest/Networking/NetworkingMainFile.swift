//
//  NetworkingMainFile.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
import UIKit

struct NetworkingMainFile: NetworkingProtocol {
  
  let session = URLSession.shared
  
  func searchMercadoLibre(siteID: String, query: String) async throws -> SearchResult {
    let urlString = "https://api.mercadolibre.com/sites/\(siteID)/search?q=\(query)"
    guard let url = URL(string: urlString) else {
      throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    do {
      let decoder = JSONDecoder()
      let searchResult = try decoder.decode(SearchResult.self, from: data)
      return searchResult
    } catch {
      throw error
    }
  }
  
  func downloadImage(url: URL) async throws -> UIImage {
    let (data, _) = try await URLSession.shared.data(from: url)
    guard let image = UIImage(data: data) else {
      throw ImageDownloadError.failedToCreateImage
    }
    return image
  }
  
  enum ImageDownloadError: Error {
    case failedToCreateImage
  }
}
