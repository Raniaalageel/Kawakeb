//
//  SecondGame.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/06/1444 AH.
//


import UIKit
import AVFoundation
import Vision
import SpriteKit
import Firebase
import FirebaseFirestore
class SecondGame: UIViewController {
    
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var viewInstruction: UIButton!
    @IBOutlet weak var rocketImage: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let db = Firestore.firestore()
    var scene: FirstSKScene?
    var currentRockIMG:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                Global.shared.audioHomePage.pause()
        Global.shared.instruction = false
        
        backButton.layer.cornerRadius =       backButton.frame.width/2
         backButton.layer.borderWidth = 6
         backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         backButton.clipsToBounds = true
        
        
      hintButton.layer.cornerRadius =       hintButton.frame.width/2
        hintButton.layer.borderWidth = 6
        hintButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hintButton.clipsToBounds = true
        
        
        viewInstruction.layer.cornerRadius =      viewInstruction.frame.width/2
        viewInstruction.layer.borderWidth = 6
        viewInstruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        viewInstruction.clipsToBounds = true
        
        if(Global.shared.audiomsgP2 == nil)
        {
            print("Global.shared.audiomsgP2 = ", Global.shared.audiomsgP2)
        }else{
            Global.shared.audiomsgP2.pause()
        }


        print("nn")
        //        Global.shared.GoBackHomeStopCamera = true
//        Global.shared.longerTime = true
        
        
        db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{
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
        //        Global.shared.allLablels = ["left","left","down","down","right"]
        //!!!!!!!!!!!!!!CameraOpen().viewDidLoad()
        
        // trytocall()
        
        
       // openis()
        
//        if(Global.shared.longerTime == true ){
//
//            print("Global.shared.longerTime",Global.shared.longerTime)
//            let  displayTimer = Timer.scheduledTimer(timeInterval: 10.0,
//                                                     target: self,
//                                                     selector: #selector(self.displayTimerFired(_:)),
//                                                     userInfo: nil,
//                                                     repeats: false)}
        
    }
//    @objc func displayTimerFired(_ timer: Timer) {
//        print("Global.shared.lon333333gerTime",Global.shared.longerTime)
//        
//        if(Global.shared.longerTime == true ){
//            
//            let storyboard = UIStoryboard(name: "Main", bundle: .main)
//            let alertVC = storyboard.instantiateViewController(withIdentifier: "longer") as! longerInPage
//            
//            present(alertVC, animated: true,completion: nil) }
//        
//        //clean up timer
//        // displayTimer.invalidate()
//    }
    
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
    
    @IBAction func logoutGame(_ sender: UIButton) {
        print("logout")
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutto2") as! AlertLogout2
        
        present(alertVC, animated: true)
        
    }
    
    @IBAction func logoutButton(_ sender: UIButton)
    {
        print("go is pressed")
        
        //        Global.shared.longerTime = false
        
        let numGif = UIImage.gifImageWithName("ArabicGif9")
        imageView.image = numGif
        playAlarm()
        
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
            //!!!!!!!!!!!!!!!CameraOpen().viewDidLoad()   //call class CameraOpen
            
            
            
            //        print("session.isRunning",session.isRunning )
            //        if session.isRunning {
            //                DispatchQueue.global().async {
            //                print("STOP Session")
            //                    self.session.stopRunning()
            //                }
            //            }
        }
    }
    
    
    
    func trytocallSCene(){
        //  CameraOpen().viewDidLoad()
        print(view.frame)
        let sceneView = SKView(frame: view.frame)
        let scene = secondSKScene()
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
    
}










