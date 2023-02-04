//
//  Profile.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 28/05/1444 AH.
//


import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import FirebaseFirestore


class Profile: UIViewController, EditprofileDelegate {
    func userUpdated(child: Child) {
        name.text = child.name
        email.text = child.email
        dob.text = child.dob
    }
    
    @IBOutlet weak var EDTbtn: UIButton!
    
    @IBOutlet weak var bkbtn: UIButton!
    
    @IBOutlet weak var char: UILabel!
    
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    let firestore = Firestore.firestore()
    var emaill : String?
    var child : Child?
    var userId = ""
    
    @IBAction func logouut(_ sender: UIButton) {
    }
    @IBAction func editpro(_ sender: Any) {
//        performSegue(withIdentifier: "editProfileEquation", sender: child)
    }
    @IBAction func backb(_ sender: Any) {
      /*
        let HomeVC = storyboard?.instantiateViewController(withIdentifier: "HmeVC") as! Profile
        HomeVC.modalTransitionStyle = .crossDissolve
        HomeVC.modalPresentationStyle = .fullScreen
        self.present(HomeVC, animated: true)
       */
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        Global.shared.audioHomePage.pause()
       // Auth.auth().signIn(withEmail: "a@a.com", password: "123123")
        
        //        createUser()
        
        EDTbtn.layer.cornerRadius = EDTbtn.frame.width/2
        EDTbtn.layer.borderWidth = 6
        EDTbtn.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

        EDTbtn.clipsToBounds = true
        //
        
        bkbtn.layer.cornerRadius = bkbtn.frame.width/2
        bkbtn.layer.borderWidth = 6
        bkbtn.layer.borderColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)

        bkbtn.clipsToBounds = true
        
        if let id = Auth.auth().currentUser?.uid {
            userId = id
        }
        
//        userId = "9hITbFsJWedRbhIoNCL8LpfhU7o2"
        
        firestore.collection("Child").document(userId).getDocument { [self]snapshot, error in
            if error == nil {
                // get user data
                guard let userData = snapshot else {return}
                child = Child(email: userData["email"] as? String, name: userData["name"] as? String, points: userData["points"] as? String, dob: userData["dob"] as? String, childID: userId ,char : userData["character"] as? String)
                name.text = userData["name"] as? String
                email.text = userData["email"] as? String
                dob.text = userData["dob"] as? String
                char.text = userData["character"] as? String
                              if ( char.text == "girl"){
                                      let imageName = "girl.png"
                                      let image = UIImage(named: imageName)
                                      let imageView = UIImageView(image: image!)
                                      imageView.frame = CGRect(x: 250, y: 100, width: 300, height: 300)
                                      view.addSubview(imageView)
                                      }else if (char.text == "boy"){
                                          let imageName = "boy.png"
                                          let image = UIImage(named: imageName)
                                          let imageView = UIImageView(image: image!)
                                          imageView.frame = CGRect(x: 250, y: 100, width: 300, height: 300)
                                          view.addSubview(imageView)
                                      }
                
            } else {
                // show error message
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let editProfile = segue.destination as! Pv
//        editProfile.passedChild = sender as? Child
//        editProfile.delegate = self
//    }
    
    
    
    
    //    func createUser() {
    //        Auth.auth().createUser(withEmail: "a@a.com", password: "123123") { [self] result, error in
    //            if error == nil {
    //                guard let userID = result?.user.uid else {return}
    //                let userData : [String : Any] = ["name": "Adnan", "dob": "01/01/2000", "email": "a@a.com", "password": "123123"]
    //                firestore.collection("Child").document(userID).setData(userData) { error in
    //                    if error == nil {
    //                        print("Done ya manh")
    //                    }
    //                }
    //            }
    //        }
    //    }
    
    
    
    
    
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
