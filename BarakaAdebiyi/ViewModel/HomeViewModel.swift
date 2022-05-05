//
//  HomeViewModel.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import Foundation

import Combine

class HomeViewModel {
    
    private let service: API
    
    private var timer: Timer?
    
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
    

    func startFetchStream() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getTickers), userInfo: nil, repeats: true)
    }

    
    func getNews() {
        service.getNews().sink { _ in } receiveValue: {[weak self] news in
            self?.news = news ?? []
        }.store(in: &cancellable)
    }
    
    @objc private func getTickers() {
        service.getTickers().sink { _ in } receiveValue: {[weak self] data in
            guard let self = self else {return}
            self.tickers = self.generateRandomTickers(from: CSVDataToTIckerTransformer.transformCSV(data: data))
        }.store(in: &cancellable)
    }
    
    func generateRandomTickers(from data: [Ticker]) -> [Ticker] {
        var temp: [Ticker] = []
        let tickers = data.shuffled()
        tickers.forEach { ticker in
            if let index = temp.firstIndex(where: {$0.symbol == ticker.symbol}) {
                temp[index] = ticker
            }else {
                temp.append(ticker)
            }
        }
        return temp
    }
}

extension HomeViewModel {
    enum Section: CaseIterable {
        case tickers
        case newsImage
        case newsDetailed
    }
}
