//
//  CoreLocationSession.swift
//  MapKit-Introduction-Lab
//
//  Created by Matthew Ramos on 2/25/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation
import CoreLocation

struct Location: Decodable {
    let latitude: String
    let longitude: String
}

class CoreLocationSession: NSObject {
  
  public var locationManager: CLLocationManager
  
  override init() {
    locationManager = CLLocationManager()
    super.init()
    locationManager.delegate = self
    
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
  }
  
  public func convertCoordinateToPlacemark(coordinate: CLLocationCoordinate2D) {
    let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    
    CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
      if let error = error {
        print("reverseGeocodeLocation: \(error)")
      }
      if let firstPlacemark = placemarks?.first {
        print("placemark info: \(firstPlacemark)")
      }
    }
  }
  
    public func convertPlaceNameToCoordinate(addressString: String, completion: @escaping (Result<CLLocationCoordinate2D, Error>) -> ()) {
    CLGeocoder().geocodeAddressString(addressString) { (placemarks, error) in
      if let error = error {
        print("geocodeAddressString: \(error)")
        completion(.failure(error))
      }
      if let firstPlacemark = placemarks?.first,
        let location = firstPlacemark.location {
        print("place name coordinate is \(location.coordinate)")
        completion(.success(location.coordinate))
      }
    }
  }
}
    //
extension CoreLocationSession: CLLocationManagerDelegate {
    
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    switch status {
    case .authorizedAlways:
      print("authorizedAlways")
    case .authorizedWhenInUse:
      print("authorizedWhenInUse")
    case .denied:
      print("denied")
    case .notDetermined:
      print("notDetermined")
    case .restricted:
      print("restricted")
    default:
      break
    }
  }
}
