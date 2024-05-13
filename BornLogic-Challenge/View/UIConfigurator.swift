//
//  UIConfigurator.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation
import UIKit

class UIConfigurator {
    static func setupNavigationBar(viewController: UIViewController) {
        let navigationController = UINavigationController(rootViewController: viewController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        viewController.navigationItem.title = "Bornlogic-Challenge"
    }
    
    static func setupTableView(tableView: UITableView, dataSource: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
    }
}
