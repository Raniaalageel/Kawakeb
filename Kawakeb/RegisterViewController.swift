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
import CoreMedia



class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var Emailvalidation: UILabel!
    @IBOutlet weak var Passwordvalidation: UILabel!
    @IBOutlet weak var FirstButton: UIButton!
    
    
    @IBOutlet weak var bithdayTextField: UITextField!
    
    @IBOutlet weak var girl: UIButton!
    @IBOutlet weak var boy: UIButton!
    
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!

    @IBOutlet weak var CreateAccountButton: UIButton!
    
    var Lemail: String = ""
    var Lpassword = ""
    var bod = ""
    var Character = ""
    var CharacterName = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
//        Emailvalidation.isHidden = true
//        Passwordvalidation.isHidden = true
//        self.emailTextField.delegate = self
//        self.passwordTextField.delegate = self
//        self.tabBarController?.tabBar.isHidden = true
////        self.emailTextField.text = "rania@gmail.com"
////        self.passwordTextField.text = "12345678"
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action:nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.resignFirstResponder()
        return(true)
    }
    //touch out
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //return key
    
    
    
    func isValid() -> (Bool, String, String) {
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "الرجاء إدخال البريد الالكتروني"
            return (false, "", "")
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "الرجاء إدخال كلمة المرور"
            return (false, "", "")
        }
        if !isValidEmail(emailID: email) {
            Emailvalidation.isHidden = false
            Emailvalidation.text = "الرجاء إدخال بريد الكتروني صحيح !"
            return (false, "", "")
        }
        if password.count != 8 {
            Passwordvalidation.isHidden = false
            Passwordvalidation.text = "الرجاء إدخال كلمة مرور مكونة من ٨ أرقام!"
            return (false, "", "")
        }
        
        
        return (true, email, password)
    }
    
    
    
    
    
    @IBAction func FirstButton(_ sender: UIButton) {
        
        Emailvalidation.isHidden = true
        Passwordvalidation.isHidden = true
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.tabBarController?.tabBar.isHidden = true
//        self.emailTextField.text = "rania@gmail.com"
//        self.passwordTextField.text = "12345678"
        
     
        let validationResult = isValid()
        if validationResult.0 == false {return}
        
        
        
        let email = validationResult.1
        let password = validationResult.2
        
        print("email : " , email)
        print("password : " , password)
        
        Lemail = email
        Lpassword = password
        Global.shared.useremailshare = email
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult , error in
                      if let e = error {
                          self.performSegue(withIdentifier: "goToBirthday", sender: self)
                        print("not exists email")
                         }else {
                             print("email exists")
                             self.Emailvalidation.isHidden = false
                             self.Emailvalidation.text = "الرجاء تغيير البريد الاكتروني"
                             
                            
                      }
                  }

       


//        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
//            if let e=error{   //if no connect with firebase
//                print("not exist child")
//                self.performSegue(withIdentifier: "goToBirthday", sender: self)
//
//               }else{   //user Auth in firebase
//                print("failed")
//                let alert = UIAlertController(title: "Error", message: "الرجاء تغيير البريد الالكتروني", preferredStyle: .alert)
//               }// end else
//        }//Auth
//                  //                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  //                           self.present(alert, animated: true, completion: nil)
//                Task {
//                    let db = Firestore.firestore()
//                    if await self.checkEmailExist(email: email, collection: "Child", field: "email") {
//
//                        print("child exists")
//                           print("failed")
//                           let alert = UIAlertController(title: "Error", message: "الرجاء تغيير البريد الالكتروني", preferredStyle: .alert)
//                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                           self.present(alert, animated: true, completion: nil)
//                    }else {
//                        print("not exists")
//                        self.performSegue(withIdentifier: "goToBirthday", sender: self)
//                        }
//
//            } //Task
}// func
    

    
    
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    
    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
            print("COUNT ", snapshot.count)
            print("not added")
            return snapshot.count != 0
        } catch {
            print(error.localizedDescription)
            print("added")
            return false
        }
    }
    
    
    
    
    func storeUserInformation(collection: String, data: [String: Any]) async {
        
        let db = Firestore.firestore()
        do {
            try await db.collection(collection).document().setData(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
    
//    @IBAction func CreateAccountPressed(_ sender: UIButton) {
//
////        guard let email = emailTextField.text else {return}
////        guard let password = passwordTextField.text else {return}
////            Auth.auth().createUser(withEmail: email, password: password) { authResult , error in
////                if let e = error {
////                    print(e.localizedDescription)
////                   }else {
////                     // Go to our home screen
////                    self.performSegue(withIdentifier: "goToNext", sender: self)
////                }
////            }
//        }
  
    

    
}



