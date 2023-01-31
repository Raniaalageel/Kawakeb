//
//  AlertLogout3ViewController.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 05/07/1444 AH.
//

import UIKit

class AlertLogout3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func yesgog(_ sender: Any) {
        print("yes go out")
        Global.shared.GoBackHomeStopCamera = false
        let storyboardd = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboardd.instantiateViewController(withIdentifier: "HomeVC") as! Gamespage
        vcc.view.frame = (self.view?.frame)!
        vcc.view.layoutIfNeeded()
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
        self.view?.window?.rootViewController = vcc
        }, completion: { completed in

        })
        
    }
    
    @IBAction func nokeepniPage(_ sender: Any) {
        print("yes go out")
        
        let storyboardd = UIStoryboard(name: "Main", bundle: nil)
        let vcc = storyboardd.instantiateViewController(withIdentifier: "Thirddg") as! ThirdGame
        vcc.view.frame = (self.view?.frame)!
        vcc.view.layoutIfNeeded()
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
        self.view?.window?.rootViewController = vcc
        }, completion: { completed in

        })
    }

    

}