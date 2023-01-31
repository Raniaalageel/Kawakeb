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

    @IBOutlet weak var rocketImage: UIImageView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    let db = Firestore.firestore()
    var scene: FirstSKScene?
    var currentRockIMG:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("nn")
        Global.shared.GoBackHomeStopCamera = true

        
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
        
        
        //!!!!
//        Global.shared.allLablels = ["left","left","down","down","right"]
     //!!!!!!!!!!!!!!CameraOpen().viewDidLoad()
            
           // trytocall()

        openis()
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






       
   

   
