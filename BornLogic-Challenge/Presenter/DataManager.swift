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
    func fetchData(completion: @escaping ([NewsArticle]?, Error?) -> Void) {
        let newsRequest = NewsRequest()
        newsRequest.fetchData { newsResponse, error in
            if let error = error {
                completion(nil, error)
                return
            }
            completion(newsResponse?.articles, error)
        }
    }
}
