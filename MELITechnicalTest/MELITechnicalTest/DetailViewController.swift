//
//  DetailViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import UIKit

class DetailViewController: UIViewController {
  
  let item: ItemForViewModel
  
  let viewTitle = UILabel()
  let viewDetail = UILabel()
  let image = UIImage()
  
  init(item: ItemForViewModel) {
    self.item = item
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
    viewTitle.text = self.item.title
    viewTitle.textColor = .black
    viewTitle.font = UIFont.systemFont(ofSize: 20)
    viewTitle.textAlignment = .center
    view.addSubview(viewTitle)
  }
  
  func setupDetailLabel() {
    viewDetail.text = "\(self.item.price)"
    viewDetail.textColor = .black
    viewDetail.font = UIFont.systemFont(ofSize: 20)
    viewDetail.textAlignment = .center
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
      viewTitle.topAnchor.constraint(equalTo: viewTitle.topAnchor),
      viewDetail.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      viewDetail.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      viewDetail.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
  }
}
