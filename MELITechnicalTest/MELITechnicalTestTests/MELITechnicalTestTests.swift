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
  var downloadImageMock: DownloadImageMock!
  
  
  var networking: NetworkingMainFileMock!
  
  override func setUpWithError() throws {
    view = ProductListViewControllerMock()
    searchItemMock = SearchItemsMock()
    downloadImageMock = DownloadImageMock()
    
    //sut instantiation
    sut = SearchViewPresenter(dependencies: .init(searchItemsUseCase: searchItemMock, downloadImageProtocol: downloadImageMock))
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
    let currentItem: [ItemModel] = [ItemModel(id: "", title: "", thumbnail: "someUrl", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]
    
    //When
    
    sut.viewContent.results = currentItem
    await sut.searchImage(indexPath: 0)
    
    
    //then
    let useCaseData = downloadImageMock.url
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
    searchItemMock.searchResults = [ItemModel(id: "123", title: "", thumbnail: "", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]
    
    //When
    await sut.searchItem(query: currentSeachbarQuery)
    
    //then
    let viewData = view.searchResults
    XCTAssertEqual(viewData, SearchResultViewContent(results: [ItemModel(id: "123", title: "", thumbnail: "", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]))
  }
  
  func testVerifySeachrItemsIsReturningCorrectly() async {
    //Given
    let currentItem: [ItemModel] = [ItemModel(id: "", title: "", thumbnail: "someUrl", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]
    searchItemMock.searchResults = currentItem
    
    //When
    await sut.searchItem(query: "Some")
    
    //then
    let useCaseData = searchItemMock.searchResults
    XCTAssertEqual(useCaseData, [ItemModel(id: "", title: "", thumbnail: "someUrl", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))])
  }
  
  func testVeirfyCouldNotFetchItemsError() async {
    let currentItem: [ItemModel] = [ItemModel(id: "", title: "", thumbnail: "someUrl", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))]
    searchItemMock.searchResults = currentItem
    
    //When
    await sut.searchItem(query: "Some")
    
    //then
    let useCaseData = searchItemMock.searchResults
    XCTAssertEqual(useCaseData, [ItemModel(id: "", title: "", thumbnail: "someUrl", price: 0, acceptsMercadoPago: false, seller: Seller(id: 0, nickname: ""))])
  }
}
