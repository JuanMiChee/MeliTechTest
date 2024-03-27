//
//  SearchItemsMock.swift
//  MELITechnicalTestTests
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
@testable import MELITechnicalTest
import UIKit

class SearchItemsMock: SearchItemsProtocol {

  var error: Error? = nil
  var searchResults: [ItemModel]? = nil
  var query: String? = nil
  
  func execute(query: String) async throws -> [ItemModel] {
    self.query = query
    
    if let error {
      throw error
    } else {
      return searchResults ?? []
    }
  }
}
