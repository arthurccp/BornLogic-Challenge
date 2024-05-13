//
//  NewsDataManager.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation
import UIKit


protocol DataFetchable {
    func fetchData(completion: @escaping ([NewsArticle]?, Error?) -> Void)
}

class DataManager: DataFetchable {
    private let cacheManager = CacheManager()
    
    func fetchData(completion: @escaping ([NewsArticle]?, Error?) -> Void) {
        if let cachedArticles: [NewsArticle] = cacheManager.fetchDataFromUserDefaults(forKey: "newsArticles") {
           
            completion(cachedArticles, nil)
        } else {
            
            let newsRequest = NewsRequest()
            newsRequest.fetchNews { [weak self] newsResponse, error in
                if let error = error {
                  
                    completion(nil, error)
                    return
                }
                
          
                if let articles = newsResponse?.articles {
                    self?.cacheManager.saveDataToUserDefaults(articles, forKey: "newsArticles")
                    completion(articles, nil)
                } else {
                    completion(nil, NSError(domain: "DataManager", code: 0, userInfo: [NSLocalizedDescriptionKey: "Resposta inválida"]))
                }
            }
        }
    }
}
