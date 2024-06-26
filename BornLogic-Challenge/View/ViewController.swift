//
//  ViewController.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var dataManager: DataFetchable = DataManager()
    var dataSource: TableViewDataSource?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableViewConstraints()
        UIConfigurator.setupNavigationBar(viewController: self)
        setupTableView()
        fetchData()
    }
    
    // MARK: - Internal Methods
    
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
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
                    self?.presentErrorAlert(message: "Erro ao buscar dados: \(error.localizedDescription)")
                    return
                }
                self?.dataSource?.articles = articles ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    if let articles = articles {
                        CacheManager().saveDataToUserDefaults(articles, forKey: "newsArticles")
                    }
                }
            }
        }
    }
    
    private func presentErrorAlert(message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
