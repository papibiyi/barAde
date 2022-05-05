//
//  News.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import Foundation

struct News: Codable {
    let title: String?
    let description: String?
    let publishedAt: String?
    let url: String?
    let urlToImage: String?
}

struct NewsResponse: Codable {
    let articles: [News]?
}
