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
  
  func showAlert(text: String) {
    
  }
  
  func showBackgroundText(text: String) {
    self.text = text
  }
  
  func refreshList(searchResults: SearchResultViewContent) {
    self.searchResults = searchResults
  }
}
