//
//  APIRequest.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import Foundation

struct DataArrayWrapper<T: Codable>: Codable {
    let data: [T]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

class APIClient {

    @discardableResult class func request<T: Codable>(_ request: APIRequest, completion: @escaping (Result<T, Error>) -> ()) -> URLSessionDataTask? {
        var components = request.endpoint.components
        components.queryItems = request.queryParams
        
        guard let url = components.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.endpoint.method.rawValue
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(error!))
                }
                print(error?.localizedDescription ?? "Unknown error")
                return
            }
            guard response != nil else {
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                guard httpResponse.statusCode == 200 else {
                    completion(.failure(NSError(domain: "Response failure", code: httpResponse.statusCode, userInfo: nil)))
                    return
                }
            }
            guard let data = data else {
                return
            }
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
        return dataTask
    }

}
