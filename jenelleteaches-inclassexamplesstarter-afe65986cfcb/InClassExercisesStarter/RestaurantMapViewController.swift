
//  RestaurantMapViewController.swift
//  InClassExercisesStarter

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import CoreLocation
import FirebaseFirestore

class RestaurantMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
     var db:Firestore!
      var name = ""
      var row = ""
    var d = 0
    var userdata:[String:[String:Any]] = [:]
   // var pin:[MKPointAnnotation] = [MKPointAnnotation()]
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // variables for getting lat and
    var lat = 0.0
    var lng = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
        db = Firestore.firestore()
       self.mapView.delegate = self
           let x = CLLocationCoordinate2DMake(43.6532, -79.3832)
           let y = MKCoordinateSpanMake(0.01, 0.01)
           let z = MKCoordinateRegionMake(x, y)
         self.mapView.setRegion(z, animated: true)
         db.collection("users").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.d = querySnapshot!.documents.count
            for document in querySnapshot!.documents {
                //print("\(document.documentID) = \(document.data())")
                self.userdata[document.documentID] =  document.data()
                print(self.userdata[document.documentID] ?? "unknown")
                }
            }
            for i in self.userdata.values {
                print(i["name"]!)
                let pin = MKPointAnnotation()
                self.lat = i["latitude"]! as! Double
                self.lng = i["longitude"]! as! Double
                let x = CLLocationCoordinate2DMake(self.lat , self.lng)

                pin.coordinate = x
                pin.title = i["pokemon"]! as? String
                print("--------")
                print(self.lat)
                print(self.lng)
                print(pin.title)
                print("---------")
        
                self.mapView.addAnnotation(pin)

            }
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Actions
    @IBAction func zoomInPressed(_ sender: Any) {
        
        print("zoom in!")
        
        var r = mapView.region
        
        print("Current zoom: \(r.span.latitudeDelta)")
        
        r.span.latitudeDelta = r.span.latitudeDelta / 4
        r.span.longitudeDelta = r.span.longitudeDelta / 4
        print("New zoom: \(r.span.latitudeDelta)")
        print("-------")
        self.mapView.setRegion(r, animated: true)
        
        // HINT: Check MapExamples/ViewController.swift
    }
    
    @IBAction func zoomOutPressed(_ sender: Any) {
        // zoom out
        print("zoom out!")
        
        var r = mapView.region
        r.span.latitudeDelta = r.span.latitudeDelta * 2
        r.span.longitudeDelta = r.span.longitudeDelta * 2
        self.mapView.setRegion(r, animated: true)
        
        // HINT: Check MapExamples/ViewController.swift
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

