//
//  Data.swift
//  BornLogic-Challenge
//
//  Created by Arthur on 12/05/2024.
//  Copyright © 2024 Arthur. All rights reserved.
//

import Foundation

// Estrutura para representar uma fonte de notícias
struct NewsSource: Codable {
    let id: String?
    let name: String
}

// Estrutura para representar um artigo de notícia
struct NewsArticle: Codable {
    let source: NewsSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// Estrutura para representar a resposta da API de notícias
struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticle]
}
