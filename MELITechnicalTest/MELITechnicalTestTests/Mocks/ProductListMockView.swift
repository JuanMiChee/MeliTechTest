//
//  ProductListMockView.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation

class ProductListViewControllerMock: ProductListViewProtocol {
  var text: String? = nil
  var searchResults: SearchResultViewContent? = nil
  var alertText: String? = nil
  
  func showAlert(text: String) {
    self.alertText = text
  }
  
  func updateLoadingStatus(status: Bool) {
    
  }
  
  func showBackgroundText(text: String) {
    self.text = text
  }
  
  func refreshList(searchResults: SearchResultViewContent) {
    self.searchResults = searchResults
  }
}
