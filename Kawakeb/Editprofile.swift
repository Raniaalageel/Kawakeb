//
//  Editprofile.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 24/05/1444 AH.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol EditprofileDelegate {
    func userUpdated(child: Child)
}

class Editprofile: UIViewController {
    var userId = ""
    let firestore = Firestore.firestore()
    var passedChild : Child?
    
    @IBOutlet weak var Uname: UITextField!
    @IBOutlet weak var Udob: UITextField!
    @IBOutlet weak var Uemail: UITextField!
    
    var delegate : EditprofileDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if let child = passedChild {
            Uname.text = child.name
            Uemail.text = child.email
            Udob.text = child.dob
            
            print(child.childID)
            
 
            //            let formatter = DateFormatter()
////            formatter.calendar = Calendar(identifier: .gregorian)
//            formatter.locale = Locale(identifier: "ar_DZ")
//            formatter.dateFormat = "dd/MM/yyyy"
//            print(formatter.string(from: Date()))
//
//
//            if let childDob = child.dob {
//                let childDate = formatter.date(from: childDob)
//
//                print(childDate)
//            }
            
            
        }
        
    }
    
    @IBAction func save(_ sender: Any) {
        guard let childID = passedChild?.childID else {return}
        let childData : [String : Any] = ["name" : Uname.text, "email": Uemail.text, "dob": Udob.text]
        firestore.collection("Child").document(childID).updateData(childData) { [self] error in
            if error == nil {
                // update successfully
                delegate.userUpdated(child: Child(email: Uemail.text, name: Uname.text, dob: Udob.text, childID: childID))
                self.navigationController?.popViewController(animated: true)
                self.navigationController?.popToRootViewController(animated: true)
            } else {
                // show error message
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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

