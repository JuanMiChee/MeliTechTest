//
//  SearchViewModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
import UIKit

class SearchViewModel: ObservableObject {
  
  var viewContent: SearchResultViewContent = .init(results: [])
  
  struct Dependencies {
    let searchItemsUseCase: SearchItemsProtocol
    let downloadImageProtocol: DownloadImageProtocol
  }
  
  let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func searchItem(query: String) async {
    viewContent.results = await dependencies.searchItemsUseCase.execute(query: query)
  }
  
  func searchImage(url: URL) async -> UIImageView {
    dependencies.downloadImageProtocol.execute(url: url)
  }
}
