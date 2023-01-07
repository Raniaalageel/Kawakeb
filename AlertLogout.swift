//
//  AlertLogout.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/06/1444 AH.
//

import UIKit

class AlertLogout: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    @IBAction func logoutGame(_ sender: UIButton) {
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
    
    
    
    @IBAction func nokeep(_ sender: Any) {
    
    print("yes go out")
    
    let storyboardd = UIStoryboard(name: "Main", bundle: nil)
    let vcc = storyboardd.instantiateViewController(withIdentifier: "Firstautard") as! FirstGame
    vcc.view.frame = (self.view?.frame)!
    vcc.view.layoutIfNeeded()
    UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
    self.view?.window?.rootViewController = vcc
    }, completion: { completed in

    })

    }
    
    }
    

