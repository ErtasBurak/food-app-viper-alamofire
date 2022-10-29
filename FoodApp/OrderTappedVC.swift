//
//  OrderTappedVC.swift
//  FoodApp
//
//  Created by Burak Ertaş on 27.10.2022.
//

import UIKit
import CoreLocation
import MapKit
import Lottie

class OrderTappedVC: UIViewController {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var delivery: LottieAnimationView!
    
    @IBOutlet weak var mapKit: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        locationManager.delegate = self
        
        // 1. Set animation content mode
        delivery.contentMode = .scaleToFill
        // 2. Set animation loop mode
        delivery.loopMode = .loop
        // 3. Adjust animation speed
        delivery.animationSpeed = 1
        // 4. Play animation
        delivery.play()
        
    }
    
    

}

extension OrderTappedVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations[locations.count - 1]
        
        let latitude = lastLocation.coordinate.latitude
        let longitude = lastLocation.coordinate.longitude
        
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapKit.setRegion(region, animated: true)
        
        mapKit.showsUserLocation = true
    }
}
