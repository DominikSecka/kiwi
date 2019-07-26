//
//  FlightsPresenter.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import UIKit

struct FlightViewModel {
    let title: String
    let price: String
    let destinationLocation: String
    let departure: String
    let arrival: String
    let duration: String
    let distance: String
    let airlines: String
    let firstIata: String?
    var image: UIImage?
}

class FlightsPresenter {
    
    var interactor: FlightsInteractorProtocol?
    var router: FlightsRouterProtocol?
    weak var view: FlightsViewController?
    var flights = [FlightViewModel]()
    var rawFlights = [Flight]()
}

extension FlightsPresenter: FlightsPresenterProtocol {
    
    func getFlights() -> [FlightViewModel] {
        return flights
    }
    
    func clearFlights() {
        flights = []
        view?.reloadData()
    }
    
    func notifyViewLoaded() {
        view?.setupInitialView()
        view?.showLoading()
        interactor?.loadFlights(airlines: rawFlights.flatMap({ $0.airlines }), stopAirports: rawFlights.flatMap({ $0.allStopoverAirports ?? [] }))
    }
    
    func flightsLoaded(data flights: [Flight]) {
        rawFlights = flights
        let currencyFormatter = NumberFormatter()
        currencyFormatter.locale = Locale.current
        currencyFormatter.numberStyle = .currency
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.locale = Locale.current
        self.flights = flights.map({ FlightViewModel(
            title: "\($0.cityFrom) 👉 \($0.cityTo)",
            price: "💰 \(currencyFormatter.string(from: $0.price as NSNumber) != nil ? currencyFormatter.string(from: $0.price as NSNumber)! : "--")",
            destinationLocation: $0.mapIdto,
            departure: "Departure: \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval($0.departureTimestamp))))",
            arrival: "Arrival: \(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval($0.arrivalTimestamp))))",
            duration: "⏱ Duration: \($0.flyDuration)",
            distance: "Distance: \(measurementFormatter.string(from: Measurement(value: $0.distance, unit: UnitLength.kilometers)))",
            airlines: "👩‍✈️ \($0.airlines.joined(separator: "✈️"))",
            firstIata: $0.airlines.first,
            image: nil
        )})
        view?.hideLoading()
        view?.reloadData()
    }
    
    func flightsLoadFailed(with message: String) {
        router?.presentPopup(with: message)
    }
    
}
