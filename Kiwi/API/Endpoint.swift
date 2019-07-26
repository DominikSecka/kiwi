//
//  Router.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

enum Endpoint {
    case flights
    case images(size: String, location: String)
    case airlineIcons(iata: String)
    
    var scheme: String {
        switch self {
        case .flights, .images, .airlineIcons:
            return "https"
        }
    }
    
    var host: String {
        switch self {
        case .flights:
            return "api.skypicker.com"
        case .images, .airlineIcons:
            return "images.kiwi.com"
        }
    }
        
    var path: String {
        switch self {
        case .flights:
            return "/flights"
        case let .images(size, location):
            return "/photos/\(size)/\(location).jpg"
        case let .airlineIcons(iata):
            return "/airlines/64/\(iata).png"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .flights, .images, .airlineIcons:
            return HTTPMethod.get
        }
    }
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.host
        components.path = self.path
        return components
    }
}
