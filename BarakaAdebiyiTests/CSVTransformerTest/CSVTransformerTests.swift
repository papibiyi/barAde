//
//  CSVTransformerTests.swift
//  BarakaAdebiyiTests
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import XCTest
@testable import BarakaAdebiyi

class CSVTransformerTests: XCTestCase {

    func test_CSV_Decoded_Correctly() throws {
        let fileUrl = Bundle.main.url(forResource: "ticker_test_data", withExtension: "csv")
        
        let data = try? Data(contentsOf: fileUrl!)
        
        let tickers = CSVDataToTIckerTransformer.transformCSV(data: data!)
        
        
        XCTAssertFalse(tickers.isEmpty)
    }
    
    func test_count_when_decoded_is_500() throws {
        let fileUrl = Bundle.main.url(forResource: "ticker_test_data", withExtension: "csv")
        
        let data = try? Data(contentsOf: fileUrl!)
        
        let tickers = CSVDataToTIckerTransformer.transformCSV(data: data!)
        let expectedResult = 500
        
        XCTAssertEqual(tickers.count, expectedResult)
    }
    
    func test_CSV_First_Item_Correct() throws {
        let fileUrl = Bundle.main.url(forResource: "ticker_test_data", withExtension: "csv")
        
        let data = try? Data(contentsOf: fileUrl!)
        
        let tickers = CSVDataToTIckerTransformer.transformCSV(data: data!)
        
        let expectedSymbol = "FORD"
        let expectedPrice = 72.19042874981784
        XCTAssertEqual(tickers[0].price, expectedPrice)
        XCTAssertEqual(tickers[0].symbol, expectedSymbol)
    }

}
