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
import Alamofire
import AlamofireImage

class MapVC: UIViewController {

    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    let screenSize = UIScreen.main.bounds
    let locationManager = CLLocationManager()
    let flowLayout = UICollectionViewFlowLayout()
    
    var spinner: UIActivityIndicatorView?
    var progressLbl: UILabel?
    var photoCollectionView: UICollectionView?
    var imageUrlArray = [String]()
    var imageArray = [UIImage]()
    
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
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.center = CGPoint(x: screenSize.width / 2, y: 150 - ((spinner?.frame.height)! / 2))
        spinner?.startAnimating()
        
        photoCollectionView?.addSubview(spinner!)
    }
    
    func addProgressLbl() {
        progressLbl = UILabel()
        progressLbl?.frame = CGRect(x: (screenSize.width / 2) - 120, y: 175, width: 240, height: 40)
        progressLbl?.font = UIFont(name: "Avenir Next", size: 14)
        progressLbl?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        progressLbl?.textAlignment = .center
        progressLbl?.text = "..."
        //progressLbl?.text = "12/40 PHOTO LOADED"
        
        photoCollectionView?.addSubview(progressLbl!)
    }
    
    func removePin() {
        for annotation in mapView.annotations {
            mapView.removeAnnotation(annotation)
        }
    }
    
    func cancelAllSessions() {
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach({ $0.cancel() })
            downloadData.forEach({ $0.cancel() })
        }
    }
    
    func retrieveImages(completion: @escaping (_ status: Bool) -> Void) {
        for url in imageUrlArray {
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                guard let image = response.result.value else { return }
                
                self.imageArray.append(image)
                UIView.animate(withDuration: 0.2, animations: {
                    self.progressLbl?.text = "\(self.imageArray.count)/\(self.imageUrlArray.count) PHOTOS DOWNLOADED"
                })
                
                
                if self.imageArray.count == self.imageUrlArray.count {
                    completion(true)
                }
            })
        }
    }
    
    func retrieveUrls(forAnnotation annotation: DroppablePin, completion: @escaping (_ status: Bool) -> Void) { 
        Alamofire.request(flickrUrl(forApiKey: apiKey, withAnnotaion: annotation, andNumberOfPhotos: 40)).responseJSON { (response) in
//            guard let data = response.data else {
//                completion(false)
//                return
//            }
            
            guard let json = response.result.value as? Dictionary<String, Any>,
                let photosDict = json["photos"] as? Dictionary<String, Any>,
                let photosArray = photosDict["photo"] as? [Dictionary<String, Any>] else {
                completion(false)
                return
            }
            
            for photo in photosArray {
                let postUrl = "https://farm\(photo["farm"]!).staticflickr.com/\(photo["server"]!)/\(photo["id"]!)_\(photo["secret"]!)_\(photo["secret"]!)_h_d.jpg"
                
                self.imageUrlArray.append(postUrl)
            }
            
            completion(true)
        }
    }
    
    @objc func swipeHandler(_ swipeGestureRecognizer: UISwipeGestureRecognizer) {
        self.cancelAllSessions()
        self.pullUpViewHeightConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.setNeedsDisplay()
        }) { (finished) in
            if finished {
                self.spinner?.removeFromSuperview()
                self.spinner = nil
                
                self.pullUpView.removeGestureRecognizer(self.pullUpView.gestureRecognizers!.first!)
                
                self.progressLbl?.removeFromSuperview()
                self.progressLbl = nil
            }
        }
    }
    
    @objc func doubleTapHandler(_ tapGestureRecognizer: UITapGestureRecognizer) {
        cancelAllSessions()
        
        imageArray = []
        imageUrlArray = []
        
        photoCollectionView?.reloadData()
        
        removePin()
        animateViewUp()
        addSwipe()
        addSpinner()
        addProgressLbl()
        
        let touchPoint = tapGestureRecognizer.location(in: mapView)
        let touchCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = DroppablePin(coordinate: touchCoordinate, identifier: "droppablePin")
        
        mapView.addAnnotation(annotation)
        
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(touchCoordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
        
        retrieveUrls(forAnnotation: annotation) { (finished) in
            if finished {
                self.retrieveImages(completion: { (finished) in
                    if finished {
                        self.spinner?.removeFromSuperview()
                        self.spinner = nil
                        
                        self.progressLbl?.removeFromSuperview()
                        self.progressLbl = nil
                        
                        self.photoCollectionView?.reloadData()
                    }
                })
            }
        }
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
        
        photoCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        photoCollectionView?.register(PhotoCell.self, forCellWithReuseIdentifier: "photoCell")
        photoCollectionView?.delegate = self
        photoCollectionView?.dataSource = self
        photoCollectionView?.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        
        registerForPreviewing(with: self, sourceView: photoCollectionView!)
        
        pullUpView.addSubview(photoCollectionView!)
    }
}

// MARK: - UICollectionViewDataSource
extension MapVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        let imageFromIndex = imageArray[indexPath.row]
        let imageView = UIImageView(image: imageFromIndex)
        cell.addSubview(imageView)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MapVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") as? PopVC else {
            return
        }
        
        popVC.initData(forImage: imageArray[indexPath.row])
        
        present(popVC, animated: true, completion: nil)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MapVC: UIGestureRecognizerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //Check annotation is current user location
        if annotation is MKUserLocation {
            return nil
        }
        
        let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "droppablePin")
        
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

// MARK: - UIViewControllerPreviewingDelegate (support 3D touch)
extension MapVC: UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = photoCollectionView?.indexPathForItem(at: location),
            let cell = photoCollectionView?.cellForItem(at: indexPath) else {
                return nil
        }
        
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "PopVC") as? PopVC else {
            return nil
        }
        
        popVC.initData(forImage: imageArray[indexPath.row])
        
        previewingContext.sourceRect = cell.contentView.frame
        
        return popVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
}

