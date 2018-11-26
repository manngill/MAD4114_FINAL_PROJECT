// Reservation VC for reserving restraunts

import UIKit
import FirebaseFirestore
import Alamofire
import SwiftyJSON


class MakeReservationViewController: UIViewController {
    var name = [String]()
    @IBOutlet weak var msgL: UILabel!
    // MARK: Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dayTextField: UITextField!
    @IBOutlet weak var seatsTextField: UITextField!
    
    //@IBOutlet weak var lblResult: UILabel!
    // Mark: Firestore variables
    var db:Firestore!
    var bc = ""
    
    // MARK: Default Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bc = UserDefaults.standard.string(forKey: "userId")!
        print(bc)
        db = Firestore.firestore()
        
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func buttonPressed(_ sender: Any) {
        print("pressed the button")
// url to fetch data from webpage
            let url = "https://opentable.herokuapp.com/api/restaurants?city=Toronto&per_page=5"
            
            Alamofire.request(url, method: .get, parameters: nil).responseJSON {
                (response) in
          
                if (response.result.isSuccess) {
                    print("awesome, i got a response from the website!")
                   // print(response.data)
                    
                    do {
                        let json = try JSON(data:response.data!)
                        let array = [0, 1, 2, 3, 4]
                        for i in array
                        {
                            var n  = json["restaurants"][i]["name"].string!
                            self.name.append(n)
                            print("name == ", self.name)

                        }
                    }
                    catch {
                        print ("Error getting data")
                    }
                    
                }
        }
        
        print("names = ",self.name)
        if (name.contains(nameTextField.text!))
        {
        
            // Creating collection for reservation
        let res = db.collection("reservations")
        
            //Sending data to firebase firestore
        res.document(bc + nameTextField.text! + dayTextField.text!).setData([
            "username": bc,
            "restaurant": nameTextField.text!,
            "day" : dayTextField.text!,
            "numSeats": seatsTextField.text!
                        ])
            
            // message after sucessful insertion
            msgL.text = "Reservation Successfull.  Go back and see the reservations menu"
    }
        
            // message if restaraunt in the the list or invalid restaraunt name
        else
        {
            msgL.text = "Error! Try again later "
        }
        
    }
    
}
