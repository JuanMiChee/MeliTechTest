//
//  DetailViewPresenter.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 26/03/24.
//

import Foundation
import UIKit

struct DetailViewPresenter {
  private let viewContent: DetailResultViewContent
  
  weak var view: DetailViewProtocol?
  
  init(dependencies: Dependencies, viewContent: DetailResultViewContent) {
    self.viewContent = viewContent
    self.dependencies = dependencies
  }
  
  struct Dependencies {
    let downloadImage: DownloadImageProtocol
  }
  
  let dependencies: Dependencies
  
  func searchImage(url: URL) async -> UIImage {
    do {
      return try await dependencies.downloadImage.execute(url: url)
    } catch {
      print(error.localizedDescription)
      return UIImage(named: "1")!
    }
  }
  
  func handleViewDidLoad() {
    Task {
      await setUpViewData()
    }
  }
  
  private func setUpViewData() async {
    await view?.setUpViewData(title: viewContent.result.title,
                        price: "precio: \(viewContent.result.price)",
                        acceptsMercadoPago: viewContent.result.acceptsMercadoPago ? "Acepta MercadoPago" : "No acepta MercadoPago",
                        sellerNickName: viewContent.result.seller.nickname,
                        thumnailImage: await searchImage(url: viewContent.result.thumbnail))
  }
}
