//
//  ProductListViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 21/03/24.
//

import UIKit

protocol ProductListViewProtocol: AnyObject {
  func showBackgroundText(text: String)
  func refreshList(searchResults: SearchResultViewContent)
}

class ProductListViewController: UIViewController {
  
  var tableView = UITableView()
  var searchBar = UISearchBar()
  var timer = Timer()
  var activityIndicator = UIActivityIndicatorView()
  var defaultBackgroundText = UILabel()
  
  var result: SearchResultViewContent = .init(results: [])
  
  let viewPresenter = SearchViewPresenter(dependencies: .init(searchItemsUseCase: SearchItems(netWorking: NetworkingMainFile()),
                                                      downloadImageProtocol: DownloadImage(netWorking: NetworkingMainFile())))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewPresenter.view = self
    result = viewPresenter.viewContent
    view.backgroundColor = .systemYellow
    setupTableView()
    setupSearchBar()
    setupDefaultBackgroundText()
    setupActivityIndicator()
    setupConstrains()
  }
  
  //MARK: UISetup.
  func setupActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .gray
    activityIndicator.center = view.center
    view.addSubview(activityIndicator)
  }
  
  func setupDefaultBackgroundText() {
    defaultBackgroundText.text = "Escribe algo :)"
    defaultBackgroundText.textColor = .black
    defaultBackgroundText.font = UIFont.systemFont(ofSize: 20)
    defaultBackgroundText.textAlignment = .center
    defaultBackgroundText.frame = CGRect(x: 90, y: 500, width: 200, height: 50)
    view.addSubview(defaultBackgroundText)
  }
  
  func setupSearchBar() {
    searchBar.delegate = self
    searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 150)
    searchBar.placeholder = "Search"
    view.addSubview(searchBar)
  }
  
  func setupTableView() {
    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
  }
  
  //MARK: Constrains setup
  func setupConstrains() {
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      searchBar.bottomAnchor.constraint(equalTo: tableView.topAnchor),
    ])
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    
    NSLayoutConstraint.activate([
      defaultBackgroundText.topAnchor.constraint(equalTo: view.topAnchor),
      defaultBackgroundText.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      defaultBackgroundText.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      defaultBackgroundText.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}

extension ProductListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    timer.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
      let cleanedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
      Task {
          self.activityIndicator.startAnimating()
          await self.viewPresenter.searchItem(query: cleanedText)
          self.activityIndicator.stopAnimating()
          self.tableView.reloadData()
          self.tableView.reloadData()
      }
    }
  }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
    var content = cell.defaultContentConfiguration()
    content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
    
    Task {
      let image = await viewPresenter.searchImage(indexPath: indexPath.row)
      content.image = image
      
      content.text = "\(result.results[indexPath.row].title)"
      cell.contentConfiguration = content
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return result.results.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let detailVC = ProductDetailViewController(productViewModel: .init(dependencies: .init(downloadImageProtocol: DownloadImage(netWorking: NetworkingMainFile())), 
                                                                       viewContent: DetailResultViewContent(result: ItemModel(id: result.results[indexPath.item].id,
                                                                                                                              title: result.results[indexPath.item].title,
                                                                                                                              thumbnail: result.results[indexPath.item].thumbnail,
                                                                                                                              price: result.results[indexPath.item].price,
                                                                                                                              acceptsMercadoPago: result.results[indexPath.item].acceptsMercadoPago,
                                                                                                                              seller: result.results[indexPath.item].seller))))
    show(detailVC, sender: self)
  }
}

extension ProductListViewController: ProductListViewProtocol {
  func refreshList(searchResults: SearchResultViewContent) {
    self.result = searchResults
    tableView.reloadData()
  }
  
  func showBackgroundText(text: String) {
    self.defaultBackgroundText.text = text
  }
}

