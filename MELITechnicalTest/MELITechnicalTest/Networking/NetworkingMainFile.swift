//
//  NetworkingMainFile.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

import Foundation

struct NetworkingMainFile {
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
  
  // Uso de la función
  let siteID = "MCO" // Puedes cambiar esto según el sitio de MercadoLibre que desees
  let query = "Motorola G6"
  //searchMercadoLibre(siteID: siteID, query: query) { result in
  //  switch result {
  //  case .success(let searchResult):
  //    print("Resultados de la búsqueda:")
  //    for item in searchResult.results {
  //      print("ID: \(item.id), Título: \(item.title), Precio: \(item.price)")
  //    }
  //  case .failure(let error):
  //    print("Error al realizar la búsqueda:", error)
  //  }
  //}
}
