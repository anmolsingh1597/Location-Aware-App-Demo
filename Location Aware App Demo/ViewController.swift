//
//  ViewController.swift
//  Location Aware App Demo
//
//  Created by Anmol singh on 2020-06-12.
//  Copyright © 2020 Swift Project. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var nearestAddressLabel: UILabel!
    
    // we need a location manager
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // we give delegate to location manager to this class
        locationManager.delegate = self
        
        // accuracy of the location
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // request user for location
        locationManager.requestWhenInUseAuthorization()
        
        //start updating the location of the user
        locationManager.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
//        print(location)
        latLabel.text = "Lat:  \(String(location.coordinate.latitude))"
        longLabel.text = "Long: \(String(location.coordinate.longitude))"
        speedLabel.text = "Speed: \(String(location.speed))"
        courseLabel.text = "Course: \(String(location.course))"
        altitudeLabel.text = "Altitude: \(String(location.altitude))"
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            if error != nil {
                print(error!)
            } else {
                if let placemark = placemarks?[0] {
                
                var address = ""
                
                    if placemark.subThoroughfare != nil{
                        address += placemark.subThoroughfare! + " "
                    }
                    
                    if placemark.thoroughfare != nil {
                         address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil {
                        address += placemark.subLocality! + "\n"
                                       }
                    
                    if placemark.subAdministrativeArea != nil {
                        address += placemark.subAdministrativeArea! + "\n"
                                       }
                    
                    if placemark.postalCode != nil {
                        address += placemark.postalCode! + "\n"
                                       }
                    
                    if placemark.country != nil {
                        address += placemark.country! + "\n"
                                       }
                    print(address)
                    self.nearestAddressLabel.text = address
                }
            }
        }
    }

}

