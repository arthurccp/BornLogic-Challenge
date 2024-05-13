//
//  ArticleDetailViewControllerTests.swift
//  BornLogic-ChallengeTests
//
//  Created by Arthur on 13/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import XCTest
@testable import BornLogic_Challenge

class ArticleDetailViewControllerTests: XCTestCase {
    
    var viewController: ArticleDetailViewController!
    
    override func setUp() {
        super.setUp()
        viewController = ArticleDetailViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(viewController)
    }
    
    func testArticleAssignment() {
        let source = NewsSource(id: "source_id", name: "Test Source")
        let article = NewsArticle(source: source, author: "Test Author", title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: "test_image_url", publishedAt: "2024-05-13", content: "Test Content")
        viewController.article = article
        
        XCTAssertEqual(viewController.article?.source.name, "Test Source")
        XCTAssertEqual(viewController.article?.author, "Test Author")
        XCTAssertEqual(viewController.article?.title, "Test Title")
        XCTAssertEqual(viewController.article?.description, "Test Description")
        XCTAssertEqual(viewController.article?.url, "https://example.com")
        XCTAssertEqual(viewController.article?.urlToImage, "test_image_url")
        XCTAssertEqual(viewController.article?.publishedAt, "2024-05-13")
        XCTAssertEqual(viewController.article?.content, "Test Content")
    }
    
    func testActivityIndicatorRemoval() {
        let viewController = ArticleDetailViewController()
        
        let imageView = UIImageView()
        viewController.imageView = imageView
        
        let activityIndicator = UIActivityIndicatorView()
        imageView.addSubview(activityIndicator)
        XCTAssertEqual(imageView.subviews.count, 1)
        
        imageView.loadImage(fromURL: "https://media.zenfs.com/en/reuters-finance.com/2259b38c6d587017dfb867da489e97ec")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(imageView.subviews.count, 0)
        }
    }
    
    func testNoDescriptionMessage() {
        let viewController = ArticleDetailViewController()
        
        let source = NewsSource(id: "source_id", name: "Test Source")
        let article = NewsArticle(source: source, author: "Test Author", title: "Test Title", description: nil, url: "https://example.com", urlToImage: nil, publishedAt: "2024-05-13", content: nil)
        viewController.article = article
        
        viewController.viewDidLoad()
        
        let stackView = viewController.stackView
        
        XCTAssertTrue(stackView?.arrangedSubviews.last is UILabel)
        let lastLabel = stackView?.arrangedSubviews.last as? UILabel
        XCTAssertEqual(lastLabel?.text, "Sem descrição disponível.")
    }
    
    func testImageDisplay() {
        let viewController = ArticleDetailViewController()
        
        let source = NewsSource(id: "source_id", name: "Test Source")
        let article = NewsArticle(source: source, author: "Test Author", title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: "test_image_url", publishedAt: "2024-05-13", content: "Test Content")
        viewController.article = article
        
        viewController.viewDidLoad()
        
        let imageView = viewController.imageView
        
        XCTAssertNotNil(imageView)
        
    }
    
    func testPlaceholderImageDisplay() {
        let viewController = ArticleDetailViewController()
        
        let source = NewsSource(id: "source_id", name: "Test Source")
        let article = NewsArticle(source: source, author: "Test Author", title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: nil, publishedAt: "2024-05-13", content: "Test Content")
        viewController.article = article
        
        viewController.viewDidLoad()
        
        let imageView = viewController.imageView
        
        
        XCTAssertEqual(imageView?.image, UIImage(named: "placeholder_image"))
    }
    
    func testImageCache() {
        let viewController = ArticleDetailViewController()
        
        let source = NewsSource(id: "source_id", name: "Test Source")
        let article = NewsArticle(source: source, author: "Test Author", title: "Test Title", description: "Test Description", url: "https://example.com", urlToImage: "test_image_url", publishedAt: "2024-05-13", content: "Test Content")
        viewController.article = article
        
        viewController.viewDidLoad()
        
        let imageView = viewController.imageView
        
        // Check if the image view is not nil
        XCTAssertNotNil(imageView)
        
    }
}

