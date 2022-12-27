//
//  FirstGame.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 03/06/1444 AH.
//


import UIKit
import AVFoundation
import Vision

class FirstGame: UIViewController {

       
       
       override func viewDidLoad() {
           super.viewDidLoad()
           print("nn")
           
   trytocall()
       }
       func trytocall(){
           CameraOpen().viewDidLoad()
       }
       

       @IBAction func gobutton(_ sender: UIButton) {
           print("go is pressed")
           Global.shared.enabled = true
           Global.shared.stopis = true
           
         CameraOpen().Stopsessyion()
   //        print("session.isRunning",session.isRunning )
   //        if session.isRunning {
   //                DispatchQueue.global().async {
   //                print("STOP Session")
   //                    self.session.stopRunning()
   //                }
   //            }
      }

   }
