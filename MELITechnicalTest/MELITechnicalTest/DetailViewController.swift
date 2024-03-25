//
//  DetailViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import UIKit

class DetailViewController: UIViewController {
  
  let tittle: String
  let detail: String
  
  let viewTitle = UILabel()
  let viewDetail = UILabel()
  let image = UIImage()
  
  init(tittle: String, detail: String) {
    self.tittle = tittle
    self.detail = detail
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTitleLabel()
    setupDetailLabel()
    setupConstrains()
  }
  
  func setupTitleLabel() {
    viewTitle.text = self.tittle
    viewTitle.textColor = .black
    viewTitle.font = UIFont.systemFont(ofSize: 20)
    viewTitle.textAlignment = .center
    viewTitle.frame = CGRect(x: 90, y: 500, width: 200, height: 50)
    view.addSubview(viewTitle)
  }
  
  func setupDetailLabel() {
    viewDetail.text = self.detail
    viewDetail.textColor = .black
    viewDetail.font = UIFont.systemFont(ofSize: 20)
    viewDetail.textAlignment = .center
    viewDetail.frame = CGRect(x: 70, y: 450, width: 200, height: 50)
    view.addSubview(viewDetail)
  }
  
  func setupConstrains() {
    viewTitle.translatesAutoresizingMaskIntoConstraints = false
    viewDetail.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      viewTitle.topAnchor.constraint(equalTo: view.topAnchor),
      viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewTitle.bottomAnchor.constraint(equalTo: viewDetail.topAnchor),
    ])
    NSLayoutConstraint.activate([
      viewDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}
