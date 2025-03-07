//
//  Untitled.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//
import Foundation

struct Constants {
    
    struct Urls {
        static func topHeadlines(by source: String) -> URL? {
            return URL(string: "https://newsapi.org/v2/top-headlines?sources=\(source)&apiKey=580044240408450dba8ffbeb923b595d")
        }
        static let sources: URL? = URL(string: "https://newsapi.org/v2/sources?apiKey=580044240408450dba8ffbeb923b595d")
    }
    
}

