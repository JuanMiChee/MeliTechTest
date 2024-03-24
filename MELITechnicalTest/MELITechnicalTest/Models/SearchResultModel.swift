//
//  SearchResultModel.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 22/03/24.
//

import Foundation

struct SearchResult: Codable {
  let siteID: String
  let query: String
  let results: [Item]
  
  enum CodingKeys: String, CodingKey {
    case siteID = "site_id"
    case query = "query"
    case results = "results"
  }
}
