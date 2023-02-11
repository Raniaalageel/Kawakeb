//
//  dire2.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/07/1444 AH.
//

import UIKit

class dire2: UIViewController {

    @IBOutlet weak var hin: UIButton!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var arrow: UIImageView!
    
    @IBOutlet weak var instr: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.layer.cornerRadius =       backButton.frame.width/2
         backButton.layer.borderWidth = 6
         backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         backButton.clipsToBounds = true
        
        
        
       hin.layer.cornerRadius =           hin.frame.width/2
        hin.layer.borderWidth = 6
        hin.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hin.clipsToBounds = true
        
        
        instr.layer.cornerRadius =        instr.frame.width/2
        instr.layer.borderWidth = 6
        instr.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        instr.clipsToBounds = true
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
      print("2.5")
            UIView.animate(withDuration: 0.2, animations: {
                self.arrow.frame.origin.y -= -110
            },completion: nil)
            
    }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            print("4.5")
            UIView.animate(withDuration: 0.2, animations: {
                self.arrow.frame.origin.y -= -110
            },completion: nil)
            
    }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
      
            print("6.5")
            UIView.animate(withDuration: 0.2, animations: {
                self.arrow.frame.origin.y -= -120
            },completion: nil)
    }
        
        
        
        
        
    }
    

}
