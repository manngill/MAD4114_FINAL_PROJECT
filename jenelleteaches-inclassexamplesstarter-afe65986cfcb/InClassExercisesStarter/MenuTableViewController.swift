
//  MenuTableViewController.swift
//  InClassExercisesStarter

import UIKit

class MenuTableViewController: UITableViewController {

    var items = ["Restaurant Map", "Make a reservation", "Show reservation"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if (i == 0) {
            performSegue(withIdentifier: "viewRest", sender: nil)
        }
        
        else if (i == 1) {
            performSegue(withIdentifier: "makeReservation", sender: nil)
        }
        
        else if (i == 2) {
            performSegue(withIdentifier: "showRest", sender: nil)
        }
        
        
    }

}
