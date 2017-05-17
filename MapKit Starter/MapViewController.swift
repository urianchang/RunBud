//
//  ViewController.swift
//  MapKit Starter
//
//  Created by Glen Jantz, Carolyn Yen, Urian Chang on 03/16/17.
//  Copyright © 2017 Coding Dojo. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet var mapView: MKMapView?
    @IBAction func showRouteDetails(_ sender: UIButton) {
        if let time = travelTime { travelTime = time}
        if let miles = mileage {mileage = miles}
        if let calorie = calories {calories = calorie}
        routeDetailsLabel.text = "Travel time: \(travelTime!) minutes | Mile(s): \(mileage!) | Calories burned: \(calories!)"
        routeDetailsLabel.isHidden = !(routeDetailsLabel.isHidden)
    }
    @IBOutlet weak var routeDetailsLabel: UILabel!
    
    //: Variables that we're going to use
    var source: (Float,Float)?
    var destination: (Float, Float)?
    var locationManager = CLLocationManager()
    var currentlocation: CLLocation?
    var travelTime : Int?
    var mileage: String?
    var calories: Float?
    let regionRadius: CLLocationDistance = 10000
    
    @IBAction func startrun(_ sender: Any) {
        self.locationManager.startUpdatingLocation()
    }
    
    @IBAction func stoprun(_ sender: Any) {
        self.locationManager.stopUpdatingLocation()
    }
    
    @IBAction func goback(_ sender: Any) {
        performSegue(withIdentifier: "unwind", sender: self)
    }
    
    //: Helper function to center the map view on specific location
    func centerMapOnLocation(_ location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView!.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView?.delegate = self
        
        //: Get initial location and center map around it
        let initialLocation = CLLocation(latitude: (self.mapView?.userLocation.coordinate.latitude)!, longitude: (self.mapView?.userLocation.coordinate.longitude)!)
        currentlocation = initialLocation
        centerMapOnLocation(initialLocation)
        
        //: Get route start and end
        let sourceLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(source!.0), longitude: CLLocationDegrees(source!.1))
        let destinationLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(destination!.0), longitude: CLLocationDegrees(destination!.1))
        
        //: Get placemarks for start and end
        let sourcePlacemark = MKPlacemark(coordinate: sourceLocation, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: destinationLocation, addressDictionary: nil)
        
        //: Get map items for start and end
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        
        //: Add annotations
        let sourceAnnotation = MKPointAnnotation()
        sourceAnnotation.title = "Route Start"
        if let location = sourcePlacemark.location {
            sourceAnnotation.coordinate = location.coordinate
        }
        let destinationAnnotation = MKPointAnnotation()
        destinationAnnotation.title = "Route End"
        if let location = destinationPlacemark.location {
            destinationAnnotation.coordinate = location.coordinate
        }
        
        //: Show annotations
        self.mapView?.showAnnotations([sourceAnnotation,destinationAnnotation], animated: true)
        
        //: Request for directions
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .walking
        
        //: Calculate directions
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
        }
        
        //: Get first route
        let route = response.routes[0]
            
        //: Going to display this info
        self.travelTime = Int(route.expectedTravelTime/60)
        let miles = route.distance*0.000621371
        self.mileage = String(format: "%.2f", miles)
        // On average, about 100 calories burned per mile
        self.calories = Float(self.mileage!)!/100.0
        
        //: Draw the route onto the map
        self.mapView?.add((route.polyline), level: MKOverlayLevel.aboveRoads)
        
        //: Set map region
        let rect = route.polyline.boundingMapRect
        self.mapView?.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        
        //: Stop updating location so map doesn't snap back to reality ;)
        self.locationManager.stopUpdatingLocation()
    }

    //: Function for rendering overlay
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
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


