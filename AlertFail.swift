//
//  AlertFail.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 10/06/1444 AH.
//

import UIKit
import SpriteKit

import AVFoundation
import Vision



class AlertFail: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
print("in the alerfail")
        
//        let vc = AlertFail() //change this to your class name
//        self.present(vc, animated: true, completion: nil)
        
        //calling()
    }
    
    
    func calling(){
        print("HELLO")
        //let yourVC = AlertFail()
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let alertVC = storyboard.instantiateViewController(withIdentifier: "AlertFail") as! AlertFail
        
        
       // self.view.window?.rootViewController?.present(alertVC, animated: true)
        let registerViewController = self.storyboard?.instantiateViewController(withIdentifier: "AlertFail") as! AlertFail
        self.present(registerViewController, animated: true)
       // self.view.window?.rootViewController?.present(self, animated: true)
    }
    
    
    
   

    @IBAction func tryagain(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc  = storyboard.instantiateViewController(withIdentifier: "Firstautard") as! FirstGame
        present(vc, animated: false, completion: nil)
    }
    

}
