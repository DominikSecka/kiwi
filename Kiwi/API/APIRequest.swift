//
//  APIRequest.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

protocol APIRequest {
    var endpoint: Endpoint { get }
    var queryParams: [URLQueryItem]? { get }
}
