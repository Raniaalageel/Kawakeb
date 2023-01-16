//
//  Gamespage.swift
//  Kawakeb
//
//  Created by Modhy Abduallh on 05/06/1444 AH.
//

import UIKit
import AudioToolbox
import CodableFirebase
import Firebase
import FirebaseFirestore

class Gamespage: UIViewController, EditprofileDelegate {
    
    let db = Firestore.firestore()
    
var Flower:String!
  var Earth :String!
  var Mars :String!
    
    @IBOutlet weak var alzahrabutton: UIButton!
    @IBOutlet weak var alzahraLuck: UIImageView!
    
    
    @IBOutlet weak var alarghbutton: UIButton!
    @IBOutlet weak var alarghLuck: UIImageView!
    
    
    @IBOutlet weak var almarighbutton: UIButton!
    @IBOutlet weak var almarighLuck: UIImageView!
    
    func userUpdated(child: Child) {
        uuname.text = child.name
        uuemail.text = child.email
        uudob.text = child.dob
    }
    
    
    let firestore = Firestore.firestore()
    var emaill : String?
    var child : Child?
    var userId = ""
  
    
  
    
    @IBOutlet weak var char: UILabel!
    

    @IBOutlet weak var uuemail: UILabel!
    
    @IBOutlet weak var uudob: UILabel!
    
    @IBOutlet weak var uuname: UILabel!
    
    
    @IBOutlet weak var uupoints: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        checkOpenClose()
        
        
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
                child = Child(email: userData["email"] as? String, name: userData["name"] as? String, dob: userData["dob"] as? String, childID: userId,char : userData["character"] as? String)
                uuname.text = userData["name"] as? String
                uuemail.text = userData["email"] as? String
                uudob.text = userData["dob"] as? String
                char.text = userData["character"] as? String
                 if ( char.text == "girl"){
                         let imageName = "girl.png"
                         let image = UIImage(named: imageName)
                         let imageView = UIImageView(image: image!)
                         imageView.frame = CGRect(x: 670, y: 18, width: 120, height: 105)
                         view.addSubview(imageView)
                         }else if (char.text == "boy"){
                             let imageName = "boy.png"
                             let image = UIImage(named: imageName)
                             let imageView = UIImageView(image: image!)
                             imageView.frame = CGRect(x: 673, y: 18, width: 123, height: 107)
                             view.addSubview(imageView)
                         }
            } else {
                // show error message
            }
        }
        
        
        //checkOpenClose()
        
        
    }
    
    func checkOpenClose(){
        
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
                           (snapshot, error) in
                           if let error = error {
                               print("FAIL") }
                           else {
                               print("SUCCESS??")
                               self.Flower = snapshot!.documents.first!.get("Flower") as? String
                               print("Flower",self.Flower!)
                               self.Earth = snapshot!.documents.first!.get("Earth") as? String
                               print("Earth",self.Earth!)
                               self.Mars = snapshot!.documents.first!.get("Mars") as? String
                               print("Mars",self.Mars!)
                           }
            
            if(self.Flower! == "open" ){
                self.alzahraLuck.isHidden = true
                self.alzahrabutton.isEnabled = true
            }else {
                self.alzahrabutton.isEnabled = false
            }
            
            if(self.Earth! == "open" ){
                self.alarghLuck.isHidden = true
                self.alarghbutton.isEnabled = true
                
            }else{
                self.alarghbutton.isEnabled = false
            }
            if(self.Mars! == "open" ){
                self.almarighLuck.isHidden = true
                self.almarighbutton.isEnabled = true
            }
            else{
                self.almarighbutton.isEnabled = false
            }
            

          }
        
        
    }
   
    @IBAction func FirstAudard(_ sender: Any) {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let secondViewController = storyboard.instantiateViewController(withIdentifier: "Firstautard") as! FirstGame
    //        present(secondViewController, animated: true, completion: nil)
            self.performSegue(withIdentifier: "gofirst", sender: self)
    }
    
    
    @IBAction func secondAlzahra(_ sender: Any) {
        print("Alzahra")
        
    }
    
    @IBAction func thirdAlargh(_ sender: Any) {
        print("Alargh")
    }
    
    @IBAction func fourthAlmarigh(_ sender: Any) {
        print("Almarigh")
    }
    
    }
