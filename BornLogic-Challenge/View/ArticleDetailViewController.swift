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
    
    private var imageView: UIImageView?
    private var stackView: UIStackView?
    private var dateLabel: UILabel?
    private var noImageView: UIView?
    private var contentLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupStackView()
        setupImageView()
        setupDateLabel()
        setupContentLabel()
    }
    
    internal func setupStackView() {
        stackView = UIStackView()
        stackView?.axis = .vertical
        stackView?.spacing = 8
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView!)
        
        NSLayoutConstraint.activate([
            stackView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView!.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView!.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }
    
    internal func setupImageView() {
        if let urlString = article?.urlToImage {
            // Verifica se há uma imagem salva no UserDefaults
            if let savedImageData = UserDefaults.standard.data(forKey: urlString),
                let savedImage = UIImage(data: savedImageData) {
                // Se a imagem estiver disponível, carrega-a
                imageView = UIImageView(image: savedImage)
            } else {
                // Caso contrário, carrega a imagem da URL
                imageView = UIImageView()
                imageView?.contentMode = .scaleAspectFit
                imageView?.translatesAutoresizingMaskIntoConstraints = false
                stackView?.addArrangedSubview(imageView!)
                
                NSLayoutConstraint.activate([
                    imageView!.heightAnchor.constraint(equalToConstant: 200) // Altura da imagem
                    ])
                
                imageView!.loadImage(fromURL: urlString)
            }
        } else {
            showNoImagePlaceholder()
        }
        
    }
    
    internal func showNoImagePlaceholder() {
        let grayView = UIView()
        grayView.translatesAutoresizingMaskIntoConstraints = false
        grayView.backgroundColor = UIColor.lightGray
        stackView?.addArrangedSubview(grayView)
        
        let emojiLabel = UILabel()
        emojiLabel.text = "🚫"
        emojiLabel.font = UIFont.systemFont(ofSize: 60)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        emojiLabel.textAlignment = .center
        grayView.addSubview(emojiLabel)
        
        NSLayoutConstraint.activate([
            grayView.heightAnchor.constraint(equalToConstant: 200), // Altura da view
            emojiLabel.centerXAnchor.constraint(equalTo: grayView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: grayView.centerYAnchor)
            ])
    }



    
    internal func setupDateLabel() {
        guard let publicationDate = article?.publishedAt else { return }
        
        dateLabel = UILabel()
        dateLabel?.translatesAutoresizingMaskIntoConstraints = false
        dateLabel?.numberOfLines = 1
        dateLabel?.text = "Data: \(publicationDate)"
        if let dateLabel = dateLabel {
            stackView?.addArrangedSubview(dateLabel)
        }
    }
    
    internal func setupContentLabel() {
        if let articleContent = article?.content, !articleContent.isEmpty {
            contentLabel = UILabel()
            contentLabel?.translatesAutoresizingMaskIntoConstraints = false
            contentLabel?.text = articleContent
            contentLabel?.numberOfLines = 0
            if let contentLabel = contentLabel {
                stackView?.addArrangedSubview(contentLabel)
            }
        } else {
            // Caso não haja descrição disponível, adicionar um texto informativo
            let noDescriptionLabel = UILabel()
            noDescriptionLabel.text = "Sem descrição disponível."
            noDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            
            stackView?.addArrangedSubview(noDescriptionLabel)
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
