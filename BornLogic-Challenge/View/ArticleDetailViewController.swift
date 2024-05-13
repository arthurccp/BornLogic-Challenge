//
//  ArticleDetailViewController.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

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
    
    internal var imageView: UIImageView?
    internal var stackView: UIStackView?
    internal var dateLabel: UILabel?
    internal var noImageView: UIView?
    internal var contentLabel: UILabel?
    internal var activityIndicator: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false

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
            if let savedImageData = UserDefaults.standard.data(forKey: urlString),
                let savedImage = UIImage(data: savedImageData) {
                imageView = UIImageView(image: savedImage)
            } else {
                imageView = UIImageView()
                imageView?.contentMode = .scaleAspectFit
                imageView?.translatesAutoresizingMaskIntoConstraints = false
                stackView?.addArrangedSubview(imageView!)
                activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
                activityIndicator?.startAnimating()
                imageView?.addSubview(activityIndicator!)
                
                NSLayoutConstraint.activate([
                    imageView!.heightAnchor.constraint(equalToConstant: 200),
                    activityIndicator!.centerXAnchor.constraint(equalTo: imageView!.centerXAnchor),
                    activityIndicator!.centerYAnchor.constraint(equalTo: imageView!.centerYAnchor)
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
            grayView.heightAnchor.constraint(equalToConstant: 200),
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
        dateLabel?.textColor = .gray // Text color set to gray
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
            contentLabel?.textAlignment = .justified
            if let contentLabel = contentLabel {
                stackView?.addArrangedSubview(contentLabel)
            }
        } else {
            let noDescriptionLabel = UILabel()
            noDescriptionLabel.text = "Sem descrição disponível."
            noDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            noDescriptionLabel.textColor = .gray
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
                    self?.removeActivityIndicator()
                }
            }
        }
    }
    
    internal func removeActivityIndicator() {
        self.subviews.forEach {
            if let activityIndicator = $0 as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}
