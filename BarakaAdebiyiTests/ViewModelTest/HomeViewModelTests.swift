//
//  BarakaAdebiyiTests.swift
//  BarakaAdebiyiTests
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import XCTest
@testable import BarakaAdebiyi

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!

    override func setUpWithError() throws {
        sut = HomeViewModel(service: ApiService())
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    
    func test_news_Array_Returns_Correct_Image_Section_Count() {
        let news: [News] = [
            News(title: "A", description: "A", publishedAt: "A", url: "A", urlToImage: "A"),
            News(title: "B", description: "B", publishedAt: "B", url: "B", urlToImage: "B"),
            News(title: "C", description: "C", publishedAt: "C", url: "C", urlToImage: "C"),
            News(title: "D", description: "D", publishedAt: "D", url: "D", urlToImage: "D"),
            News(title: "E", description: "E", publishedAt: "E", url: "E", urlToImage: "E"),
            News(title: "F", description: "F", publishedAt: "F", url: "F", urlToImage: "F"),
            News(title: "G", description: "G", publishedAt: "G", url: "G", urlToImage: "G"),
            News(title: "H", description: "H", publishedAt: "H", url: "H", urlToImage: "H")
        ]
        sut.news = news

        let expectedResult = 6
        XCTAssertEqual(sut.newsImageSection.count, expectedResult)
    }
    
    func test_news_Array_Returns_Correct_Top_Six_Item() {
        let news: [News] = [
            News(title: "A", description: "A", publishedAt: "A", url: "A", urlToImage: "A"),
            News(title: "B", description: "B", publishedAt: "B", url: "B", urlToImage: "B"),
            News(title: "C", description: "C", publishedAt: "C", url: "C", urlToImage: "C"),
            News(title: "D", description: "D", publishedAt: "D", url: "D", urlToImage: "D"),
            News(title: "E", description: "E", publishedAt: "E", url: "E", urlToImage: "E"),
            News(title: "F", description: "F", publishedAt: "F", url: "F", urlToImage: "F"),
            News(title: "G", description: "G", publishedAt: "G", url: "G", urlToImage: "G"),
            News(title: "H", description: "H", publishedAt: "H", url: "H", urlToImage: "H")
        ]
        sut.news = news
        
        XCTAssertEqual(sut.newsImageSection[0].title, news[0].title)
        XCTAssertEqual(sut.newsImageSection[1].title, news[1].title)
        XCTAssertEqual(sut.newsImageSection[2].title, news[2].title)
        XCTAssertEqual(sut.newsImageSection[3].title, news[3].title)
        XCTAssertEqual(sut.newsImageSection[4].title, news[4].title)
        XCTAssertEqual(sut.newsImageSection[5].title, news[5].title)
    }
    
    func test_newsDetailsReutrnsCorrectLastTwoItemCount() {
        let news: [News] = [
            News(title: "A", description: "A", publishedAt: "A", url: "A", urlToImage: "A"),
            News(title: "B", description: "B", publishedAt: "B", url: "B", urlToImage: "B"),
            News(title: "C", description: "C", publishedAt: "C", url: "C", urlToImage: "C"),
            News(title: "D", description: "D", publishedAt: "D", url: "D", urlToImage: "D"),
            News(title: "E", description: "E", publishedAt: "E", url: "E", urlToImage: "E"),
            News(title: "F", description: "F", publishedAt: "F", url: "F", urlToImage: "F"),
            News(title: "G", description: "G", publishedAt: "G", url: "G", urlToImage: "G"),
            News(title: "H", description: "H", publishedAt: "H", url: "H", urlToImage: "H")
        ]
        sut.news = news
        
        let expectedResult = 2
        XCTAssertEqual(sut.newsDetailedSection.count, expectedResult)
    }
    
    func test_news_Array_Returns_Correct_Last_Two_Items() {
        let news: [News] = [
            News(title: "A", description: "A", publishedAt: "A", url: "A", urlToImage: "A"),
            News(title: "B", description: "B", publishedAt: "B", url: "B", urlToImage: "B"),
            News(title: "C", description: "C", publishedAt: "C", url: "C", urlToImage: "C"),
            News(title: "D", description: "D", publishedAt: "D", url: "D", urlToImage: "D"),
            News(title: "E", description: "E", publishedAt: "E", url: "E", urlToImage: "E"),
            News(title: "F", description: "F", publishedAt: "F", url: "F", urlToImage: "F"),
            News(title: "G", description: "G", publishedAt: "G", url: "G", urlToImage: "G"),
            News(title: "H", description: "H", publishedAt: "H", url: "H", urlToImage: "H")
        ]
        sut.news = news
        
        XCTAssertEqual(sut.newsDetailedSection[0].title, news[6].title)
        XCTAssertEqual(sut.newsDetailedSection[1].title, news[7].title)
    }
    
    
    func test_randomTicker_does_not_generate_one_symbol_twice() {
        let symbols = ["FORD", "NVDA", "AMD", "ACN", "NIO", "AAPL", "TESLA"]
        
        let fileUrl = Bundle.main.url(forResource: "ticker_test_data", withExtension: "csv")
        
        let data = try? Data(contentsOf: fileUrl!)
        
        let tickers = CSVDataToTIckerTransformer.transformCSV(data: data!)
        
        let randomTickers = sut.generateRandomTickers(from: tickers)
        
        let expectedCount = 1
        for symbol in symbols {
            var count = 0
            for ticker in randomTickers {
                if (ticker.symbol == symbol) {
                    count = count + 1
                }
            }
            XCTAssertEqual(count, expectedCount)
        }
    }


}
