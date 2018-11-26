//
//  JSONViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-21.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class JSONViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    
    // Mark: Default functions
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
    
    // MARK: Actions
    @IBAction func randomPhotoPressed(_ sender: Any) {
        print("Button pressed!")
        
        let url = "https://dog.ceo/api/breeds/image/random"

        Alamofire.request(url, method: .get, parameters: nil).responseJSON {
            (response) in
            
            // -- put your code below this line
            
            if (response.result.isSuccess) {
                print("awesome, i got a response from the website!")
                print("Response from webiste: " )
                print(response.data)
                
                do {
                    let json = try JSON(data:response.data!)
                    print(json)
                    
                    // Get the dog photo url
                    let p = json["message"].string!
                    print(p)
                    
                    // Show the photo url in the user interface
                    self.infoLabel.text = p
                    
                    // Code to put the photo into an ImageView
                    let url = URL(string: p)
                    let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                    self.imageView.image = UIImage(data: data!)
 
                    
                }
                catch {
                    print ("Error while parsing JSON response")
                }
                
            }
            
        }
        

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
