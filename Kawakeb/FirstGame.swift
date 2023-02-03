//
//  FirstGame.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 03/06/1444 AH.
//


import UIKit
import AVFoundation
import Vision
import SpriteKit
import Firebase
import FirebaseFirestore

class FirstGame: UIViewController {

    @IBOutlet weak var Dbtn: UIButton!
    @IBOutlet weak var hintBTN: UIButton!
    @IBOutlet weak var BKbtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var rocketImage: UIImageView!
    let db = Firestore.firestore()
    var currentRockIMG:String!
    
    var scene: FirstSKScene?
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
            Dbtn.layer.cornerRadius = Dbtn.frame.width/2
            Dbtn.layer.borderWidth = 6
            Dbtn.layer.borderColor =    #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)


                    
            Dbtn.clipsToBounds = true
            //
            
            hintBTN.layer.cornerRadius = hintBTN.frame.width/2
            hintBTN.layer.borderWidth = 6
            hintBTN.layer.borderColor =      #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)


                    
            hintBTN.clipsToBounds = true
            //
            
            BKbtn.layer.cornerRadius = BKbtn.frame.width/2
            BKbtn.layer.borderWidth = 6
            BKbtn.layer.borderColor =     #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)


                    
            BKbtn.clipsToBounds = true
            
            
         
            
            
            
            
            
            
//            present(G1alert(), animated: true)
            Global.shared.audioHomePage.pause()
            Global.shared.audiomsgP1.pause()
            print("nn")
//            Global.shared.GoBackHomeStopCamera = true
//            Global.shared.longerTime = true

            
            db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare ).getDocuments{
                               (snapshot, error) in
                               if let error = error {
                                   print("FAIL") }
                               else {
                                   print("SUCCESS??")
                                 
                        self.currentRockIMG = snapshot!.documents.first!.get("currentRockIMG") as? String
                            print("currentRockIMG",self.currentRockIMG!)
                               }
            
self.rocketImage.image = UIImage(named: self.currentRockIMG!)
                Global.shared.rocketImage = self.currentRockIMG!
            }
            
        //!!!!
//            Global.shared.allLablels = ["left:9:9","left:8:9","up:9:9"]
     //!!!!!!!!!!!!!CameraOpen().viewDidLoad()
            
        openis()
            
           // trytocall()
            
//            if(Global.shared.longerTime == true ){
//
//                              print("Global.shared.longerTime",Global.shared.longerTime)
//                  let  displayTimer = Timer.scheduledTimer(timeInterval: 10.0,
//                                                  target: self,
//                                                  selector: #selector(self.displayTimerFired(_:)),
//                                                  userInfo: nil,
//                                                  repeats: true)}
           
        }
//    @objc func displayTimerFired(_ timer: Timer) {
//            print("Global.shared.lon333333gerTime",Global.shared.longerTime)
//
//            if(Global.shared.longerTime == true ){
////
////            let storyboard = UIStoryboard(name: "Main", bundle: .main)
////                    let alertVC = storyboard.instantiateViewController(withIdentifier: "longer") as! longerInPage
////
////                present(alertVC, animated: true,completion: nil)
//                let alertController = UIAlertController(title: "60 Seconds...", message: "60 Seconds have elapsed.", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "OK",  style: .default, handler: nil))
//                    self.present(alertController, animated: true, completion: nil)
//
//                    //clean up timer
////                    displayTimer.invalidate()‏
//            }
//
//            //clean up timer
//           // displayTimer.invalidate()
//        }
        func trytocallSCene(){
            //  CameraOpen().viewDidLoad()
            print(view.frame)
            let sceneView = SKView(frame: view.frame)
            let scene = FirstSKScene()
            scene.size = view.frame.size
            //view.addSubview(sceneView)
            sceneView.presentScene(scene)
            self.view.addSubview(sceneView)
            
           
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                sceneView.removeFromSuperview()
//            }
            
            
            
            
    //        let v = UILabel(frame: .init(x: 100, y: 100, width: 100, height: 60))
    //        v.text = "Hello"
    //        self.view.addSubview(v)
        }
    func openis(){
        CameraOpen().viewDidLoad()
        
    }
        
    @IBAction func logoutButton(_ sender: UIButton) {
        
        print("logout")
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutto") as! AlertLogout
        
        present(alertVC, animated: true)
        
        
    }
    func G1alert() -> G1Alert {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "G1Alert") as! G1Alert
        return alertVC
    }
    
        @IBAction func gobutton(_ sender: UIButton) {
            print("go is pressed")
            
//            Global.shared.longerTime = false
            
            let numGif = UIImage.gifImageWithName("ArabicGif5")
            imageView.image = numGif

            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                print("after 10 sec")
               
                
            
            Global.shared.enabled = true //add all array
            Global.shared.stopis = true   //stopcamer
        CameraOpen().Stopsessyion()

            
            
//
//            if(Global.shared.allLablels.isEmpty){
//
//                print("Global.shared.allLablels.isEmpty")
//
//                let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                        let alertVC = storyboard.instantiateViewController(withIdentifier: "Emptyy") as! EmptyArray
//
//                present(alertVC, animated: true)
//
//            }else {
                self.trytocallSCene()  //GO TOSKSCENE
            
            
            //!!!!!!!!!!!!!!!
                Global.shared.allLablels = []
            print("again open camera ")
            Global.shared.stopis = false  //OPEN CAMERA
            Global.shared.enabled = false //not appned array
            //!!!!!!!!!!!!!!!
               // CameraOpen().viewDidLoad()   //call class CameraOpen

            
            
            //        print("session.isRunning",session.isRunning )
            //        if session.isRunning {
            //                DispatchQueue.global().async {
            //                print("STOP Session")
            //                    self.session.stopRunning()
            //                }
            //            }
        }
            
        }

   }
