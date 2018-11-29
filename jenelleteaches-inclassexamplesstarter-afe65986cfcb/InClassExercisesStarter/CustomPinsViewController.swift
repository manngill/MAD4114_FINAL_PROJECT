//
//  CustomPinsViewController.swift
//  InClassExercisesStarter
//
//  Created by Sukhwinder Rana on 2018-11-28.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import MapKit

class CustomPinsViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded the map")
        self.mapView.delegate = self
        
        let center = CLLocationCoordinate2DMake(48.8566, 2.3522)
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region = MKCoordinateRegionMake(center, span)
        
        self.mapView.setRegion(region, animated: true)
        
        // add a pin
        let pin = MKPointAnnotation()
        let pinLocation = CLLocationCoordinate2DMake(48.8566, 2.3522)
        pin.coordinate = pinLocation
        pin.title="PIKACHU!!!!"
        self.mapView.addAnnotation(pin)
        
        print("put the pin on the map")
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // YOUTUBE LINK: https://www.youtube.com/watch?v=FSHz5CnYSOY
        
        if !(annotation is MKPointAnnotation) {
            print("I found a pin, but it's not of type MKPointAnnotation!")
            return nil  // exit this function!
        }
        
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "pokemonIdentifier")
        
        if (annotationView == nil) {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pokemonIdentifier")
            annotationView!.canShowCallout = false
        }
        else {
            annotationView!.annotation = annotation
        }
        
        // pick the image for the pin
        annotationView!.image = UIImage(named:"pikachu.png")
        
        // set the size of the pin - in the example below, it sets: height = 64, width = 65
        annotationView!.bounds.size.height = CGFloat(64)
        annotationView!.bounds.size.width = CGFloat(64)
        
        
        return annotationView
        
    }
    
}
