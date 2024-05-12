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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // Exibir a imagem do artigo, se disponível
        if let urlString = article?.urlToImage {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            imageView.loadImage(fromURL: urlString)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                imageView.heightAnchor.constraint(equalToConstant: 200) // Altura da imagem
                ])
            
            // Exibir a data de publicação do artigo
            if let publicationDate = article?.publishedAt {
                let dateLabel = UILabel()
                dateLabel.translatesAutoresizingMaskIntoConstraints = false
                dateLabel.text = "Data de publicação: \(publicationDate)"
                view.addSubview(dateLabel)
                
                NSLayoutConstraint.activate([
                    dateLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                    dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                    ])
                
                // Exibir o conteúdo do artigo
                if let articleContent = article?.content {
                    let contentLabel = UILabel()
                    contentLabel.translatesAutoresizingMaskIntoConstraints = false
                    contentLabel.text = articleContent
                    contentLabel.numberOfLines = 0 // Permitir múltiplas linhas para o conteúdo
                    view.addSubview(contentLabel)
                    
                    NSLayoutConstraint.activate([
                        contentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
                        contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                        contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                        contentLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                        ])
                }
            }
        }
    }
}

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
