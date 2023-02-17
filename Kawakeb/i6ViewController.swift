//
//  i6ViewController.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 17/01/2023.
//

import UIKit
import Firebase
import FirebaseFirestore
import AVKit
import MediaPlayer

import AVFoundation

class i6ViewController: UIViewController {

    @IBOutlet weak var info: UIButton!
    
    @IBOutlet weak var Stars6: UILabel!
    @IBOutlet weak var n6: UILabel!
    let  avPlayerviewContooler = AVPlayerViewController()
    var avPlayer:AVPlayer?
    @IBOutlet weak var instruction: UIButton!
    @IBOutlet weak var storeButton: UIButton!
    var userId = ""
    let firestore = Firestore.firestore()
    var  a =  ""
    var pointsall : Int!
    let db = Firestore.firestore()
    
    let yourAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 38),
        .foregroundColor: #colorLiteral(red: 0.4120975137, green: 0.3873831034, blue: 0.387838304, alpha: 1),
        .underlineStyle: NSUnderlineStyle.single.rawValue
      ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let attributeString = NSMutableAttributedString(
           string: "لمشاهدة التعليمات",
           attributes: yourAttributes
        )
       info.setAttributedTitle(attributeString, for: .normal)
        
        instruction.layer.cornerRadius =      instruction.frame.width/2
        instruction.layer.borderWidth = 6
        instruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        instruction.clipsToBounds = true
        
      storeButton.layer.cornerRadius =      storeButton.frame.width/2
        storeButton.layer.borderWidth = 6
      storeButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        storeButton.clipsToBounds = true
        
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
                           (snapshot, error) in
                           if let error = error {
                               print("FAIL") }
                           else {
                               print("SUCCESS??")
                             
//                    self.currentRockIMG = snapshot!.documents.first!.get("currentRockIMG") as? String
//                        print("currentRockIMG",self.currentRockIMG!)
                               
//                               self.pointsall = snapshot!.documents.first!.get("points") as? Int
//                                  print("pointsall ",self.pointsall!)
                               let formatter: NumberFormatter = NumberFormatter()
                               var  x1: Int!
                               x1 = snapshot!.documents.first!.get("points")  as! Int
                               var  a1 = NSNumber(value: x1)
                             formatter.locale = Locale(identifier: "ar")
                               self.a = formatter.string(from: a1)!
//
//                               self.Flower = snapshot!.documents.first!.get("Flower") as? String
//                               print("Flower",self.Flower!)
//                               self.Earth = snapshot!.documents.first!.get("Earth") as? String
//                               print("Earth",self.Earth!)
//                               self.Mars = snapshot!.documents.first!.get("Mars") as? String
//                               print("Mars",self.Mars!)
                           }
         //   self.rocketimage.image = UIImage(named: self.currentRockIMG!)
            self.Stars6.text = self.a
        }

        n6.text = Global.shared.usercharacterName;
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
        
        let urlPathString:String? = Bundle.main.path(forResource: "video", ofType: ".mp4")
                if let urlPath = urlPathString{
                    let movieUrl = NSURL(fileURLWithPath: urlPath)
                    self.avPlayer = AVPlayer(url: movieUrl as URL)
                    self.avPlayerviewContooler.player = self.avPlayer
                }
        
    }
    

    
    
    
    @IBAction func vidoPress(_ sender: UIButton) {
        self.present(self.avPlayerviewContooler, animated: true)
        //player?.play()
            self.avPlayerviewContooler.player?.play()
    }
    
    
    
   
        
    }
    

    

