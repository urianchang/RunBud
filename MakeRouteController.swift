//
//  MakeRouteController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 3/17/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import UIKit
import MapKit

class MakeRouteController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var routeName: UITextField!
    var rname: String?
    
   weak var delegate: RouteTableViewDelegate?

    
    //: Get starting location (lat, long)
    @IBAction func startButtonPressed(_ sender: UIButton) {
        self.locationManager.startUpdatingLocation()
        if let loc = self.locationManager.location {
            source = (Float(loc.coordinate.latitude), Float(loc.coordinate.longitude))
        }
    }
    
    //: Get ending location (lat, long)
    @IBAction func stopButtonPressed(_ sender: UIButton) {
        self.locationManager.stopUpdatingLocation()
        if let loc = self.locationManager.location {
            destination = (Float(loc.coordinate.latitude), Float(loc.coordinate.longitude))
        }
    }
    
    //: Variables that we're going to use
    var source: (Float,Float)?
    var destination: (Float, Float)?
    var locationManager = CLLocationManager()
    var currentlocation: CLLocation?
    
    let regionRadius: CLLocationDistance = 100
    
    @IBAction func routeunwind(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindfromroute", sender: self)
    }
    
    @IBAction func saveRoutePressed(_ sender: UIBarButtonItem) {
        rname = routeName.text
        let newtrail = runTrail(name: rname!, start: source!, end: destination!, rating: 5.0, comments: [])
        print("this is \(newtrail)")
        self.delegate?.routesaved(by: self, with: newtrail)
        print(self.delegate)
        performSegue(withIdentifier: "unwindfromroute", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        mapView?.showsUserLocation = true
        self.locationManager.startUpdatingLocation()
        self.mapView?.delegate = self
        
        //: Get initial location and center map around it
        let initialLocation = CLLocation(latitude: (self.mapView?.userLocation.coordinate.latitude)!, longitude: (self.mapView?.userLocation.coordinate.longitude)!)
        currentlocation = initialLocation
        centerMapOnLocation(initialLocation)
       
    }
    
    //: Helper function to center the map view on specific location
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView!.setRegion(coordinateRegion, animated: true)
    }
    
    //: Function for authorization status
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
            self.mapView?.showsUserLocation = true
        default: break
        }
    }
    
    //: Function for updating locations
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last! as CLLocation
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapView?.setRegion(region, animated: true)
    }
    
}
