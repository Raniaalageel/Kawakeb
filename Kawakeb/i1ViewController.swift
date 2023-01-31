//
//  i1ViewController.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 17/01/2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import AVFoundation


class i1ViewController: UIViewController {

    @IBOutlet weak var Stars1: UILabel!
    @IBOutlet weak var n1: UILabel!
    var userId = ""
    let firestore = Firestore.firestore()
    var pointsall : Int!
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Global.shared.audioHomePage.pause()
        playAlarm()
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
                           (snapshot, error) in
                           if let error = error {
                               print("FAIL") }
                           else {
                               print("SUCCESS??")
                             
//                    self.currentRockIMG = snapshot!.documents.first!.get("currentRockIMG") as? String
//                        print("currentRockIMG",self.currentRockIMG!)
                               
                               self.pointsall = snapshot!.documents.first!.get("points") as? Int
                                  print("pointsall ",self.pointsall!)
                               
//
//                               self.Flower = snapshot!.documents.first!.get("Flower") as? String
//                               print("Flower",self.Flower!)
//                               self.Earth = snapshot!.documents.first!.get("Earth") as? String
//                               print("Earth",self.Earth!)
//                               self.Mars = snapshot!.documents.first!.get("Mars") as? String
//                               print("Mars",self.Mars!)
                           }
         //   self.rocketimage.image = UIImage(named: self.currentRockIMG!)
            self.Stars1.text = String (self.pointsall!)
        }
        
        
        n1.text = Global.shared.usercharacterName;
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
            let url = Bundle.main.url(forResource: "i1VC", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audioi1VC = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audioi1VC .play()
    }
}
