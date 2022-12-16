//
//  Login.swift
//  Kawakeb
//
//  Created by Amani Aldahmash on 15/12/2022.
//


import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import CoreMedia
//var useremailshare : String = ""



class loginController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var emailTextfiled: UITextField!
    
    @IBOutlet weak var passwordTextfiled: UITextField!
 
    
    @IBOutlet weak var validationMassege: UILabel!
    
    
    @IBOutlet weak var validationMessegepass: UILabel!

    @IBOutlet weak var buttonlogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationMassege.isHidden = true
        validationMessegepass.isHidden = true
        self.emailTextfiled.delegate = self
      
        self.passwordTextfiled.delegate = self
        self.tabBarController?.tabBar.isHidden = true
        // Do any additional setup after loading the view.
        
    //    self.emailTextfiled.text = " 1232@lecture.ksu.edu.sa"
     //   self.passwordTextfiled.text = "12345678"
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
        validationMassege.isHidden = true   // not show
        validationMessegepass.isHidden = true
        
        guard let email = emailTextfiled.text?.trimmingCharacters(in: .whitespaces).lowercased() , !email.isEmpty
        else {
            validationMassege.isHidden = false
            validationMassege.text = "please enter your email"
            return (false, "", "")
        }
        guard let password = passwordTextfiled.text, !password.isEmpty else {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "please enter your password"
            return (false, "", "")
        }
        if !isValidEmail(emailID: email) {
            validationMassege.isHidden = false
            validationMassege.text = "Please enter a valid email address"
            return (false, "", "")
        }
      /*  if password.count != 8 {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "Please enter password with 8 number "
            return (false, "", "")
        }*/
        
        
        return (true, email, password)
    }
        
        
        
        
  
    @IBAction func loginpressed(_ sender: Any) {
    
    
            let validationResult = isValid()
            if validationResult.0 == false {
                return
            }
            
            let email = validationResult.1
            let password = validationResult.2
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e=error{   //if no connect with firebase
                    print("failed")
                    let alert = UIAlertController(title: "Error", message: "No exist user ,try agin", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                   // print(e)
                }else{   //user Auth in firebase
                    print("sucsses")
                    
                    Task {
                        let db = Firestore.firestore()
                        if await self.checkEmailExist(email: email, collection: "Unistudent", field: "StudentEmail") {
                        
                            if await !self.checkEmailExist(email: email, collection: "Appstudent", field: "StudentEmail") {
                                await self.storeUserInformation(collection: "Appstudent", data: ["StudentEmail": email])
                            }
            
                            print("student exists")
                       //     Global.shared.useremailshare = email
                            
                            guard let stidentis = try await db.collection("Unistudent").whereField("StudentEmail", isEqualTo:  Global.shared.useremailshare ).getDocuments().documents.first?.documentID else {return}
                                                       
                                                       try await db.collection("Unistudent").document(stidentis).setData([
                                                           "token": Global.shared.Token
                                                       ],merge: true) { err in
                                                           if let err = err {
                                                               print("not Add token  : \(err)")
                                                           } else {
                                                               print(" Add token sucsseful ")
                                                           } }

                            self.performSegue(withIdentifier: "gotoStudents", sender: self)

                      //      print("this is the email amani: " + email)
                         //   print("this is the global amani: " + Global.shared.useremailshare)
                            // students view
                        }
//                            if await !self.checkEmailExist(email: email, collection: "Lecturer", field: "EmailLecture") {
//                                await self.storeUserInformation(collection: "Lecturer", data: ["EmailLecture": email])
//                            }
                           // self.NotificationLec()
                           // self.LectureNotificationForm()
                          //  if self.isValidEmailLectures(emailID: email) == true  {
                              //  self.storeLecturesInformation() }
                         //MODHI & Y
                          //  Global.shared.useremailshare = email
                        
                        else {
                            print("does not exist")
                            let alert = UIAlertController(title: "Error", message: "User  is not  registered.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            //  self.storeUserInformation()
                            // self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            // Global.shared.useremailshare = email
                            
                        } //end else
                        
                    }  //end tak
                } //end elsee
                
                    

            } //end sign in
        }   //end loginpressed
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailSttudent(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailLectures(emailID:String) -> Bool {
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    
    //end
    
    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
       // print("what??")
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
        
        //return false
    }
    
    func storeUserInformation(collection: String, data: [String: Any]) async {
        //  var ref: DocumentReference? = nil
        // guard let uid=Auth.auth().currentUser?.uid else {return }
        let db = Firestore.firestore()
        do {
            try await db.collection(collection).document().setData(data)
        } catch {
            print(error.localizedDescription)
        }
    }  //end func
       
}
