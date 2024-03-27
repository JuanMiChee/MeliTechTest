//
//  DownloadImageMock.swift
//  MELITechnicalTestTests
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
@testable import MELITechnicalTest
import UIKit

@MainActor
class DownloadImageMock: DownloadImageProtocol {
  
  let error: Error? = nil
  let image: UIImage? = nil
  var url: URL? = nil
  
  func execute(url: URL) async throws -> UIImage {
    
    self.url = url
    
    if let error {
      throw error
    } else {
      return image ?? .init()
    }
  }
}
