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
import FirebaseFirestore

class FirstGame: UIViewController {

       
    let db = Firestore.firestore()
    
    var scene: FirstSKScene?
        override func viewDidLoad() {
            super.viewDidLoad()
            print("nn")
        //!!!!
            Global.shared.allLablels = ["left:9:9","left:8:9","up:9:9"]
     //!!!!!!!!!!!!!!CameraOpen().viewDidLoad()
            
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
            
           
            
//            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                sceneView.removeFromSuperview()
//            }
            
            
            
            
    //        let v = UILabel(frame: .init(x: 100, y: 100, width: 100, height: 60))
    //        v.text = "Hello"
    //        self.view.addSubview(v)
        }
        
    @IBAction func logoutButton(_ sender: UIButton) {
        
        print("logout")
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutto") as! AlertLogout
        
        present(alertVC, animated: true)
        
        
    }
    
        @IBAction func gobutton(_ sender: UIButton) {
            print("go is pressed")
            
            Global.shared.enabled = true //add all array
            Global.shared.stopis = true   //stopcamer
            CameraOpen().Stopsessyion()

            
            if(Global.shared.allLablels.isEmpty){
                
                print("Global.shared.allLablels.isEmpty")
                
                let storyboard = UIStoryboard(name: "Main", bundle: .main)
                        let alertVC = storyboard.instantiateViewController(withIdentifier: "Emptyy") as! EmptyArray
                
                present(alertVC, animated: true)
                
            }else {
            trytocallSCene()  //GO TOSKSCENE
            
            
            //!!!!!!!!!!!!!!!Global.shared.allLablels = []
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

   }
