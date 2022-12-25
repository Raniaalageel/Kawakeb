
import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import FirebaseFirestore


class Gamespage: UIViewController, EditprofileDelegate {
    func userUpdated(child: Child) {
        uuname.text = child.name
        uuemail.text = child.email
        uudob.text = child.dob
    }
    
    
    let firestore = Firestore.firestore()
    var emaill : String?
    var child : Child?
    var userId = ""
  
    
    
    @IBOutlet weak var uuemail: UILabel!
    
    
    @IBOutlet weak var uudob: UILabel!
    
    @IBOutlet weak var uuname: UILabel!
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               // Auth.auth().signIn(withEmail: "a@a.com", password: "123123")
        //        createUser()
        if let id = Auth.auth().currentUser?.uid {
            userId = id
        }
        
//        userId = "9hITbFsJWedRbhIoNCL8LpfhU7o2"
        
        firestore.collection("Child").document(userId).getDocument { [self]snapshot, error in
            if error == nil {
                // get user data
                guard let userData = snapshot else {return}
                child = Child(email: userData["email"] as? String, name: userData["name"] as? String, dob: userData["dob"] as? String, childID: userId)
                uuname.text = userData["name"] as? String
                uuemail.text = userData["email"] as? String
                uudob.text = userData["dob"] as? String
                
            } else {
                // show error message
            }
        }
    }
   
    
    }
