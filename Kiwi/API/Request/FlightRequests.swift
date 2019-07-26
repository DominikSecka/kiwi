//
//  FlightsRequests.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

struct GETFlights: APIRequest {
    var queryParams: [URLQueryItem]? = nil
    var endpoint = Endpoint.flights
    
    init(airlines: [String], stopAirports: [String]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let priceFrom = Int.random(in: 1 ..< 800)
        let priceTo = Int.random(in: priceFrom ..< 1001)
        queryParams = [
            URLQueryItem(name: API.QueryItemName.version, value: 3),
            URLQueryItem(name: API.QueryItemName.sort, value: "popularity"),
            URLQueryItem(name: API.QueryItemName.asc, value: 1),
            URLQueryItem(name: API.QueryItemName.locale, value: "en"),
            URLQueryItem(name: API.QueryItemName.children, value: 0),
            URLQueryItem(name: API.QueryItemName.infants, value: 0),
            URLQueryItem(name: API.QueryItemName.flyFrom, value: "49.2-16.61-250km"),
            URLQueryItem(name: API.QueryItemName.to, value: "anywhere"),
            URLQueryItem(name: API.QueryItemName.featureName, value: "aggregateResults"),
            URLQueryItem(name: API.QueryItemName.dateFrom, value: dateFormatter.string(from: Date())),
            URLQueryItem(name: API.QueryItemName.dateTo, value: dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!)),
            URLQueryItem(name: API.QueryItemName.typeFlight, value: "oneway"),
            URLQueryItem(name: API.QueryItemName.onePerDate, value: 0),
            URLQueryItem(name: API.QueryItemName.oneforcity, value: 1),
            URLQueryItem(name: API.QueryItemName.waitForRefresh, value: 0),
            URLQueryItem(name: API.QueryItemName.adults, value: 1),
            URLQueryItem(name: API.QueryItemName.limit, value: 5),
            URLQueryItem(name: API.QueryItemName.priceFrom, value: priceFrom),
            URLQueryItem(name: API.QueryItemName.priceTo, value: priceTo),
            URLQueryItem(name: API.QueryItemName.selectAirlines, value: airlines.joined(separator: ",")),
            URLQueryItem(name: API.QueryItemName.selectAirlinesExclude, value: true),
            URLQueryItem(name: API.QueryItemName.selectStopAirport, value: stopAirports.joined(separator: ",")),
            URLQueryItem(name: API.QueryItemName.selectStopAirportExclude, value: true),
        ]
    }
}
