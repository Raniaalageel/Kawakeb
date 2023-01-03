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
        Global.shared.allLablels = ["left","left"]
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
    
}
