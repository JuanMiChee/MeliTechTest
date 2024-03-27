//
//  downloadImage.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import Foundation
import UIKit

protocol DownloadImageProtocol {
  func execute(url: URL) async throws -> UIImage
}

struct DownloadImage: DownloadImageProtocol {
  let netWorking: NetworkingMainFile
  func execute(url: URL) async throws -> UIImage {
    try await netWorking.downloadImage(url: url)
  }
}
