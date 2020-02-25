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
    
    private var locationSession = CoreLocationSession()
    private var annotations = [MKPointAnnotation]()
    private var userTrackingButton = MKUserTrackingButton()
    private var isShowingAnnotations = false
    private var locations = [Location]() {
        didSet {
            loadMap()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocations()
        mapView.showsUserLocation = true
        userTrackingButton = MKUserTrackingButton(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView
        mapView.delegate = self
        
    }
    
    private func getLocations() {
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
    private func makeAnnotations() -> [MKPointAnnotation] {
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.title = location.schoolName
            annotation.coordinate = createCooridinate(location: location)!
            annotations.append(annotation)
        }
        isShowingAnnotations = true
        self.annotations = annotations
        return annotations
    }
    
    private func createCooridinate(location: Location) -> CLLocationCoordinate2D? {
        guard let longitudeNum = Double(location.longitude), let latitudeNum = Double(location.latitude) else {
            print("Error getting coordinates")
            return nil
        }
        
        guard let longitude = CLLocationDegrees(exactly: longitudeNum), let latitude = CLLocationDegrees(exactly: latitudeNum) else {
            print("Error getting special degrees")
            return nil
        }
        
        let location2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return location2D
    }
    
    private func loadMap() {
        let annotations = makeAnnotations()
        mapView.addAnnotations(annotations)
    }
}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        let identifier = "annotationView"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.glyphImage = UIImage(systemName: "pencil")
            annotationView?.glyphTintColor = .systemYellow
            annotationView?.markerTintColor = .systemTeal
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        if isShowingAnnotations {
            mapView.showAnnotations(annotations, animated: false)
        }
        isShowingAnnotations = false
    }
}


