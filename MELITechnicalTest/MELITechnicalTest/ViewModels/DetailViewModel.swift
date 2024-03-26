//
//  DetailViewModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
import UIKit

struct DetailViewModel {
  var viewContent: DetailResultViewContent = .init(result: ItemForViewModel(id: "",
                                                                            title: "",
                                                                            thumbnail: "",
                                                                            price: 0,
                                                                            acceptsMercadoPago: false,
                                                                            seller: Seller(id: 0,
                                                                                           nickname: "")))
  
  init(dependencies: Dependencies, viewContent: DetailResultViewContent) {
    self.viewContent = viewContent
    self.dependencies = dependencies
  }
  
  struct Dependencies {
    let downloadImageProtocol: DownloadImageProtocol
  }
  
  let dependencies: Dependencies
  
  func searchImage(url: String) async -> UIImage {
    do {
      return try await dependencies.downloadImageProtocol.execute(url: URL(string: url)!)
    } catch {
      print(error.localizedDescription)
      return UIImage(named: "1")!
    }
  }
}
