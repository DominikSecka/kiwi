//
//  FlightsPresenterInterface.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

protocol FlightsPresenterProtocol: class {
    
    // MARK: - FlightsView 👉 FlightsPresenter
    func notifyViewLoaded()
    
    func getFlights() -> [FlightViewModel]
    func clearFlights()
    
    // MARK: - FlightsInteractor 👉 FlightsPresenter
    func flightsLoaded(data flights: [Flight])
    func flightsLoadFailed(with message: String)
    
}
