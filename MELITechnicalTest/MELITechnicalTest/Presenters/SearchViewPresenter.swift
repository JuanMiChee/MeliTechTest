//
//  SearchViewPresenter.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
import UIKit

protocol ProductListViewProtocol: AnyObject {
  func showBackgroundText(text: String)
  func refreshList(searchResults: SearchResultViewContent)
  func showAlert(text: String)
  func updateLoadingStatus(status: Bool)
}

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
        updateLoadingState(isLoading: true)
        viewContent.results = try await dependencies.searchItemsUseCase.execute(query: query)
        view?.refreshList(searchResults: viewContent)
        setBackgroundText(searchBarText: query)
        updateLoadingState(isLoading: false)
      } catch {
        showErrorAlert(text: error.localizedDescription)
      }
    }
  }
  
  func searchImage(indexPath: Int) async -> UIImage {
    do {
      let url = viewContent.results[indexPath].thumbnail
      updateLoadingState(isLoading: true)
      let image = try await dependencies.downloadImageProtocol.execute(url: url)
      updateLoadingState(isLoading: false)
      return image
    } catch {
      updateLoadingState(isLoading: false)
      view?.showAlert(text: error.localizedDescription)
      return UIImage(systemName: "eye.trianglebadge.exclamationmark")!
    }
  }
  
  private func showErrorAlert(text: String) {
    view?.showAlert(text: text)
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
  
  func updateLoadingState(isLoading: Bool) {
    view?.updateLoadingStatus(status: isLoading)
  }
  
  func showAlert(title: String, message: String, viewController: UIViewController) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    // Agregar un botón "OK" para cerrar la alerta
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    
    // Presentar la alerta
    viewController.present(alertController, animated: true, completion: nil)
  }
}
