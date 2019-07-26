//
//  APIConstants.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

enum API {
    
    enum ImageSize: String {
        case _600 = "600"
        case _1200 = "1200"
    }
    
    enum QueryItemName: String {
        case version = "v"
        case sort
        case asc
        case locale
        case children
        case infants
        case flyFrom
        case to
        case featureName
        case dateFrom
        case dateTo
        case typeFlight
        case onePerDate = "one_per_date"
        case oneforcity
        case waitForRefresh = "wait_for_refresh"
        case adults
        case limit
        case priceFrom = "price_from"
        case priceTo = "price_to"
        case selectAirlines = "select_airlines"
        case selectAirlinesExclude = "select_airlines_exclude"
        case selectStopAirportExclude = "select_stop_airport_exclude"
        case selectStopAirport = "select_stop_airport"
    }
}
