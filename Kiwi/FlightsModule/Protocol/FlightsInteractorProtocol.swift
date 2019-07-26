//
//  FlightsInteractorProtocol.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//
import UIKit

protocol FlightsInteractorProtocol {
    
    // MARK: - FlightsPresenter 👉 FlightsInteractor
    func loadFlights(airlines: [String], stopAirports: [String])

}
