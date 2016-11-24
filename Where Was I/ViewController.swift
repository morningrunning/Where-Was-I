//
//  ViewController.swift
//  Where Was I
//
//  Created by Ronald Morgan on 11/23/16.
//  Copyright © 2016 Ronald Morgan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func UpdateSavedPin () {
        if let oldCoords = DataStore().GetLastLocation() {
            
            let annoRem = mapView.annotations.filter{$0 !== mapView.userLocation}
            mapView.removeAnnotations(annoRem)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate.latitude = Double(oldCoords.latitude)!
            annotation.coordinate.longitude = Double(oldCoords.longitude)!
            
            annotation.title = "I was here!"
            annotation.subtitle = "Remember?"
            mapView.addAnnotation(annotation)
        }
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else{
            print("location not enabled")
            return
        }
        
        print("location allowed")
        mapView.showsUserLocation = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonClicked(_ sender: AnyObject) {
        let coord = locationManager.location?.coordinate
        
        if let lat = coord?.latitude {
        if let long = coord?.longitude{
            DataStore().StoreDataPoint(latitude: String(lat), longitude: String(long))
               UpdateSavedPin()
            }
        }
        
    }

}

