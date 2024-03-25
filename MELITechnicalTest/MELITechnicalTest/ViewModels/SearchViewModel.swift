//
//  SearchViewModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

class SearchViewModel: ObservableObject {
  
  var viewContent: SearchResultViewContent = .init(texts: [""])
  
  struct Dependencies {
    let searchItemsUseCase: SearchItemsProtocol
  }
  
  let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func searchItem(query: String) async {
    viewContent.texts = await dependencies.searchItemsUseCase.execute(query: query)
  }
}
