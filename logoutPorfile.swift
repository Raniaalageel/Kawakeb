//
//  logoutPorfile.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 20/07/1444 AH.
//

import UIKit

class logoutPorfile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    @IBAction func yesgo(_ sender: Any) {
        Global.shared.choose = true
        let storyboardd = UIStoryboard(name: "Main", bundle: nil)
                                 let vcc = storyboardd.instantiateViewController(withIdentifier: "logout") as! ViewController
                                 vcc.view.frame = (self.view?.frame)!
                                 vcc.view.layoutIfNeeded()
                                 UIView.transition(with: self.view!, duration: 0.3, options: .transitionFlipFromRight, animations:{
                                 self.view?.window?.rootViewController = vcc
                                 }, completion: { completed in
       
                                 })
        
    }
    
    
   
    
    
}
