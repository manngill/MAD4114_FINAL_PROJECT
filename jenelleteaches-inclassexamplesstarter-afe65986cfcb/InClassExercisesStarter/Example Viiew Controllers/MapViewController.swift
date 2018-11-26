//
//  MapViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-21.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    // Mark: Outlets
    // ------------------
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: Core Location variables
    var manager:CLLocationManager!
    

    
    // Mark: Default functions
    // ------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Setup Core Location variables
        self.manager = CLLocationManager()
        self.manager.delegate = self
        self.manager.desiredAccuracy = kCLLocationAccuracyBest
        self.manager.requestAlwaysAuthorization()
        
        // Set up Map variables
        
        //self.mapView = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark:  Actions
    
    
    // Mark:  Core Location functions
    
    /* Uncomment this function to get the user's location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        <#code#>
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
