//
//  MapViewController.swift
//  ASS2
//
//  Created by SWUCOMPUTER on 2017. 12. 22..
//  Copyright © 2017년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var textLat: UILabel!
    @IBOutlet var textLong: UILabel!
    
    @IBOutlet var subView: UIView!
    @IBOutlet var map: MKMapView!
    
    var homeAnnotation: Home? = nil
    var onOff = true
    var home: Home?
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.startUpdatingLocation()
    
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count-1]
        textLat.text = String(format: "%.6f", location.coordinate.latitude)
        textLong.text = String(format: "%.6f", location.coordinate.longitude)
        
        home = Home(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        map.setRegion(MKCoordinateRegionMake((self.home?.coordinate)!,MKCoordinateSpanMake(0.007, 0.007)), animated: true)
        
        if let annotation = homeAnnotation {
            self.map.removeAnnotation(annotation)
        }

        if let annotation = home {
            self.homeAnnotation = annotation
            self.map.addAnnotation(self.homeAnnotation!)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .restricted {
                let alert = UIAlertController(title: "오류 발생",
                                              message: "위치서비스 기능이 꺼져있음", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
            }
        } else {
            let alert = UIAlertController(title: "오류 발생", message: "위치서비스 제공 불가",preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
  
    @IBAction func pressOnOff(_ sender: Any) {
        if onOff == true {
            self.subView.isHidden = true
            onOff = false
        } else {
            self.subView.isHidden = false
            onOff = true
        }
    }
}
