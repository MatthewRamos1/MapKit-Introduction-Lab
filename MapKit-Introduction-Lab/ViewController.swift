//
//  ViewController.swift
//  MapKit-Introduction-Lab
//
//  Created by Matthew Ramos on 2/25/20.
//  Copyright © 2020 Matthew Ramos. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //
    private var annotations = [MKPointAnnotation]()
    private var userTrackingButton = MKUserTrackingButton()
    private var isShowingAnnotations = false
    private var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func getLocations() {
        LocationAPIClient.fetchLocations { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "Couldn't access locations: \(appError)")
                }
            case .success(let locations):
                DispatchQueue.main.async {
                    self?.locations = locations
                }
            }
            
        }
    }


}

