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
  var timer = Timer()
  
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
  
  func searchImage(indexPath: Int) async -> UIImage {
    do {
      return try await dependencies.downloadImageProtocol.execute(url: URL(string: viewContent.results[indexPath].thumbnail)!)
    } catch {
      print(error.localizedDescription)
      return UIImage(named: "1")!
    }
  }
  
  func setBackgroundText(searchBarTextState: String) async -> String {
    if searchBarTextState == "" {
      viewContent.results = []
      return "Escribe algo :)"
    } else if await dependencies.searchItemsUseCase.execute(query: searchBarTextState) == [] {
      return "No items encontrados"
    } else {
      return ""
    }
  }
}
