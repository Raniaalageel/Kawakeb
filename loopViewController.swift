//
//  loopViewController.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 17/07/1444 AH.
//

import UIKit

class loopViewController: UIViewController {

    @IBOutlet weak var back: UIButton!
    
    
    @IBOutlet weak var dire: UIButton!
    @IBOutlet weak var hint: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Global.shared.audiomsgP3 .pause()
        
       back.layer.cornerRadius =        back.frame.width/2
        back.layer.borderWidth = 6
        back.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        back.clipsToBounds = true
        
        dire.layer.cornerRadius =     dire.frame.width/2
        dire.layer.borderWidth = 6
        dire.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        dire.clipsToBounds = true
        
        
        hint.layer.cornerRadius =       hint.frame.width/2
        hint.layer.borderWidth = 6
        hint.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hint.clipsToBounds = true
        
    }
    

    

}
