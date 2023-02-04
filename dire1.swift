//
//  dire1.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/07/1444 AH.
//

import UIKit

class dire1: UIViewController {

    @IBOutlet weak var backButton: UIButton!
   
    @IBOutlet weak var instr: UIButton!
    
    @IBOutlet weak var hint: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius =       backButton.frame.width/2
         backButton.layer.borderWidth = 6
         backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         backButton.clipsToBounds = true
        
        
      instr.layer.cornerRadius =        instr.frame.width/2
        instr.layer.borderWidth = 6
        instr.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        instr.clipsToBounds = true
        
        
     hint.layer.cornerRadius =         hint.frame.width/2
        hint.layer.borderWidth = 6
        hint.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hint.clipsToBounds = true
    }
    

    
}
