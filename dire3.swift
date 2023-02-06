//
//  dire3.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/07/1444 AH.//
//

import UIKit

class dire3: UIViewController {

    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var viewInstruction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        backButton.layer.cornerRadius =       backButton.frame.width/2
         backButton.layer.borderWidth = 6
         backButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
         backButton.clipsToBounds = true
         
        
       hintButton.layer.cornerRadius =          hintButton.frame.width/2
        hintButton.layer.borderWidth = 6
        hintButton.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        hintButton.clipsToBounds = true
        
        viewInstruction.layer.cornerRadius =       viewInstruction.frame.width/2
        viewInstruction.layer.borderWidth = 6
        viewInstruction.layer.borderColor =   #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        viewInstruction.clipsToBounds = true
         
         

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
