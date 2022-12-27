//
//  runCamerAB.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 01/06/1444 AH.
//

import UIKit
import AVFoundation
import Vision


class runCamerAB: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate  {
    
    let session = AVCaptureSession()
    //commit
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("nn")
//        var cameris = CameraView()
//        cameris.setupAVCapture()
//        cameris.setupLayers()
//        cameris.setupVision()
        
trytocall()
    }
    func trytocall(){
        CameraView().viewDidLoad()
    }
    

    @IBAction func gobutton(_ sender: UIButton) {
        print("go is pressed")
        
        Global.shared.enabled = true
        Global.shared.stopis = true
        
       CameraView().Stopsessyion()
        
//        print("session.isRunning",session.isRunning )
//        if session.isRunning {
//                DispatchQueue.global().async {
//                print("STOP Session")
//                    self.session.stopRunning()
//                }
//            }
   }
    

}
