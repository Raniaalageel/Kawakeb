//
//  SecondGame.swift
//  Kawakeb
//
//  Created by Sara Alsaleh on 13/06/1444 AH.
//

import UIKit

class SecondGame: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    
    @IBAction func logoutGame(_ sender: UIButton) {
        print("logout")
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
                let alertVC = storyboard.instantiateViewController(withIdentifier: "logoutto2") as! AlertLogout2
        
        present(alertVC, animated: true)
        
    }
}
