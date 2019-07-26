//
//  FlightsRouter.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import UIKit

class FlightsRouter {
    
    weak var presenter: FlightsPresenterProtocol?
    weak var view: UIViewController?
    
    // MARK: - 🛠 Init Module
    static func createModule() -> FlightsViewController? {
        
        let router = FlightsRouter()
        let presenter = FlightsPresenter()
        let interactor = FlightsInteractor()
        guard let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "flightsVC") as? FlightsViewController else {
            return nil
        }
        
        // MARK: - 🔗 Connect layers
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        
        return view
    }
    
}

extension FlightsRouter: FlightsRouterProtocol {
    
    func presentPopup(with message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.view?.present(alertController, animated: true, completion: nil)
        }
    }
    
}
