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
import FirebaseStorage
class FirstGame: UIViewController {

    //static var isUsed = false
   
    var scene: FirstSKScene?
        override func viewDidLoad() {
            super.viewDidLoad()
            print("nn")
            sethint()
    //        Global.shared.useremailshare =
            Global.shared.allLablels = ["left:0:500","left:200:2","up:22:1"]
     //!!!!!!!!!!!!!!!   CameraOpen().viewDidLoad()
            
           // trytocall()
        }
        func trytocallSCene(){
            //  CameraOpen().viewDidLoad()
            print(view.frame)
            let sceneView = SKView(frame: view.frame)
            let scene = FirstSKScene()
            scene.size = view.frame.size
            //view.addSubview(sceneView)
            sceneView.presentScene(scene)
            self.view.addSubview(sceneView)
            
           
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                sceneView.removeFromSuperview()
            }
            
            
            
            
    //        let v = UILabel(frame: .init(x: 100, y: 100, width: 100, height: 60))
    //        v.text = "Hello"
    //        self.view.addSubview(v)
        }
        
        
        @IBAction func gobutton(_ sender: UIButton) {
            print("go is pressed")
            
            Global.shared.enabled = true //add all array
            Global.shared.stopis = true   //stopcamer
            CameraOpen().Stopsessyion()

            trytocallSCene()  //GO TOSKSCENE
            
            
            //!!!!!!!!!!!!!!!    Global.shared.allLablels = []
            print("again open camera ")
            Global.shared.stopis = false  //OPEN CAMERA
            Global.shared.enabled = false //not appned array
            //!!!!!!!!!!!!!!!   CameraOpen().viewDidLoad()   //call class CameraOpen

            
            
            //        print("session.isRunning",session.isRunning )
            //        if session.isRunning {
            //                DispatchQueue.global().async {
            //                print("STOP Session")
            //                    self.session.stopRunning()
            //                }
            //            }
        }
    
    func sethint()
    {
        
        let db = Firestore.firestore()
        let sharedEmail = Global.shared.useremailshare
           
                        
                        Task {
                            db.collection("Child").whereField("email", isEqualTo:sharedEmail).getDocuments{
                                (snapshot, error) in
                                if let error = error {
                                    print("FAIL ")
                                }
                                else{
                                    print("SUCCESS??")
                                   }
                                
                           
                            }
                            
                            guard let id = try await db.collection("Child").whereField("email", isEqualTo: sharedEmail ).getDocuments().documents.first?.documentID else {
                             return
                            }
                            print("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh")

                            try await db.collection("Child").document(id).setData([
                  
                                "FirstGameHintIsUsed": false ,
                  
                            ],merge: true) { err in
                                if let err = err {
                                    print("Error   : \(err)")
                                } else {
                                    print("add ")
                                }
            
                            }
                          
                            }
//        let db = Firestore.firestore()
//
//        Task {
//
//            db.collection("Child").whereField("email", isEqualTo: Global.shared.useremailshare).getDocuments{
//            (snapshot, error) in
//            if let error = error {
//                print("FAIL ")
//            }else{
//               print("SUCCESS??")
//           }
//            }
//
//        }
//
//
//        guard let id = await db.collection("Child").whereField("email", isEqualTo:Global.shared.useremailshare).getDocuments().documents.first?.documentID else {
//
//                                     return
//                                 }
//
//                 db.collection("Child").document(id).setData([
//
//                "FirstGameHintIsUsed": FirstGame.isUsed
//
//                                 ],merge: true) { err in
//                                     if let err = err {
//                                         print("Error   : \(err)")
//                                     } else {
//                                         print("add ")
//                                     }
//
//                                 }
//
           
            }
    }

