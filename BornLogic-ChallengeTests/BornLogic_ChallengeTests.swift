//
//  BornLogic_ChallengeTests.swift
//  BornLogic-ChallengeTests
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//
import XCTest
@testable import BornLogic_Challenge

class NewsRequestTests: XCTestCase {
    
    var newsRequest: NewsRequest!
    
    override func setUp() {
        super.setUp()
        newsRequest = NewsRequest()
    }
    
    override func tearDown() {
        newsRequest = nil
        super.tearDown()
    }
    
    // Teste se a chamada à API está funcionando corretamente
    func testFetchNewsAPI() {
        let expectation = self.expectation(description: "API call successful")
        
        newsRequest.fetchNews { newsResponse, error in
            XCTAssertNotNil(newsResponse, "A resposta da API não deve ser nula")
            XCTAssertNil(error, "Não deve haver erro ao fazer a chamada à API")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    // Teste se os dados retornados estão sendo processados corretamente
    func testParseNewsResponse() {
        let expectation = self.expectation(description: "Data parsing successful")
        
        newsRequest.fetchNews { newsResponse, error in
            XCTAssertNotNil(newsResponse, "A resposta da API não deve ser nula")
            XCTAssertNil(error, "Não deve haver erro ao fazer a chamada à API")
            
            if let articles = newsResponse?.articles {
                XCTAssertFalse(articles.isEmpty, "A lista de artigos não deve estar vazia")
            } else {
                XCTFail("A lista de artigos não deve ser nula")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
