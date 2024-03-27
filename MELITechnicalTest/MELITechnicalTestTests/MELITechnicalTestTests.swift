//
//  MELITechnicalTestTests.swift
//  MELITechnicalTestTests
//
//  Created by Juan Harrington on 21/03/24.
//

import XCTest
@testable import MELITechnicalTest
@MainActor
final class MELITechnicalTestTests: XCTestCase {
  
  
  
  var sut: SearchViewPresenter!
  
  var view: ProductListViewControllerMock!
  var searchItemMock: SearchItemsMock!
  var searchImageMock: DownloadImageMock!
  
  
  var networking: NetworkingMainFileMock!
  
  override func setUpWithError() throws {
    view = ProductListViewControllerMock()
    searchItemMock = SearchItemsMock()
    searchImageMock = DownloadImageMock()
    
    //sut instantiation
    sut = SearchViewPresenter(dependencies: .init(searchItemsUseCase: searchItemMock, downloadImageProtocol: searchImageMock))
    sut.view = view
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  
  func testVerifySearchUseCaseRecivesQuery() async throws {
    //Given
    let currentSeachbarQuery: String = "iphone"
    await sut.searchItem(query: currentSeachbarQuery)
    
    //When
    let useCaseData = searchItemMock.query
    
    //then
    XCTAssertEqual(useCaseData, "iphone")
  }
  
  func testVerifyGetImageUseCaseRecivesUrl() async throws {
    //Given
    let currentItem: [ItemModel] = [ItemModel(id: "", title: "", thumbnail: URL(string: "someUrl")!, price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]
    
    //When
    sut.viewContent.results = currentItem
    let _ =  await sut.searchImage(indexPath: 0)
    
    
    //then
    let useCaseData = searchImageMock.url
    XCTAssertEqual(useCaseData, URL(string: "someUrl"))
  }
  
  func testVerifyDataIsNotGettingToView() async throws {
    //Given
    let currentSeachbarQuery: String = "iphone"
    await sut.searchItem(query: currentSeachbarQuery)
    
    //When
    let viewData = view.text
    
    //then
    XCTAssertEqual(viewData, "No items encontrados")
  }
  
  func testVerifyDataIsNotGettingToViewTwo() async throws {
    //Given
    let currentSeachbarQuery: String = "iphone"
    await sut.searchItem(query: currentSeachbarQuery)
    
    //When
    let viewData = view.searchResults
    
    //then
    XCTAssertEqual(viewData, SearchResultViewContent(results: []))
  }
  
  func testVerifyDataIsGettingToView() async throws {
    //Given
    let currentSeachbarQuery: String = "iphone"
    searchItemMock.searchResults = [makeItem()]
    
    //When
    await sut.searchItem(query: currentSeachbarQuery)
    
    //then
    let viewData = view.searchResults
    XCTAssertEqual(viewData, SearchResultViewContent(results: [makeItem()]))
  }
  
  func testVerifySeachrItemsIsReturningCorrectly() async {
    //Given
    let currentItem: [ItemModel] = [makeItem()]
    searchItemMock.searchResults = currentItem
    
    //When
    await sut.searchItem(query: "Some")
    
    //then
    let useCaseData = searchItemMock.searchResults
    XCTAssertEqual(useCaseData, [makeItem()])
  }
  
  func testVeirfyCouldNotFetchItemsWithError() async {
    let errorDescription = NSLocalizedString("Ocurrió un error al cargar los datos.", comment: "Mensaje de error")
    let error = NSError(domain: "com.tuapp.errorDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorDescription])
    searchItemMock.error = error
    
    //When
    await sut.searchItem(query: "q")

    //then
    let viewData = view.alertText
    XCTAssertEqual(viewData, "Ocurrió un error al cargar los datos.")
  }
  
  func testVeirfyCouldNotFetchImageWithError() async {
    let errorDescription = NSLocalizedString("Ocurrió un error al cargar los datos.", comment: "Mensaje de error")
    let error = NSError(domain: "com.tuapp.errorDomain", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorDescription])
    searchImageMock.error = error
    
    let currentItem: [ItemModel] = [makeItem()]
    
    //When
    sut.viewContent.results = currentItem
    
    //When
    let _ = await sut.searchImage(indexPath: 0)
    
    //then
    let viewData = view.alertText
    XCTAssertEqual(viewData, "Ocurrió un error al cargar los datos.")
  }
  
  private func makeItem() -> ItemModel{
    ItemModel(id: "", title: "", thumbnail: URL(string: "someUrl")!, price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))
  }
}
