//
//  ViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 21/03/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  

  var tableView: UITableView!
  
  let viewModel = SearchViewModel(dependencies: .init(searchItemsUseCase: SearchItems(netWorking: NetworkingMainFile())))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView = UITableView(frame: view.bounds, style: .plain)
    tableView.delegate = self
    tableView.dataSource = self
    view.addSubview(tableView)
    
    Task {
      await viewModel.searchItem()
      tableView.reloadData()
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
    
    // Configura el contenido de la celda (puedes cambiarlo según tus necesidades)
    cell.textLabel?.text = "Fila \(viewModel.viewContent.texts[indexPath.row])"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.viewContent.texts.count
  }
}

