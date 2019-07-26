//
//  Flight.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

struct Flight: Codable {
    let id: String
    let cityFrom: String
    let cityTo: String
    let distance: Double
    let flyDuration: String
    let price: Double
    let mapIdfrom: String
    let mapIdto: String
    let departureTimestamp: Int
    let arrivalTimestamp: Int
    let airlines: [String]
    var allStopoverAirports: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case cityFrom
        case cityTo
        case distance
        case flyDuration = "fly_duration"
        case price
        case mapIdfrom
        case mapIdto
        case departureTimestamp = "dTimeUTC"
        case arrivalTimestamp = "aTimeUTC"
        case airlines
        case allStopoverAirports = "all_stopover_airports"
    }
}
