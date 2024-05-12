//
//  ArticleDetailViewController.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation
import UIKit

class ArticleDetailViewController: UIViewController {
    
    var article: NewsArticle?
    
    private var imageView: UIImageView!
    private var stackView: UIStackView!
    private var dateLabel: UILabel!
    private var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupImageView()
        setupStackView()
        setupDateLabel()
        setupContentLabel()
    }
    
    internal func setupImageView() {
        guard let urlString = article?.urlToImage else { return }
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalToConstant: 200) // Altura da imagem
            ])
        
        imageView.loadImage(fromURL: urlString)
    }
    
    internal func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }
    
    internal func setupDateLabel() {
        guard let publicationDate = article?.publishedAt else { return }
        
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = "Data de publicação: \(publicationDate)"
        stackView.addArrangedSubview(dateLabel)
    }
    
    internal func setupContentLabel() {
        guard let articleContent = article?.content else { return }
        
        contentLabel = UILabel()
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.text = articleContent
        contentLabel.numberOfLines = 0 // Permitir múltiplas linhas para o conteúdo
        stackView.addArrangedSubview(contentLabel)
    }
}

// Extension para carregar a imagem de uma URL
extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
