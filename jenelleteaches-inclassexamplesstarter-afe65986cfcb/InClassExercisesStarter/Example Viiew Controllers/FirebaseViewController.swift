//
//  ViewController.swift
//  InClassExercisesStarter
//
//  Created by parrot on 2018-11-21.
//  Copyright © 2018 room1. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FirebaseViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var searchBox: UITextField!
    
    // 1. Create the firebase variable
    var db:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 2. Setup the db variable
        
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
    // ----------------
    
    @IBAction func addEmployeesPressed(_ sender: Any) {
        

        db.collection("employees").document().setData([
            "name":"Albert",
            "id":"C01234",
            "dept":"MADT",
            "numStudents":250
            ])
        
        db.collection("employees").document().setData([
            "name":"Marcos",
            "id":"C02222",
            "dept":"CPCT",
            "numStudents":100,
            ])
        
        
        db.collection("employees").document().setData([
            "name":"Jigesha",
            "id":"C01155",
            "dept":"EMBT",
            "numStudents":30
            ])
        
        db.collection("employees").document().setData([
            "name":"Pritesh",
            "id":"C044366",
            "dept":"MADT",
            "numStudents":30
            ])
        
        db.collection("employees").document().setData([
            "name":"Alireza",
            "id":"C08078",
            "dept":"MADT",
            "numStudents":60
            ])
        
        db.collection("employees").document().setData([
            "name":"Rubem",
            "id":"C09977",
            "dept":"CPCT",
            "numStudents":125
            ])
        
        textView.text = "Employees added. Check your Firebase console."
        
    }
    @IBAction func getDataPressed(_ sender: Any) {
        
        db.collection("employees").getDocuments {
            
            (querySnapshot, err) in
            
            self.textView.text = "Look at the terminal for output!"
            
            if (err != nil) {
                print("Error!")
                print(err?.localizedDescription)
            }
            else {
                
                for x in (querySnapshot?.documents)! {
                    // Example 1: output row id
                    print(x.documentID)
                    
                    // Example 2: output all row contents
                    print(x.data())
                    
                    // Example 3: output the name of each person
                    let d = x.data();
                    print(d["name"])
                    
                    // Example 4:  Increase the number of students
                    // in each class by 30
                    var s = d["numStudents"] as! Int
                    s = s + 30
                    print("Num students - increased: \(s)")
                    
                    
                    print("----")
                    
                }
                
                
            }
            
            
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        
        //clear the text box
        textView.text = ""
        
        let results =  db.collection("employees").whereField("dept", isEqualTo: searchBox.text!)
        results.getDocuments {
            (querySnapshot, error) in
            
            
            if (error != nil) {
                print("Error!")
                print(error?.localizedDescription)
            }
            else {
                
                for x in (querySnapshot?.documents)! {
                    let content = x.data();
                    
                    let name = content["name"] as! String
                    let dept = content["dept"] as! String
                    
                    self.textView.text = self.textView.text + "Name: \(name), Program: \(dept)\n"
                    
                }
            }
            
            
        }
        
    }
    
    
    
}

