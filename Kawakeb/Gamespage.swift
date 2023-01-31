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
import  QuartzCore
import AVFoundation

//
class Gamespage: UIViewController, EditprofileDelegate {
    
    let db = Firestore.firestore()
    
  var Flower:String!
  var Earth :String!
  var Mars :String!
    var currentRockIMG:String!
    var timer: Timer?
    var pointsall : Int!
    @IBOutlet weak var alzahrabutton: UIButton!
    @IBOutlet weak var alzahraLuck: UIImageView!
    
    
    @IBOutlet weak var alarghbutton: UIButton!
    @IBOutlet weak var alarghLuck: UIImageView!
    
    @IBOutlet weak var rocketimage: UIImageView!
    
    @IBOutlet weak var almarighbutton: UIButton!
    @IBOutlet weak var almarighLuck: UIImageView!
    
    @IBOutlet weak var AuransLuck: UIImageView!
    @IBOutlet weak var ZuhalLuck: UIImageView!
    
    @IBOutlet weak var almashtryLuck: UIImageView!
    
    @IBOutlet weak var nubtonLuck: UIImageView!
    
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
    

  // @IBOutlet weak var n1: UILabel!
    //  @IBOutlet weak var p1: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        playAlarm()
        checkOpenClose()
       
        print("origiin",self.rocketimage.frame.origin.y)
        
        self.rocketimage.transform =  self.rocketimage.transform.rotated(by: CGFloat(Double.pi / 4))

       
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(updaterocket), userInfo: nil, repeats: true)
        
        
     
        
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
                child = Child(email: userData["email"] as? String, name: userData["name"] as? String, points: userData["points"] as? String, dob: userData["dob"] as? String, childID: userId,char : userData["character"] as? String)
                uuname.text = userData["name"] as? String
                Global.shared.usercharacterName = (userData["name"] as? String)!
                //FOR INST
//                if(n1.text != nil)
//                { n1.text = userData["name"] as? String}
                
                uuemail.text = userData["email"] as? String
                uudob.text = userData["dob"] as? String
               // uupoints.text = userData["points"] as? String
                char.text = userData["character"] as? String
                Global.shared.usercharacter = (userData["character"] as? String)!
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
                             
                    self.currentRockIMG = snapshot!.documents.first!.get("currentRockIMG") as? String
                        print("currentRockIMG",self.currentRockIMG!)
                               
                               self.pointsall = snapshot!.documents.first!.get("points") as? Int
                                  print("pointsall ",self.pointsall!)
                               
                        
                               self.Flower = snapshot!.documents.first!.get("Flower") as? String
                               print("Flower",self.Flower!)
                               self.Earth = snapshot!.documents.first!.get("Earth") as? String
                               print("Earth",self.Earth!)
                               self.Mars = snapshot!.documents.first!.get("Mars") as? String
                               print("Mars",self.Mars!)
                           }
            self.rocketimage.image = UIImage(named: self.currentRockIMG!)
            self.uupoints.text = String (self.pointsall!)
            
            if(self.Flower! == "open" ){
                self.alzahraLuck.isHidden = true
                self.alzahrabutton.isEnabled = true
            }
//            else {
//                self.alzahrabutton.isEnabled = false
//            }
            
            if(self.Earth! == "open" ){
                self.alarghLuck.isHidden = true
                self.alarghbutton.isEnabled = true
                
            }
//            else{
//                self.alarghbutton.isEnabled = false
//            }
            if(self.Mars! == "open" ){
                self.almarighLuck.isHidden = true
                self.almarighbutton.isEnabled = true
            }
//            else{
//                self.almarighbutton.isEnabled = false
//            }

          }
        
        
    }
   
    @IBAction func FirstAudard(_ sender: Any) {
    //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //        let secondViewController = storyboard.instantiateViewController(withIdentifier: "Firstautard") as! FirstGame
    //        present(secondViewController, animated: true, completion: nil)
           // self.performSegue(withIdentifier: "gofirst", sender: self)
    }
    
    
    @IBAction func secondAlzahra(_ sender: Any) {
        print("Alzahra")
        
        if(self.Flower == "close"){
            
            UIView.animate(withDuration: 0.2, animations: {
                self.alzahraLuck.frame.origin.y -= -50
            },completion: nil)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.alzahraLuck.frame.origin.y -= 50
            },completion: nil)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.alzahraLuck.frame.origin.x -= -30
            },completion: nil)

            UIView.animate(withDuration: 0.5, animations: {
                self.alzahraLuck.frame.origin.x -= 30
            },completion: nil)
            
            
            
        }
        if(self.Flower == "open"){
        let storyboardd = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboardd.instantiateViewController(withIdentifier: "msgP2") as! msgP2
        vcc.view.frame = (self.view?.frame)!
        vcc.view.layoutIfNeeded()
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
        self.view?.window?.rootViewController = vcc
        }, completion: { completed in

        })
        }

        
        
        
        
    }
    
    @IBAction func thirdAlargh(_ sender: Any) {
        print("Alargh")
        if(self.Earth == "close"){
            
            UIView.animate(withDuration: 0.2, animations: {
                self.alarghLuck.frame.origin.y -= -50
            },completion: nil)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.alarghLuck.frame.origin.y -= 50
            },completion: nil)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.alarghLuck.frame.origin.x -= -30
            },completion: nil)

            UIView.animate(withDuration: 0.5, animations: {
                self.alarghLuck.frame.origin.x -= 30
            },completion: nil)
            
            
            
        }
        
        if(self.Earth == "open"){
        let storyboardd = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboardd.instantiateViewController(withIdentifier: "msgP3") as! msgP3
        vcc.view.frame = (self.view?.frame)!
        vcc.view.layoutIfNeeded()
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
        self.view?.window?.rootViewController = vcc
        }, completion: { completed in

        })
        }
       
    }
    
    @IBAction func fourthAlmarigh(_ sender: Any) {
        print("Almarigh")
        if(self.Mars == "close"){
            
            UIView.animate(withDuration: 0.2, animations: {
                self.almarighLuck.frame.origin.y -= -50
            },completion: nil)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.almarighLuck.frame.origin.y -= 50
            },completion: nil)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.almarighLuck.frame.origin.x -= -30
            },completion: nil)

            UIView.animate(withDuration: 0.5, animations: {
                self.almarighLuck.frame.origin.x -= 30
            },completion: nil)
            
            
        }
    }
    
    
    
    @IBAction func fiveAlmashtry(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.almashtryLuck.frame.origin.y -= -50
        },completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.almashtryLuck.frame.origin.y -= 50
        },completion: nil)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.almashtryLuck.frame.origin.x -= -30
        },completion: nil)

        UIView.animate(withDuration: 0.5, animations: {
            self.almashtryLuck.frame.origin.x -= 30
        },completion: nil)
    }
    
    
    @IBAction func sixzuhal(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.ZuhalLuck.frame.origin.y -= -50
        },completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.ZuhalLuck.frame.origin.y -= 50
        },completion: nil)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.ZuhalLuck.frame.origin.x -= -30
        },completion: nil)

        UIView.animate(withDuration: 0.5, animations: {
            self.ZuhalLuck.frame.origin.x -= 30
        },completion: nil)
        
    }
    
    
    @IBAction func sevenAurans(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.AuransLuck.frame.origin.y -= -50
        },completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.AuransLuck.frame.origin.y -= 50
        },completion: nil)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.AuransLuck.frame.origin.x -= -30
        },completion: nil)

        UIView.animate(withDuration: 0.5, animations: {
            self.AuransLuck.frame.origin.x -= 30
        },completion: nil)
        
    }
    
    @IBAction func eightNapton(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, animations: {
            self.nubtonLuck.frame.origin.y -= -50
        },completion: nil)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.nubtonLuck.frame.origin.y -= 50
        },completion: nil)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.nubtonLuck.frame.origin.x -= -30
        },completion: nil)

        UIView.animate(withDuration: 0.5, animations: {
            self.nubtonLuck.frame.origin.x -= 30
        },completion: nil)
    }
    
    @objc func updaterocket(){
//        UIView.animate(withDuration: 2, animations: {
//            self.rocketimage.frame.origin.y -= -50
//           // print("origiin before",self.rocketimage.frame.origin.y)
//        },completion: nil)
//
//        UIView.animate(withDuration: 1, animations: {
//            self.rocketimage.frame.origin.y -= 50
//          //  print("origiin trturn",self.rocketimage.frame.origin.y)
//
//        },completion: nil)
        
        UIView.animate(withDuration: 2, animations: {
        self.rocketimage.transform =  self.rocketimage.transform.rotated(by: CGFloat(Double.pi / 4.03))
        
        },completion: nil)
        UIView.animate(withDuration: 1, animations: {
            self.rocketimage.transform =  self.rocketimage.transform.rotated(by: CGFloat(Double.pi / -4.03))
        },completion: nil)
        
    }
    
    func playAlarm() {
            // need to declare local path as url
            let url = Bundle.main.url(forResource: "HomePageSound", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audioHomePage = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audioHomePage .play()
    }
    
    
    
    }
