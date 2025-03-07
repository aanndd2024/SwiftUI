//
//  NewsSource.swift
//  NewsApp
//
//  Created by Anand Yadav on 07/03/25.
//
import Foundation

struct NewsSourceResponse: Decodable {
    let sources: [NewsSource]
}

struct NewsSource: Identifiable, Decodable {
    let id: String
    let name: String
    let description: String
}
