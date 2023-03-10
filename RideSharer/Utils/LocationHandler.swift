//
//  LocationHandler.swift
//  RideSharer
//
//  Created by Macbook on 14/02/2023.
//

import Foundation
import CoreLocation
class LocationHandler: NSObject, CLLocationManagerDelegate {
    //we create a shared location manger so we can access the location from any place in the app
    static let shared = LocationHandler()
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
