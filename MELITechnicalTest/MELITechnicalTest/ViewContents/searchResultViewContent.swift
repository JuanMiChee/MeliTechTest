//
//  searchResultViewContent.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation
struct SearchResultViewContent: Equatable {
  static func == (lhs: SearchResultViewContent, rhs: SearchResultViewContent) -> Bool {
    true
  }
  
  var results: [ItemForViewModel]
}
