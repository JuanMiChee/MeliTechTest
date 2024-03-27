//
//  SearchViewPresenter.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
import UIKit

@MainActor
class SearchViewPresenter: ObservableObject {
  
  weak var view: ProductListViewProtocol?
  
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
    if query.isEmpty {
      view?.refreshList(searchResults: .init(results: []))
      setBackgroundText(searchBarText: "")
    } else {
      do {
        viewContent.results = try await dependencies.searchItemsUseCase.execute(query: query)
        view?.refreshList(searchResults: viewContent)
        setBackgroundText(searchBarText: query)
      } catch {
        print("error: \(error)")
      }
    }
  }
  
  func searchImage(indexPath: Int) async -> UIImage {
    do {
      return try await dependencies.downloadImageProtocol.execute(url: URL(string: viewContent.results[indexPath].thumbnail)!)
    } catch {
      print(error.localizedDescription)
      return UIImage(named: "1")!
    }
  }
  
  private func setBackgroundText(searchBarText: String) {
    if searchBarText == "" {
      view?.refreshList(searchResults: .init(results: []))
      view?.showBackgroundText(text: "Escribe algo.")
    } else if viewContent.results.isEmpty {
      view?.showBackgroundText(text:  "No items encontrados")
    } else {
      view?.showBackgroundText(text: "")
    }
  }
}
