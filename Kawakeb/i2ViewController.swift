//
//  i2ViewController.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 17/01/2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation

class i2ViewController: UIViewController {
    
    @IBOutlet weak var instruction: UIButton!
    
    @IBOutlet weak var storeButton: UIButton!
    var userId = ""
    let firestore = Firestore.firestore()
    var pointsall : Int!
    let db = Firestore.firestore()
    
    var a = ""
    
    @IBOutlet weak var Stars: UILabel!
    @IBOutlet weak var n2: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        instruction.layer.cornerRadius =      instruction.frame.width/2
        instruction.layer.borderWidth = 6
        instruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        instruction.clipsToBounds = true
        
        
        storeButton.layer.cornerRadius =      storeButton.frame.width/2
        storeButton.layer.borderWidth = 6
        storeButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        storeButton.clipsToBounds = true
          
        
        
        Global.shared.audioi1VC.pause()
        playAlarm()
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
                           (snapshot, error) in
                           if let error = error {
                               print("FAIL") }
                           else {
                               print("SUCCESS??")
                             
//                    self.currentRockIMG = snapshot!.documents.first!.get("currentRockIMG") as? String
//                        print("currentRockIMG",self.currentRockIMG!)
                               let formatter: NumberFormatter = NumberFormatter()
                               var  x1: Int!
                               x1 = snapshot!.documents.first!.get("points")  as! Int
                               var  a1 = NSNumber(value: x1)
                             formatter.locale = Locale(identifier: "ar")
                               self.a = formatter.string(from: a1)!
                              // self.pointsall = snapshot!.documents.first!.get("points") as? Int
                                 // print("pointsall ",self.pointsall!)
                               
//                               //x1 = Int(exactly: arc4random_uniform(10) + 1)!
//
//                              // var  a1 = NSNumber(value: x1)
//
//                            //   var a1 = NSNumber(value: x1)
//                                       formatter.locale = Locale(identifier: "ar")
//                                      let a = formatter.string(from: a1)!
                                    
//
//                               self.Flower = snapshot!.documents.first!.get("Flower") as? String
//                               print("Flower",self.Flower!)
//                               self.Earth = snapshot!.documents.first!.get("Earth") as? String
//                               print("Earth",self.Earth!)
//                               self.Mars = snapshot!.documents.first!.get("Mars") as? String
//                               print("Mars",self.Mars!)
                           }
         //   self.rocketimage.image = UIImage(named: self.currentRockIMG!)
           // self.Stars.text = String (self.pointsall!)
            self.Stars.text = self.a
        }

        
        
        n2.text = Global.shared.usercharacterName;
        if ( Global.shared.usercharacter == "girl"){
                let imageName = "girl.png"
                let image = UIImage(named: imageName)
                let imageView = UIImageView(image: image!)
                imageView.frame = CGRect(x: 670, y: 18, width: 120, height: 105)
                view.addSubview(imageView)
                }else if (Global.shared.usercharacter == "boy"){
                    let imageName = "boy.png"
                    let image = UIImage(named: imageName)
                    let imageView = UIImageView(image: image!)
                    imageView.frame = CGRect(x: 673, y: 18, width: 123, height: 107)
                    view.addSubview(imageView)
                }
        // Do any additional setup after loading the view.
    }
    

    func playAlarm() {
            // need to declare local path as url
            let url = Bundle.main.url(forResource: "i2VC", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audioi2VC = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audioi2VC .play()
    }

}
