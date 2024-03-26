//
//  DetailViewContent.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation

struct DetailResultViewContent: Equatable {
  static func == (lhs: DetailResultViewContent, rhs: DetailResultViewContent) -> Bool {
    return lhs.result == rhs.result
  }
  
  var result: ItemForViewModel
}
