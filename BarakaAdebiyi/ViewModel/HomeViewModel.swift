//
//  HomeViewModel.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import Foundation

import Combine

class HomeViewModel {
    
    let service: API
    
    var timer: Timer?
    var cancellable = [AnyCancellable]()
    
    @Published var news = [News]()
    @Published var tickers = [Ticker]()
    
    init(service: API = ApiService()) {
        self.service = service
    }
    
    var newsImageSection: [News] {
        return news.prefix(6).map({$0})
    }
    
    var newsDetailedSection: [News] {
        let suffix = (news.count - 6)
        let resolvedSuffix = suffix < 0 ? 0 : suffix
        return news.suffix(resolvedSuffix).map({$0})
    }
    
    func getNews() {
        service.getNews().sink { _ in } receiveValue: {[weak self] news in
            self?.news = news ?? []
        }.store(in: &cancellable)
    }
    
    @objc func getTickers() {
        service.getTickers().sink { _ in } receiveValue: {[weak self] data in
            self?.tickers = CSVDataToTIckerTransformer.transformCSV(data: data)
        }.store(in: &cancellable)
    }
}

extension HomeViewModel {
    enum Section: CaseIterable {
        case tickers
        case newsImage
        case newsDetailed
    }
}
