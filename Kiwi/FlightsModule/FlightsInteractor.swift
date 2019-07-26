//
//  FlightsInteractor.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import UIKit

class FlightsInteractor {
    
    var presenter: FlightsPresenterProtocol?

}

extension FlightsInteractor: FlightsInteractorProtocol {
    
    func loadFlights(airlines: [String], stopAirports: [String]) {
        APIClient.request(GETFlights(airlines: airlines, stopAirports: stopAirports)) {[weak self] (result: Result<DataArrayWrapper<Flight>, Error>) in
            guard let `self` = self else { return }
            switch result {
            case .success:
                do {
                    let flights = try result.get().data
                    `self`.presenter?.flightsLoaded(data: flights)
                } catch {
                    `self`.presenter?.flightsLoadFailed(with: "Cannot load flights data!")
                }
            case .failure:
                `self`.presenter?.flightsLoadFailed(with: "Cannot load flights data!")
            }
        }
    }
    
}
