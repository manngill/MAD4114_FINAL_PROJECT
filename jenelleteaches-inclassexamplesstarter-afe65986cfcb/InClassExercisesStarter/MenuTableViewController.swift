
//  MenuTableViewController.swift
//  InClassExercisesStarter

import UIKit
import FirebaseFirestore
import CoreLocation
import MapKit

class MenuTableViewController: UITableViewController,CLLocationManagerDelegate{
    var manager:CLLocationManager!
    var name = ""
    var latitude = 43.6532
    var longitude = -79.3832
    var l = 0.0001
    //set value of l into user defaults

     var db:Firestore!
    var items = ["Meon", "Pikachu", "Squirtle","Zubar","Jigglypuff"]
     var images = ["meon.png", "pikachu.png", "squirtle.png","zubar.png","jigglypuff.png"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        if UserDefaults.standard.object(forKey: "lat") != nil
        {
            latitude =  Double(UserDefaults.standard.string(forKey: "lat")!) ?? 43.6532
            longitude =  Double(UserDefaults.standard.string(forKey: "lng")!) ?? -79.3832
        }
        manager = CLLocationManager()
        manager.delegate = self
        
        // how accurate do you want the lkocation to be?
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        // ask for permission to get the location
        manager.requestAlwaysAuthorization()
        
        // tell the manager to get the person's location
        manager.startUpdatingLocation()
         pokemonData()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got a new location")
        
        if (locations.count == 0) {
            print("Error getting your location!")
            return
        }
        else {
            print(locations[0])
            let searchRequest = MKLocalSearchRequest()
            latitude = locations[0].coordinate.latitude
            longitude = locations[0].coordinate.longitude
           
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.row
        
        print("Person clicked in row number: \(i)")
         UserData()
//
      // if (i != nil) {
         performSegue(withIdentifier: "viewRest", sender: nil)
      // }
//
//        else if (i == 1) {
//            performSegue(withIdentifier: "makeReservation", sender: nil)
//        }
//
//        else if (i == 2) {
//            performSegue(withIdentifier: "showRest", sender: nil)
//        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let i = self.tableView.indexPathForSelectedRow?.row
        
        
        print("Selected row: \(i)")
        let n1 = segue.destination as! RestaurantMapViewController
        n1.name = name
        n1.row = images[i ?? 0]
       // n1.r = i ?? 0
        
        print("\(i) row selected as pokemon")
       
            
    }
    func pokemonData() {
        let pokemon = db.collection("Pokemon")
        
        pokemon.document("Meon").setData([
            "name": "Meon",
            "image": "meon.png",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Pikachu").setData([
            "name": "Pikachu",
            "image": "pikachu.png",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Squirtle").setData([
            "name": "Squirtle",
            "image": "squirtle.png",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Zubar").setData([
            "name": "Zubar",
            "image": "zubar.png",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Jigglypuff").setData([
            "name": "Jigglypuff",
            "image": "jigglypuff.png",
            "defence": 5,
            "action": 10
            ])
    }
    func  UserData() {
        let user = db.collection("users")
//        user.document("jenelle@gmail.com").setData([
//            "name": "jenelle@gmail.com",
//            "latitude": 43.6532 ,
//            "longitude": -79.3832,
//            "pokemon": "Meon"
//            ])
        latitude = latitude + l
        longitude = longitude - l
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(latitude, forKey: "lat")
        userDefaults.setValue(longitude, forKey: "lng")
        userDefaults.synchronize()
        var n = self.name
        user.document(n).setData([
            "name": self.name,
            "latitude": latitude,
            "longitude": longitude,
            "pokemon": "Meon"
            ])
    }

}
