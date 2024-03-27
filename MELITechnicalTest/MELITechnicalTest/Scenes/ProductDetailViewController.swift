//
//  DetailViewController.swift
//  MELITechnicalTest
//
//  Created by Juan Harrington on 25/03/24.
//

import UIKit

protocol DetailViewProtocol: AnyObject {
  @MainActor
  func setUpViewData(title: String, price: String, acceptsMercadoPago: String, sellerNickName: String, thumnailImage: UIImage)
}

@MainActor
class ProductDetailViewController: UIViewController {
  var viewPresenter: DetailViewPresenter
  
  init(productViewModel: DetailViewPresenter) {
    self.viewPresenter = productViewModel
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
    viewPresenter.view = self
    view.backgroundColor = .white
    setupViews()
    viewPresenter.handleViewDidLoad()
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
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    NSLayoutConstraint.activate([ 
      thumbnailImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 300)
    ])
  }
  
  
}

extension ProductDetailViewController: DetailViewProtocol {
  func setUpViewData(title: String, price: String, acceptsMercadoPago: String, sellerNickName: String, thumnailImage: UIImage) {
    titleLabel.text = title
    priceLabel.text = price
    acceptsMercadoPagoLabel.text = acceptsMercadoPago
    sellerNicknameLabel.text = sellerNickName
    thumbnailImageView.image = thumnailImage
  }
}
