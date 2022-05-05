//
//  APIService.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import Combine
import Foundation

class ApiService: API {
    static let shared = ApiService()
    
    func getNews() -> AnyPublisher<[News]?, Error> {
        let url = URL(string: URLConstants.news.rawValue)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .decode(type: NewsResponse.self, decoder: JSONDecoder())
            .map(\.articles)
            .eraseToAnyPublisher()
    }
    
    func getTickers() -> AnyPublisher<Data?, Error> {
        let url = URL(string: URLConstants.tickers.rawValue)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }.eraseToAnyPublisher()
    }
}

protocol API {
    func getNews() -> AnyPublisher<[News]?, Error>
    func getTickers() -> AnyPublisher<Data?, Error>
}
