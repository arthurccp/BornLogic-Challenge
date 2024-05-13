//
//  ViewControllerTests.swift
//  BornLogic-ChallengeTests
//
//  Created by Arthur on 13/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import XCTest
@testable import BornLogic_Challenge

class ViewControllerTests: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ViewController()
        
        viewController.dataSource = TableViewDataSource()
        viewController.dataSource?.articles = [
            NewsArticle(source: NewsSource(id: nil, name: "Source Name"), author: "Autor 1", title: "Título 1", description: "Descrição 1", url: "https://example.com", urlToImage: nil, publishedAt: "2024-05-13T00:00:00Z", content: nil),
            NewsArticle(source: NewsSource(id: nil, name: "Source Name"), author: "Autor 2", title: "Título 2", description: "Descrição 2", url: "https://example.com", urlToImage: nil, publishedAt: "2024-05-13T00:00:00Z", content: nil)
        ]
        
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testTableViewNotNil() {
        XCTAssertNotNil(viewController.tableView, "A UITableView não deve ser nula")
    }
    
    func testTableViewDataSource() {
        XCTAssertNotNil(viewController.tableView.dataSource, "O dataSource da UITableView não deve ser nulo")
        XCTAssertTrue(viewController.tableView.dataSource is TableViewDataSource, "O dataSource da UITableView deve ser do tipo TableViewDataSource")
    }
    
    func testTableViewDelegate() {
        XCTAssertNotNil(viewController.tableView.delegate, "O delegate da UITableView não deve ser nulo")
        XCTAssertTrue(viewController.tableView.delegate is ViewController, "O delegate da UITableView deve ser do tipo ViewController")
    }
    
    func testTableViewNumberOfCells() {
        let expectedNumberOfCells = viewController.dataSource?.articles.count
        let actualNumberOfCells = viewController.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(expectedNumberOfCells, actualNumberOfCells, "O número de células na tabela deve corresponder ao número de artigos")
    }
    
    func testCacheManagerSaveAndRetrieveData() {
        let cacheManager = CacheManager()
        let articles: [NewsArticle] = [
            NewsArticle(source: NewsSource(id: "source_id_1", name: "Source Name 1"), author: "Author 1", title: "Title 1", description: "Description 1", url: "https://example.com/1", urlToImage: nil, publishedAt: "2024-05-13T00:00:00Z", content: "Content 1"),
            NewsArticle(source: NewsSource(id: "source_id_2", name: "Source Name 2"), author: "Author 2", title: "Title 2", description: "Description 2", url: "https://example.com/2", urlToImage: nil, publishedAt: "2024-05-14T00:00:00Z", content: "Content 2")
        ]
        
        cacheManager.saveDataToUserDefaults(articles, forKey: "testCache")
        
        let cachedArticles: [NewsArticle]? = cacheManager.fetchDataFromUserDefaults(forKey: "testCache")
        
        XCTAssertNotNil(cachedArticles, "Os dados salvos no cache não devem ser nulos")
        XCTAssertEqual(cachedArticles?.count, 2, "O número de artigos salvos no cache deve corresponder ao número de artigos original")
        XCTAssertEqual(cachedArticles?[0].title, "Title 1", "O título do primeiro artigo deve ser 'Title 1'")
        XCTAssertEqual(cachedArticles?[1].title, "Title 2", "O título do segundo artigo deve ser 'Title 2'")
    }
}
