//
//  DetailViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import UIKit

class ProductDetailViewController: UIViewController {
  let viewModel: DetailViewPresenter
  
  init(productViewModel: DetailViewPresenter) {
    self.viewModel = productViewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.numberOfLines = 0
    return label
  }()
  
  private let thumbnailImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let priceLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private let acceptsMercadoPagoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  private let sellerNicknameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupViews()
    configureView()
  }
  
  private func setupViews() {
    view.addSubview(stackView)
    stackView.addArrangedSubview(titleLabel)
    stackView.addArrangedSubview(thumbnailImageView)
    stackView.addArrangedSubview(priceLabel)
    stackView.addArrangedSubview(acceptsMercadoPagoLabel)
    stackView.addArrangedSubview(sellerNicknameLabel)
    
    // Configurar constraints para el stackView
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ])
    
    NSLayoutConstraint.activate([
      thumbnailImageView.widthAnchor.constraint(equalToConstant: 300), 
      thumbnailImageView.heightAnchor.constraint(equalToConstant: 300) 
    ])
  }
  
  private func configureView() {
    titleLabel.text = viewModel.viewContent.result.title
    priceLabel.text = "Price: \(viewModel.viewContent.result.price)"
    acceptsMercadoPagoLabel.text = viewModel.viewContent.result.acceptsMercadoPago ? "Accepta MercadoPago" : "No accepta MercadoPago"
    sellerNicknameLabel.text = "Seller: \(viewModel.viewContent.result.seller.nickname)"
    Task {
      thumbnailImageView.image = await viewModel.searchImage(url: viewModel.viewContent.result.thumbnail)
    }
  }
}
