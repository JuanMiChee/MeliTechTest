//
//  NetworkingMainFile.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
import UIKit

struct NetworkingMainFile {
  
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
  
  func downloadImage(url: URL) -> UIImageView {
    var imageToReturn: UIImageView = UIImageView()
    let task = session.dataTask(with: url) { data, response, error in
      if let error = error {
        print("Error al descargar la imagen: \(error.localizedDescription)")
        return
      }
      guard let data = data else {
        print("No se recibieron datos de la imagen")
        return
      }
      if let image = UIImage(data: data) {
        DispatchQueue.main.async {
          let imageView = UIImageView(image: image)
          imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
          imageToReturn = imageView
        }
      } else {
        print("No se pudo crear la imagen desde los datos")
      }
    }
    return imageToReturn
  }
}
