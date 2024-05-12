//
//  Parser.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation

class NewsRequest{
    func fetchNews(completion: @escaping (NewsResponse?, Error?) -> Void) {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=86a4155f580e4b03913965668d29f740"
        
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let responseData = data else {
                print("Nenhum dado retornado")
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Nenhum dado retornado"]))
                return
            }
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: responseData)
                completion(newsResponse, nil)
            } catch {
                print("Erro ao decodificar JSON: \(error.localizedDescription)")
                completion(nil, error)
            }
        }
        
        task.resume()
    }
}
