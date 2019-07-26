//
//  FlightCollectionViewCell.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import UIKit

class FlightCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var destinationImageView: UIImageView!
    @IBOutlet var arrivalLabel: UILabel!
    @IBOutlet var departureLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var airlinesLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var airlinesIcon: UIImageView!
    
    func setupCell(with flight: FlightViewModel) {
        titleLabel.text = flight.title
        priceLabel.text = flight.price
        departureLabel.text = flight.departure
        arrivalLabel.text = flight.arrival
        durationLabel.text = flight.duration
        distanceLabel.text = flight.distance
        airlinesLabel.text = flight.airlines
        if let imageUrl = Endpoint.images(size: API.ImageSize._600.rawValue, location: flight.destinationLocation).components.url {
            
            let image = imageCache.object(forKey: imageUrl as NSURL)
            imageView.image = image != nil ? image : UIImage(named: "flightPlaceholder")
            
            if image == nil {
                imageView.downloadImage(url: imageUrl)
            }
        }
        
        if let iata = flight.firstIata, let airlinesIconUrl = Endpoint.airlineIcons(iata: iata).components.url {
            let image = imageCache.object(forKey: airlinesIconUrl as NSURL)
            airlinesIcon.image = image != nil ? image : nil
            
            if image == nil {
                airlinesIcon.downloadImage(url: airlinesIconUrl)
            }
        }
    }
}

let imageCache = NSCache<NSURL, UIImage>()

extension UIImageView {

    func downloadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let `self` = self else { return }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                return
            }
            if let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url as NSURL)
                    
                DispatchQueue.main.async {
                    UIView.transition(with: self,
                                        duration: 0.75,
                                        options: .transitionCrossDissolve,
                                        animations: { self.image = UIImage(data: data); self.layoutSubviews() },
                                        completion: nil)
                }
            }
        }.resume()
    }
    
}
