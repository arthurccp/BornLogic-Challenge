//
//  ViewController.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var dataManager: DataFetchable = NewsDataManager()
    var dataSource: TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableViewConstraints()
        UIConfigurator.setupNavigationBar(viewController: self)
        setupTableView()
        fetchData()
    }
    
    internal func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    internal func setupTableView() {
        dataSource = TableViewDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        fetchData() 
    }

    
    internal func fetchData() {
        if let cachedArticles: [NewsArticle] = CacheManager().fetchDataFromUserDefaults(forKey: "newsArticles") {
            self.dataSource?.articles = cachedArticles
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            dataManager.fetchData { [weak self] articles, error in
                if let error = error {
                    print("Erro: \(error.localizedDescription)")
                    return
                }
                self?.dataSource?.articles = articles ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    // Salvar os dados em cache após o carregamento
                    if let articles = articles {
                        CacheManager().saveDataToUserDefaults(articles, forKey: "newsArticles")
                    }
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = dataSource?.articles[indexPath.row]
        let detailViewController = ArticleDetailViewController()
        detailViewController.article = selectedArticle
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
