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
    var userTrackingButton = MKUserTrackingButton()
    private var isShowingAnnotations = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}

