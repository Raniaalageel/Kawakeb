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

class FirstGame: UIViewController {

       
       
    var scene: FirstSKScene?
        override func viewDidLoad() {
            super.viewDidLoad()
            print("nn")
            Global.shared.allLablels = ["left:0:500","left:200:2","up:2:2"]
                                        
                                        //"up:22:1"]
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
         //   scene.scaleMode = .fill //new
            sceneView.presentScene(scene)
            self.view.addSubview(sceneView)
            
           // sceneView.ignoresSiblingOrder = true  //new
           // sceneView.showsFPS = true  //new
           // sceneView.showsNodeCount = true //new
            
//!!!            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//                sceneView.removeFromSuperview()
// !!           }
            
    //        let v = UILabel(frame: .init(x: 100, y: 100, width: 100, height: 60))
    //        v.text = "Hello"
    //        self.view.addSubview(v)
        }
    func moveto(){
        if (Global.shared.WinFail == true){
            performSegue(withIdentifier: "gofail", sender: nil)

            print("Global.shared.WinFail == true")
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertFail") as! AlertFail
            
           // view.window?.rootViewController!.present(alertVC, animated: true,completion: nil)

            present(alertVC, animated: true,completion: nil)

       }
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

   }



