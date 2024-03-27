//
//  searchResultViewContent.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
struct SearchResultViewContent: Equatable {
  static func == (lhs: SearchResultViewContent, rhs: SearchResultViewContent) -> Bool {
    return lhs.results == rhs.results
  }
  
  var results: [ItemModel]
}
