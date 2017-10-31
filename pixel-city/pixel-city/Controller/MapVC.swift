//
//  MapVC
//  pixel-city
//
//  Created by Kent Nguyen on 10/30/17.
//  Copyright © 2017 PLIDS. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController {

    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    let screenSize = UIScreen.main.bounds
    
    var locationManager = CLLocationManager()
    var spinner: UIActivityIndicatorView?
    var progressLbl: UILabel?
    
    func configureLocationService() {
        if authorizationStatus == CLAuthorizationStatus.notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else {
            return
        }
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2, regionRadius * 2)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func addDoubleTap() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(MapVC.doubleTapHandler(_:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        
        mapView.addGestureRecognizer(doubleTap)
    }
    
    func addSwipe() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(MapVC.swipeHandler(_:)))
        
        swipe.direction = .down
        
        pullUpView.addGestureRecognizer(swipe)
    }
    
    func animateViewUp() {
        UIView.animate(withDuration: 0.3) {
            self.pullUpViewHeightConstraint.constant = 300
        }
    }
    
    func addSpinner() {
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner?.color = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        spinner?.center = CGPoint(x: (screenSize.width / 2) - ((spinner?.frame.width)! / 2), y: 150 - ((spinner?.frame.height)! / 2))
        spinner?.startAnimating()
        
        pullUpView.addSubview(spinner!)
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    @objc func swipeHandler(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        pullUpView.removeGestureRecognizer(pullUpView.gestureRecognizers!.first!)
        UIView.animate(withDuration: 0.3, animations: {
            self.pullUpViewHeightConstraint.constant = 0
        }) { (finished) in
            if finished {
                self.spinner?.removeFromSuperview()
                
                self.spinner = nil
            }
        }
    }
    
    @objc func doubleTapHandler(_ tapGestureRecognizer: UITapGestureRecognizer) {
        removePin()
        animateViewUp()
        addSwipe()
        addSpinner()
        
        let touchPoint = tapGestureRecognizer.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pullUpView: UIView!
    @IBOutlet weak var mapViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var pullUpViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - IBAction
    
    @IBAction func centerMapBtnPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        
        configureLocationService()
        addDoubleTap()
    }
}


// MARK: - UIGestureRecognizerDelegate
extension MapVC: UIGestureRecognizerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Check annotation is current user location
        if annotation is MKUserLocation {
            return nil
        }
        
        var pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        
        pinAnnotation.pinTintColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        pinAnnotation.animatesDrop = true
        
        return pinAnnotation
    }
}

// MARK: - MKMapViewDelegate
extension MapVC: MKMapViewDelegate {
    
}

// MARK: - CLLocationManagerDelegate
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
}

