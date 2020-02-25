//
//  CoreLocationSession.swift
//  MapKit-Introduction-Lab
//
//  Created by Matthew Ramos on 2/25/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import Foundation

struct LocationData: Decodable {
    let locations: [Location]
}

struct Location: Decodable {
    let latitude: String
    let longitude: String
}

