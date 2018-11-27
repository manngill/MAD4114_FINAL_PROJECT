
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
    var userdata:[String:Any] = [:]
    var arr:[String] = []
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
        db.collection("user").getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.d = querySnapshot!.documents.count
                var j = ""
                var s = 0
              for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")

                    if (s <= self.d){
                      self.userdata[document.documentID] =  document
                        //self.userdata[document.documentID] = document.data()
                        self.arr[s] = self.userdata[document.documentID]! as! String
                        s = s+1
                }
            }
        }
        }
            
        let arr1 =  self.arr.count
            var i = 0
       // for i in arr1
        repeat
                    {
                        var id = self.arr[i]
                        var userPin = self.userdata[id]
                        let pin = MKPointAnnotation()
                         self.lat = (self.userdata[id] as AnyObject).latitude
                        self.lng = (self.userdata[id] as AnyObject).longitude
                        let x = CLLocationCoordinate2DMake(self.lat , self.lng)
                        
                        pin.coordinate = x
                        
                        // 3. OPTIONAL: add a information popup (a "bubble")
                        pin.title = (self.userdata[id] as AnyObject).name
                        
                        // 4. Show the pin on the map
                        self.mapView.addAnnotation(pin)
                        i = i+1
                }while (i < arr1)
                
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
        print("-=------")
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

