//
//  NewsArticle.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//
import Foundation

struct NewsArticleResponse: Decodable {
    let articles: [NewsArticle]
}

struct NewsArticle: Identifiable, Decodable {
    var id: String { url }
    let source: [String: String?]?
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

