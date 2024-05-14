//
//  TableViewDataSource.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var articles: [NewsArticle] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author ?? "Autor Desconhecido"
        cell.descriptionLabel.text = article.description ?? "Sem descrição"

        if let imageUrl = article.urlToImage {
            cell.thumbnailImageView.loadImage(fromURL: imageUrl)
        } else {
            cell.thumbnailImageView.image = UIImage(named: "placeholder_image")
        }
        return cell
    }
}
