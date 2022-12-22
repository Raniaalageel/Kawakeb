//
//  ViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 20/05/1444 AH.
//

import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import FirebaseFirestore

class ViewController: UIViewController , EditprofileDelegate {
        func userUpdated(child: Child) {
            Unamee.text = child.name
            
            uemail.text = child.email
            udob.text = child.dob
        }
    
    @IBOutlet weak var Unamee: UILabel!
    let firestore = Firestore.firestore()
    var child : Child?
    var userId = ""
    
    
    @IBOutlet weak var uemail: UILabel!
    
    @IBOutlet weak var udob: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let id = Auth.auth().currentUser?.uid {
            userId = id
        }
        firestore.collection("Child").document(userId).getDocument { [self]snapshot, error in
            if error == nil {
                // get user data
                guard let userData = snapshot else {return}
                child = Child(email: userData["email"] as? String, name: userData["name"] as? String, dob: userData["dob"] as? String, childID: userId)
                Unamee.text = userData["name"] as? String
                uemail.text = userData["email"] as? String
                udob.text = userData["dob"] as? String
                
            } else {
                // show error message
            }
        }
     
    }

    
    
    
    
    
    
}

