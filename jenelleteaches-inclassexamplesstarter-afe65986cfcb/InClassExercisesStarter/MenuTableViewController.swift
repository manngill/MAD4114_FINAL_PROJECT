
//  MenuTableViewController.swift
//  InClassExercisesStarter

import UIKit
import FirebaseFirestore

class MenuTableViewController: UITableViewController{
    var name = ""
    var l = 0.0001
    //set value of l into user defaults

     var db:Firestore!
    var items = ["Mew", "Pikachu", "Squirtle","Zubar"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
         pokemonData()
        UserData()
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
//
       if (i != nil) {
         performSegue(withIdentifier: "viewRest", sender: nil)
       }
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
        let n1 = segue.destination as! MakeReservationViewController
        n1.name = name
        n1.row = items[i ?? 0]
        n1.r = i ?? 0
        
        print("\(i) row selected as pokemon")
       
            
    }
    func pokemonData() {
        let pokemon = db.collection("Pokemon")
        
        pokemon.document("Meon").setData([
            "name": "Meon",
            "image": "meon",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Pikachu").setData([
            "name": "Pikachu",
            "image": "pikachu",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Squirtle").setData([
            "name": "Squirtle",
            "image": "Squirtle",
            "defence": 5,
            "action": 10
            ])
        pokemon.document("Zubar").setData([
            "name": "Zubar",
            "image": "Zubar",
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
        var n = self.name
        user.document(n).setData([
            "name": self.name,
            "latitude": 43.6534 + l ,
            "longitude": -79.3834 - l,
            "pokemon": "Meon"
            ])
        l = l + 0.0001
    }

}
