//
//  Profile.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 22/05/1444 AH.
//

import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import FirebaseFirestore


class Profile: UIViewController {
  
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    let firestore = Firestore.firestore()
    var emaill : String?
    var userId = ""
    
    @IBAction func logouut(_ sender: UIButton) {
    }
    @IBAction func editpro(_ sender: Any) {
    }
    @IBAction func backb(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if let id = Auth.auth().currentUser?.uid {
//            userId = id
//        }
        
        userId = "jaVVotxFxhQcA461qqeoI5VTHBy2"
        
        
        
        firestore.collection("Child").whereField("id", isEqualTo: userId).getDocuments { [self]snapshot, error in
            if error == nil {
                // get user data
                guard let userData = snapshot?.documents else {return}
                for i in userData {
                    print("***************")
                    let data = i.data()
                    name.text = data["name"] as? String
                    email.text = data["email"] as? String
                    dob.text = data["dob"] as? String
                }
            } else {
                // show error message
            }
        }
    }
    
    
    /*
    func getInfo (completion: @escaping (_ name: String?) -> Void) {
    
        guard let Uemail = Auth.auth().currentUser?.email else {
            
            completion(nil)
            return
        }
        print(Uemail)
        Firestore.firestore().collection("Child").document(Uemail).getDocument {
            (docSnapshot, error) in
            if let doc = docSnapshot {
                if let name = doc.get("name") as? String {
                    completion(name)
                    
                }
                
            }
            
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  /*
    var user : child! {
            didSet {
                updateUI(for: user)
            }
        }
    
    override func viewDidLoad() {
          super.viewDidLoad()
        getinfo()
        // Do any additional setup after loading the view.
      }

func getinfo() {
      let db = Firestore.firestore()
      db.collection("Child").whereField("email", isEqualTo:"leena99@gmail.com").getDocuments { (snapshot,error) in
          if let error = error {
                             print("FAIL ")
                         }
          else{
                             guard let lecturer = snapshot?.documents.first else {
                                 return  }
              
      }
}
    
}
*/











     /*
override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         }
     
     
     func updateUI(for user:child) {
         name.text = user.name
         email.text = user.email
         dob.text = user.dob
     }
     
     func loadProfile(letctrerID lid:String) {
         firestore.collection("Child").document(lid).getDocument { document, error in
             guard let doc = document, let userData  = doc.data() else {
                 //Inform user that there no document asscisated with the uid he have priovided
                 print("Error loadin user profile", error?.localizedDescription ?? "Unknown Error")
                 return
             }
             self.user = try! FirebaseDecoder().decode(child.self, from: userData)
         }
     }
 }
*/

*/
    
}
