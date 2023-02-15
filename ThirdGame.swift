//
//  ThirdGame.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 05/07/1444 AH.
//


import UIKit
import AVFoundation
import Vision
import SpriteKit
import Firebase
import FirebaseFirestore

class ThirdGame: UIViewController {
    @IBOutlet weak var rocketImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var viewInstruction: UIButton!
    
    @IBOutlet weak var hintButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    var endis = true
        var count = 3
        var timer: Timer?
       
        
       
        let db = Firestore.firestore()
        var currentRockIMG:String!
        
        var scene: FirstSKScene?
            override func viewDidLoad() {
                super.viewDidLoad()
                Global.shared.audioHomePage.pause()

                backButton.layer.cornerRadius =       backButton.frame.width/2
                 backButton.layer.borderWidth = 6
                 backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                 backButton.clipsToBounds = true
                
                
              hintButton.layer.cornerRadius =     hintButton.frame.width/2
                hintButton.layer.borderWidth = 6
                hintButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                hintButton.clipsToBounds = true
                
            viewInstruction.layer.cornerRadius =          viewInstruction.frame.width/2
                viewInstruction.layer.borderWidth = 6
                viewInstruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
                viewInstruction.clipsToBounds = true
                
                
                if(Global.shared.audiomsgP3 == nil)
                {
                    print("Global.shared.audiomsgP3 = ", Global.shared.audiomsgP3)
                }else{
                    Global.shared.audiomsgP3.pause()
                }

//                Global.shared.longerTime = true

    //            if(endis == false){
    //                pressgobutton.isEnabled = false}
    //                    else if(endis == true){
    //                        pressgobutton.isEnabled = true}
//                present(G1alert(), animated: true)
                print("nn")
//                Global.shared.GoBackHomeStopCamera = true

              //  pressgobutton.isEnabled = true
                
                db.collection("Child").whereField("email", isEqualTo: "shamma@gmail.com" ).getDocuments{
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
                
            //!!!!Global.shared.allLablels = ["right:9:9","right:9:3","up:2:1","up:1:1","right:9:9","right:9:3","up:2:1","up:1:1"]
         //!!!!!!!!!!!!!CameraOpen().viewDidLoad()
                
           //!!
             //   openis()
                
               // trytocall()
//                if(Global.shared.longerTime == true ){
//
//                                  print("Global.shared.longerTime",Global.shared.longerTime)
//                      let  displayTimer = Timer.scheduledTimer(timeInterval: 120.0,
//                                                      target: self,
//                                                      selector: #selector(self.displayTimerFired(_:)),
//                                                      userInfo: nil,
//                                                               repeats: false)}
                              
                             
                          

            }
//    @objc func displayTimerFired(_ timer: Timer) {
//            print("Global.shared.lon333333gerTime",Global.shared.longerTime)
//
//            if(Global.shared.longerTime == true ){
//
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//                    let alertVC = storyboard.instantiateViewController(withIdentifier: "longer") as! longerInPage
//
//                present(alertVC, animated: true,completion: nil) }
//
//            //clean up timer
//           // displayTimer.invalidate()
//        }
            func trytocallSCene(){
                //  CameraOpen().viewDidLoad()
                print(view.frame)
                let sceneView = SKView(frame: view.frame)
                let scene = ThirdSKScene()
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
    
    func playAlarm() {
            // need to declare local path as url
            let url = Bundle.main.url(forResource: "timer", withExtension: "mp3")
            // now use declared path 'url' to initialize the player
            Global.shared.audioTimer = AVPlayer.init(url: url!)
            // after initialization play audio its just like click on play button
          //  Global.shared.audio.numberOfLoops = -1
        Global.shared.audioTimer .play()
    }
        func openis(){
            CameraOpen().viewDidLoad()
            
        }
            
        @IBAction func logoutButton(_ sender: UIButton) {
            print("logout")
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
                    let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutto3") as! AlertLogout3
            
            present(alertVC, animated: true)
            
            
        }
        func G1alert() -> G1Alert {
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let alertVC = storyboard.instantiateViewController(withIdentifier: "G1Alert") as! G1Alert
            return alertVC
        }
        
        





        
        
            @IBAction func gobutton(_ sender: UIButton) {
                print("go is pressed")
//                Global.shared.longerTime = false
                let numGif = UIImage.gifImageWithName("ArabicGif9")
                imageView.image = numGif
                playAlarm()
              // pressgobutton.isEnabled = false
                
               
                
    //            if(count == 1){
    //                print("no count")
    //            }else{
                 //   timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(myUpdate), userInfo: nil, repeats: true)
            
           // }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
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
        
        @objc func myUpdate() {
            
           print("myUpdate")
            if(count > 1 ){
                print("counter is ",count)
                count -= 1
            // labelTimer.text = "\(count)"
            }
        }
                
    //        }


    

}
