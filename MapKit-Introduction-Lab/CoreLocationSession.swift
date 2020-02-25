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
    let schoolName: String
    let overviewParagraph: String
    
    private enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
    }
}

class CoreLocationSession: NSObject {
  
  public var locationManager: CLLocationManager
  
  override init() {
    locationManager = CLLocationManager()
    super.init()
    
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
  }
}
