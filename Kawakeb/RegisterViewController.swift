//
//  RegisterViewController.swift
//  Kawakeb
//
//  Created by Rania Alageel on 21/05/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth




class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var bithdayTextField: UITextField!
    
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var boy: UIButton!
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var CreateAccountButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.emailTextField.delegate = self
//        self.passwordTextField.delegate = self
        
        
    }
    
    
    @IBAction func CreateAccountPressed(_ sender: UIButton) {
        
//        guard let email = emailTextField.text else {return}
//        guard let password = passwordTextField.text else {return}
//            Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
//                if let e = error {
//                    print(e.localizedDescription)
//                   }else {
//                     // Go to our home screen
//                    self.performSegue(withIdentifier: "goToNext", sender: self)
//                }
//            }
        }
  
    
    

//    func Birthday() {
//
//    }
    
}



