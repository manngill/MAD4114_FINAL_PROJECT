
//  LoginViewController.swift
//  InClassExercisesStarter

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    var email = ""
    var password = ""
    @IBOutlet weak var txtMessage: UILabel!
    
    @IBAction func btnLogin(_ sender: Any) {
        email = txtEmail.text!
        password  = txtPassword.text!
        
        Auth.auth().signIn(withEmail: email, password: password) {
            
            (user, error) in
            
            if (user != nil) {
                // 1. Found a user!
                print("User signed in! ")
                print("User id: \(user?.user.uid)")
                print("Email: \(user?.user.email)")
                
                var id = user?.user.email
                
                let userDefaults = UserDefaults.standard
                userDefaults.setValue(id, forKey: "userId")
                userDefaults.synchronize()
                
                print("user id ", id)
                
                
                // 2. So send them to screen 2!
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                // 1. A problem occured when looking up  the user
                // - doesn't meet password requirements
                // - user already exists
                print("ERROR!")
                print(error?.localizedDescription)
                
                self.txtMessage.text = error?.localizedDescription
                
                // 2. Show the error in user interface
               // self.statusMessageLabel.text = error?.localizedDescription
            }
        }
    }
    
    @IBAction func btnSignup(_ sender: Any) {
        email = txtEmail.text!
        password  = txtPassword.text!
        
        // Authorize user
        Auth.auth().createUser(withEmail: email, password: password) {
            
            (user, error) in
            
            if (user != nil) {
                // 1. New user created!
                print("Created user: ")
                print("User id: \(user?.user.uid)")
                print("Email: \(user?.user.email)")
                
                self.txtMessage.text = "Account Created. Please login to countinue"
            }
            else {
                // 1. Error when creating a user
                print("ERROR!")
                print(error?.localizedDescription)
                
                // 2. Show the error in the UI
                self.txtMessage.text = error?.localizedDescription
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            var user = ""
        if UserDefaults.standard.object(forKey: "userId") != nil
        {
            user =  UserDefaults.standard.string(forKey: "userId")!
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tableVC") as! MenuTableViewController
            self.present(newViewController, animated: true, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
