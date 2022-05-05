//
//  CSVDataToTIckerTransformer.swift
//  BarakaAdebiyi
//
//  Created by Mojisola Adebiyi on 05/05/2022.
//

import Foundation

final class CSVDataToTIckerTransformer {
    static func transformCSV(data: Data?) -> [Ticker] {
        var tickers: [Ticker] = []
        guard let data = data else { return []}
        guard let stringData = String(data: data, encoding: .utf8) else { return []}
        let splittedData = stringData.split(separator: "\n").dropFirst()
        splittedData.forEach { dataString in
            let value = dataString.split(separator: ",")
                .map({$0.trimmingCharacters(in: .whitespaces)})
            if value.count == 2 {
                tickers.append(Ticker(price: Double(value[1]), symbol: String(value[0]).replacingOccurrences(of: "\"", with: "")))
            }
        }
        return tickers
    }
}
