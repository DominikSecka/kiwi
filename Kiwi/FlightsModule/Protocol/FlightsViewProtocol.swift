//
//  FlightsViewInterface.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

// MARK: - FlightsPresenter 👉 FlightsView
protocol FlightsViewProtocol {
    
    func showLoading()
    func hideLoading()
    func stopLoading()
    func reloadData()
    func setupInitialView()
    
}
