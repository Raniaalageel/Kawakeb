//
//  AlertLogout2.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 26/06/1444 AH.
//

import UIKit

class AlertLogout2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func yesgog(_ sender: Any) {
        print("yes go out")
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
        let vcc = storyboardd.instantiateViewController(withIdentifier: "Secondg") as! SecondGame
        vcc.view.frame = (self.view?.frame)!
        vcc.view.layoutIfNeeded()
        UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
        self.view?.window?.rootViewController = vcc
        }, completion: { completed in

        })
    }
}
