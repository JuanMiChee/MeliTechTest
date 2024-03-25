//
//  ViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 21/03/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
  var tableView = UITableView()
  var searchBar = UISearchBar()
  var timer = Timer()
  var activityIndicator = UIActivityIndicatorView()
  var defaultBackgroundText = UILabel()
  
  let viewModel = SearchViewModel(dependencies: .init(searchItemsUseCase: SearchItems(netWorking: NetworkingMainFile())))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupSearchBar()
    setupDefaultBackgroundText()
    setupActivityIndicator()
    setupConstrains()
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    timer.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
      let cleanedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
      print("Texto cambiado en la barra de búsqueda: \(searchText)")
      Task {
        if let searchText = searchBar.text {
          if searchBar.text != "" {
            if !cleanedText.isEmpty {
              print("Se presionó el botón de búsqueda. Texto buscado: \(cleanedText)")
              self.activityIndicator.startAnimating()
              await self.viewModel.searchItem(query: cleanedText)
              self.defaultBackgroundText.text = ""
              self.activityIndicator.stopAnimating()
              self.tableView.reloadData()
            }
          }
        }
        if cleanedText == "" { 
          self.viewModel.viewContent.texts = []
          self.defaultBackgroundText.text = "typeSomething :)"
        } else if await self.viewModel.dependencies.searchItemsUseCase.execute(query: cleanedText) == [] {
            self.defaultBackgroundText.text = "No items found..."
          }
        self.tableView.reloadData()
      }
    }
  }
  
  func setupActivityIndicator() {
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .gray
    activityIndicator.center = view.center
    view.addSubview(activityIndicator)
  }
  
  func setupDefaultBackgroundText() {
    defaultBackgroundText.text = "typeSomething :)"
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
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
    cell.textLabel?.text = "\(viewModel.viewContent.texts[indexPath.row])"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.viewContent.texts.count
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    //Revisar si esto se debe pasar así
    let detailVC = DetailViewController(tittle: viewModel.viewContent.texts[indexPath.row], detail: "detalle")
    show(detailVC, sender: self)
  }
}

