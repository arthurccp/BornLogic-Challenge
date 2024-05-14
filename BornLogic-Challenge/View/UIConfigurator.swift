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
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 240, height: 44))
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 190, height: 44)) // Centralizando o título
        titleLabel.center = titleView.center
        titleLabel.text = "Bornlogic-Challenge"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleView.addSubview(titleLabel)
        
        if let navigationBar = navigationController.navigationBar as? UINavigationBar {
            navigationBar.topItem?.titleView = titleView
        }
    }

    static func setupTableView(tableView: UITableView, dataSource: UITableViewDataSource & UITableViewDelegate) {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
    }
}

