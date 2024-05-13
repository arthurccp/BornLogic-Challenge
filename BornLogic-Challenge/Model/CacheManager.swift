//
//  CacheManager.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation

class CacheManager {
    
    func saveDataToUserDefaults<T: Encodable>(_ data: T, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(try? JSONEncoder().encode(data), forKey: key)
    }
    
    func fetchDataFromUserDefaults<T: Decodable>(forKey key: String) -> T? {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        return nil
    }
}

