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
    
    var articles: [NewsArticle] = []
    
    override func viewWillAppear(_ animated: Bool) {
        setupTableView()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        fetchData()
        tableView.reloadData()
        
        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        
        // Configurando o título da barra de navegação
        navigationItem.title = "TableView"
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    
    func fetchData() {
        let newsRequest = NewsRequest()
        newsRequest.fetchNews { newsResponse, error in
            if let error = error {
                print("Erro: \(error.localizedDescription)")
                return
            }
            
            guard let newsResponse = newsResponse else {
                print("Resposta inválida")
                return
            }
            
            self.articles = newsResponse.articles
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleTableViewCell
        
        let article = articles[indexPath.row]
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author ?? "Autor Desconhecido"
        cell.descriptionLabel.text = article.description ?? "Sem descrição"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = articles[indexPath.row]
        
        // Cria uma instância da ViewController de detalhes
        let detailViewController = ArticleDetailViewController()
        
        // Configura os dados necessários na nova ViewController
        detailViewController.article = selectedArticle
        
        // Navega para a nova ViewController
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
