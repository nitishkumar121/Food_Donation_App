//
//  LocationManager.swift
//  FoodDonation
//
//  Created by Nitish Kumar on 30/06/22.
//

import Foundation

import UIKit
import MapKit
import CoreLocation

protocol ShowCurrentLocation : AnyObject {
    func showCurrentLocation(location : CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    static let shared = LocationManager()
    weak var locationDelegate : ShowCurrentLocation?

    private override init() {
        super.init()
        if CLLocationManager.locationServicesEnabled() {
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.requestAlwaysAuthorization()
            manager.requestWhenInUseAuthorization()
        }
    }

    static func requestGPS() {
        LocationManager.shared.manager.requestLocation()

    }
}
extension LocationManager {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationDelegate?.showCurrentLocation(location: location)
            manager.stopUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
        if (error as? CLError)?.code == .denied {
            manager.stopUpdatingLocation()
            manager.stopMonitoringSignificantLocationChanges()
        }
    }
}
