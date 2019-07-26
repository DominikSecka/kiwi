//
//  FlightsViewController.swift
//  Kiwi
//
//  Created by Dominik Secka on 25/07/2019.
//  Copyright © 2019 Dominik Secka. All rights reserved.
//

import UIKit
import Lottie

class FlightsViewController: UIViewController {
    
    //  MARK: - Constants
    let animationView = AnimationView()
    
    //  MARK: - Outlets
    @IBOutlet var flightsCollectionView: UICollectionView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var refreshButton: UIButton!
    
    //  MARK: - Variables
    var presenter: FlightsPresenterProtocol?
    
    //  MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewLoaded()
    }
    
    @IBAction func refreshTriggered(_ sender: UIButton) {
        presenter?.clearFlights()
        presenter?.notifyViewLoaded()
    }
    
}

// MARK: - FlightsView protocol
extension FlightsViewController: FlightsViewProtocol {
    
    func showLoading() {
        let animation = Animation.named("loading2")
        refreshButton.isHidden = true
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        flightsCollectionView.backgroundView = animationView
        animationView.play()
    }
    
    func hideLoading() {
        flightsCollectionView.backgroundView = nil
        refreshButton.isHidden = false
    }
    
    func stopLoading() {
        animationView.stop()
        refreshButton.isHidden = false
    }
    
    func reloadData() {
        pageControl.numberOfPages = presenter?.getFlights().count ?? 0
        UIView.transition(with: pageControl,
                            duration: 0.75,
                            options: .transitionCrossDissolve,
                            animations: {
                                self.pageControl.isHidden = self.presenter?.getFlights().count == 0
                            },
                            completion: nil)
        flightsCollectionView.performBatchUpdates({
            flightsCollectionView.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
    
    func setupInitialView() {
        flightsCollectionView.delegate = self
        flightsCollectionView.dataSource = self
        scrollView.delegate = self
        pageControl.isHidden = true
    }
    
}

//  MARK: - Flights CollectionView
extension FlightsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let flights = presenter?.getFlights() else {
            return 0
        }
        
        return flights.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "flightCell", for: indexPath) as? FlightCollectionViewCell else { return UICollectionViewCell() }
        let flight = presenter!.getFlights()[indexPath.row]
        cell.setupCell(with: flight)
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.safeAreaLayoutGuide.layoutFrame.width - 50, height: collectionView.safeAreaLayoutGuide.layoutFrame.height)
    }
    
}

//  MARK: - Flights ScrollView
extension FlightsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [FlightCollectionViewCell] {
                let indexPath = collectionView.indexPath(for: cell)!
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                let translationX = cellFrame.origin.x / 5
                cell.imageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
            }
            
            pageControl.currentPage = Int(round(scrollView.contentOffset.x/view.frame.width))
        }
    }

    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}
