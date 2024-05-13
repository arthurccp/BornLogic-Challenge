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
    
    var dataManager: DataManager = DataManager()
    var dataSource: TableViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        setupTableViewConstraints()
        UIConfigurator.setupNavigationBar(viewController: self)
        setupTableView()
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
        dataManager.fetchData { [weak self] articles, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            self?.dataSource?.articles = articles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
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
