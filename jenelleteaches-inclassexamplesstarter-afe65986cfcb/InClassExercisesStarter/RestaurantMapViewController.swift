
//  RestaurantMapViewController.swift
//  InClassExercisesStarter

import UIKit
import Alamofire
import SwiftyJSON
import MapKit

class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    // variables for getting lat and
    var lat = ""
    var lng = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded the map screen")
        self.mapView.delegate = self
        
        let url = "https://opentable.herokuapp.com/api/restaurants?city=Toronto&per_page=5"
        
        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            (response) in
            
            // -- put your code below this line
            
            let x = CLLocationCoordinate2DMake(43.6532, -79.3832)
            
            // pick a zoom level
            let y = MKCoordinateSpanMake(0.01, 0.01)
            
            // set the region property of the mapview
            let z = MKCoordinateRegionMake(x, y)
            self.mapView.setRegion(z, animated: true)
            
            if (response.result.isSuccess) {
                print("awesome, i got a response from the website!")
                print("Response from webiste: " )
                print(response.data)
                
                do {
                    let json = try JSON(data:response.data!)
                    print(json)
                    // print("\(json["restaurants"][0]["name"])")
                    let arr = [0, 1, 2, 3, 4]
                    for i in arr
                    {
                        let pin = MKPointAnnotation()
                        var lat = json["restaurants"][i]["lat"].double
                        var lng = json["restaurants"][i]["lng"].double
                        let x = CLLocationCoordinate2DMake(lat! , lng!)
                        
                        pin.coordinate = x
                        
                        // 3. OPTIONAL: add a information popup (a "bubble")
                        pin.title = json["restaurants"][i]["name"].string
                        
                        // 4. Show the pin on the map
                        self.mapView.addAnnotation(pin)
                    }
                }
                catch {
                    print ("Error getting data")
                }
                
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

