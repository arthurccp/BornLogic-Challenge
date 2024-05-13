//
//  BornLogic_ChallengeTests.swift
//  BornLogic-ChallengeTests
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import XCTest
@testable import BornLogic_Challenge

class RequestTests: XCTestCase {
    
    var newsRequest: NewsRequest!
    
    override func setUp() {
        super.setUp()
        newsRequest = NewsRequest()
    }
    
    override func tearDown() {
        newsRequest = nil
        super.tearDown()
    }
    
    func testFetchNewsAPI() {
        let expectation = self.expectation(description: "API call successful")
        
        newsRequest.fetchData { newsResponse, error in
            XCTAssertNotNil(newsResponse, "A resposta da API não deve ser nula")
            XCTAssertNil(error, "Não deve haver erro ao fazer a chamada à API")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testParseNewsResponse() {
        let expectation = self.expectation(description: "Data parsing successful")
        
        newsRequest.fetchData { newsResponse, error in
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
    
    func testFetchNewsAPIWithError() {
        let expectation = self.expectation(description: "API call with error")
        
        
        class MockErrorNewsRequest: NewsRequest {
            override func fetchData(completion: @escaping (NewsResponse?, Error?) -> Void) {
                completion(nil, NSError(domain: "test", code: 123, userInfo: [NSLocalizedDescriptionKey: "Erro de teste"]))
            }
        }
        newsRequest = MockErrorNewsRequest()
        
        newsRequest.fetchData { newsResponse, error in
            XCTAssertNil(newsResponse, "A resposta da API deve ser nula quando ocorre um erro")
            XCTAssertNotNil(error, "Deve haver um erro ao fazer a chamada à API")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
